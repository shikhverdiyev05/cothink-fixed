<?php
session_start();
require_once "../db.php";

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);

$name         = trim($data["name"] ?? '');
$email        = trim($data["email"] ?? '');
$linkedinLink = trim($data["linkedinLink"] ?? '');
$category     = intval($data["category"] ?? 0);
$password     = trim($data["password"] ?? '');

if (!$name || !$email || !$password) {
    echo json_encode(["error" => "Bütün xanaları doldurun"]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(["error" => "Email formatı yanlışdır"]);
    exit;
}

if ($category <= 0) {
    echo json_encode(["error" => "Kateqoriya seçilməlidir"]);
    exit;
}

if (strlen($password) < 8) {
    echo json_encode(["error" => "Şifrə ən azı 8 simvol olmalıdır"]);
    exit;
}

$check = $pdo->prepare("SELECT mentor_id FROM mentors WHERE mentor_email = ?");
$check->execute([$email]);

if ($check->rowCount() > 0) {
    echo json_encode(["error" => "Bu email ilə artıq qeydiyyat var"]);
    exit;
}

$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

$query = $pdo->prepare("
    INSERT INTO mentors (mentor_name, mentor_email, linkedn_link, category_id, mentor_password)
    VALUES (?, ?, ?, ?, ?)
");

try {
    $query->execute([$name, $email, $linkedinLink, $category, $hashedPassword]);
} catch (Exception $e) {
    echo json_encode(["error" => "DB error: " . $e->getMessage()]);
    exit;
}

$mentor_id = $pdo->lastInsertId();
$_SESSION["mentor_id"] = $mentor_id;
$token = bin2hex(random_bytes(32));

echo json_encode([
    "success" => true,
    "message" => "Mentor uğurla qeydiyyatdan keçdi",
    "mentor_id" => $mentor_id,
    "name" => $name,
    "email" => $email,
    "linkedinLink" => $linkedinLink,
    "category" => $category,
    "token" => $token
]);

exit;
?>