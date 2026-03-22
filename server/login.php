<?php
require_once "db.php";
session_start();

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

$email = trim($data["email"] ?? '');
$password = trim($data["password"] ?? '');

if (!$email || !$password) {
    echo json_encode(["error" => "Email və şifrə tələb olunur"]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(["error" => "Email formatı düzgün deyil"]);
    exit;
}

try {
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // STUDENT LOGIN
    $stmt = $pdo->prepare("
        SELECT student_id, student_name, student_email, student_password
        FROM student_table
        WHERE student_email = ?
        LIMIT 1
    ");
    $stmt->execute([$email]);
    $student = $stmt->fetch(PDO::FETCH_ASSOC);

    if (
        $student &&
        (
            password_verify($password, $student["student_password"]) ||
            $password === $student["student_password"]
        )
    ) {
        $_SESSION["student_id"] = $student["student_id"];
        unset($_SESSION["mentor_id"]);

        $token = bin2hex(random_bytes(32));

        echo json_encode([
            "success" => true,
            "type"    => "student",
            "id"      => $student["student_id"],
            "name"    => $student["student_name"],
            "email"   => $student["student_email"],
            "token"   => $token
        ]);
        exit;
    }

    // MENTOR LOGIN
    $stmt = $pdo->prepare("
        SELECT mentor_id, mentor_name, mentor_email, mentor_password
        FROM mentors
        WHERE mentor_email = ?
        LIMIT 1
    ");
    $stmt->execute([$email]);
    $mentor = $stmt->fetch(PDO::FETCH_ASSOC);

    if (
        $mentor &&
        (
            password_verify($password, $mentor["mentor_password"]) ||
            $password === $mentor["mentor_password"]
        )
    ) {
        $_SESSION["mentor_id"] = $mentor["mentor_id"];
        unset($_SESSION["student_id"]);

        $token = bin2hex(random_bytes(32));

        echo json_encode([
            "success" => true,
            "type"    => "mentor",
            "id"      => $mentor["mentor_id"],
            "name"    => $mentor["mentor_name"],
            "email"   => $mentor["mentor_email"],
            "token"   => $token
        ]);
        exit;
    }

    echo json_encode(["error" => "Email və ya şifrə yanlışdır"]);
    exit;

} catch (Exception $e) {
    echo json_encode(["error" => "DB error: " . $e->getMessage()]);
    exit;
}
?>