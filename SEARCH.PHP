<?php
session_start();

$servername = "localhost";
$username = "Mazen";
$password = "1234";
$dbname = "exchange_market";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

function sanitizeInput($data) {
    return htmlspecialchars(strip_tags(trim($data)));
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $passport = sanitizeInput($_POST['passport']);
    $password_input = $_POST['password'];

    // Use prepared statement to avoid SQL injection
    $stmt = $conn->prepare("SELECT * FROM transactions WHERE passport = ?");
    $stmt->bind_param("s", $passport);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashed_password = $row["password"];

        if (password_verify($password_input, $hashed_password)) {
            $_SESSION['user_passport'] = $row['passport'];  // Updated line to store passport number
            setcookie("user_passport", $row['passport'], time() + 3600, "/");

            // Display information
            unset($row["password"]);
            foreach ($row as $key => $value) {
                echo $key . ": " . $value . "<br>";
            }
        } else {
            echo "Incorrect password.";
        }
    } else {
        echo "No results found for the given credentials.";
    }

    $stmt->close();
}

$conn->close();
?>
