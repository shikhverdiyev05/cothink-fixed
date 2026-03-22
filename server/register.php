<?php
session_start();
require_once "db.php";

// CORS headers
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

try {
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $data = json_decode(file_get_contents("php://input"), true);

    if (!$data) {
        echo json_encode(["error" => "Göndərilən məlumat oxunmadı"]);
        exit;
    }

    $type = trim($data["type"] ?? "");
    $email = trim($data["email"] ?? "");
    $password = trim($data["password"] ?? "");

    if (!$type || !$email || !$password) {
        echo json_encode(["error" => "Bütün xanalar doldurulmalıdır"]);
        exit;
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(["error" => "Email formatı düzgün deyil"]);
        exit;
    }

    if (strlen($password) < 8) {
        echo json_encode(["error" => "Şifrə ən azı 8 simvol olmalıdır"]);
        exit;
    }

    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    if ($type === "student") {
        $username = trim($data["username"] ?? "");

        if (!$username) {
            echo json_encode(["error" => "Ad tələb olunur"]);
            exit;
        }

        $check = $pdo->prepare("SELECT student_id FROM student_table WHERE student_email = ?");
        $check->execute([$email]);

        if ($check->rowCount() > 0) {
            echo json_encode(["error" => "Bu email ilə artıq student qeydiyyatı var"]);
            exit;
        }

        $query = $pdo->prepare("
            INSERT INTO student_table (student_name, student_email, student_password)
            VALUES (?, ?, ?)
        ");
        $query->execute([$username, $email, $hashedPassword]);

        $student_id = $pdo->lastInsertId();
        $_SESSION["student_id"] = $student_id;
        $token = bin2hex(random_bytes(32));

        echo json_encode([
            "success" => true,
            "type" => "student",
            "message" => "Student uğurla qeydiyyatdan keçdi",
            "student_id" => $student_id,
            "name" => $username,
            "email" => $email,
            "token" => $token
        ]);
        exit;
    }

    if ($type === "mentor") {
        $name = trim($data["name"] ?? "");
        $linkedinLink = trim($data["linkedinLink"] ?? "");
        $category = intval($data["category"] ?? 0);
        $position = "Teacher";

        if (!$name) {
            echo json_encode(["error" => "Ad boş ola bilməz"]);
            exit;
        }

        if ($category <= 0) {
            echo json_encode(["error" => "Kateqoriya seçilməlidir"]);
            exit;
        }

        $check = $pdo->prepare("SELECT mentor_id FROM mentors WHERE mentor_email = ?");
        $check->execute([$email]);

        if ($check->rowCount() > 0) {
            echo json_encode(["error" => "Bu email ilə artıq mentor qeydiyyatı var"]);
            exit;
        }

        $query = $pdo->prepare("
            INSERT INTO mentors (mentor_name, mentor_email, linkedn_link, category_id, mentor_password)
            VALUES (?, ?, ?, ?, ?)
        ");
        $query->execute([$name, $email, $linkedinLink, $category, $hashedPassword]);

        $mentor_id = $pdo->lastInsertId();
        $_SESSION["mentor_id"] = $mentor_id;
        $token = bin2hex(random_bytes(32));

        echo json_encode([
            "success" => true,
            "type" => "mentor",
            "message" => "Mentor uğurla qeydiyyatdan keçdi",
            "mentor_id" => $mentor_id,
            "name" => $name,
            "email" => $email,
            "linkedinLink" => $linkedinLink,
            "category" => $category,
            "position" => $position,
            "token" => $token
        ]);
        exit;
    }

    echo json_encode(["error" => "Düzgün qeydiyyat tipi seçilməyib (student | mentor)"]);
    exit;

} catch (PDOException $e) {
    echo json_encode([
        "error" => "Database xətası baş verdi",
        "details" => $e->getMessage()
    ]);
    exit;
} catch (Exception $e) {
    echo json_encode([
        "error" => "Gözlənilməz xəta baş verdi",
        "details" => $e->getMessage()
    ]);
    exit;
}
?>