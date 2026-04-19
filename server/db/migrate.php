<?php
/**
 * migrate.php — PostgreSQL database initialiser for cothink
 *
 * Reads server/db/init.sql and executes it against the PostgreSQL database
 * supplied via the DATABASE_URL environment variable.
 *
 * Idempotent: every CREATE TABLE uses IF NOT EXISTS, so re-running this
 * script on an already-initialised database is safe.
 *
 * Usage (CLI):
 *   php /var/www/html/server/db/migrate.php
 */

// ── 1. Resolve DATABASE_URL ──────────────────────────────────────────────────
$databaseUrl = getenv('DATABASE_URL');

if (!$databaseUrl) {
    fwrite(STDERR, "[migrate] ERROR: DATABASE_URL environment variable is not set.\n");
    exit(1);
}

// Parse the URL into PDO DSN components.
// Expected format: postgresql://user:password@host:port/dbname
$parts = parse_url($databaseUrl);

if ($parts === false || empty($parts['host'])) {
    fwrite(STDERR, "[migrate] ERROR: Could not parse DATABASE_URL.\n");
    exit(1);
}

$host   = $parts['host'];
$port   = $parts['port']   ?? 5432;
$dbname = ltrim($parts['path'] ?? '', '/');
$user   = $parts['user']   ?? '';
$pass   = $parts['pass']   ?? '';

$dsn = "pgsql:host={$host};port={$port};dbname={$dbname}";

// ── 2. Connect ───────────────────────────────────────────────────────────────
try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    fwrite(STDERR, "[migrate] ERROR: Could not connect to database: " . $e->getMessage() . "\n");
    exit(1);
}

// ── 3. Check whether the schema already exists ───────────────────────────────
// Use the presence of the `categories` table as a sentinel.
try {
    $stmt = $pdo->query(
        "SELECT to_regclass('public.categories') AS tbl"
    );
    $row = $stmt->fetch();

    if (!empty($row['tbl'])) {
        echo "[migrate] Schema already initialised — skipping.\n";
        exit(0);
    }
} catch (PDOException $e) {
    fwrite(STDERR, "[migrate] WARNING: Could not check existing schema: " . $e->getMessage() . "\n");
    // Continue and attempt to run the migration anyway.
}

// ── 4. Load init.sql ─────────────────────────────────────────────────────────
$sqlFile = __DIR__ . '/init.sql';

if (!file_exists($sqlFile)) {
    fwrite(STDERR, "[migrate] ERROR: init.sql not found at {$sqlFile}\n");
    exit(1);
}

$sql = file_get_contents($sqlFile);

if ($sql === false || trim($sql) === '') {
    fwrite(STDERR, "[migrate] ERROR: init.sql is empty or unreadable.\n");
    exit(1);
}

// ── 5. Execute ───────────────────────────────────────────────────────────────
try {
    $pdo->exec($sql);
    echo "[migrate] Database schema initialised successfully.\n";
} catch (PDOException $e) {
    fwrite(STDERR, "[migrate] ERROR: Migration failed: " . $e->getMessage() . "\n");
    exit(1);
}
