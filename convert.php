<?php
$servername = "localhost";
$username = "Mazen";
$password = "1234";
$dbname = "Exchange_Market";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to sanitize input data
function sanitizeInput($data) {
    return htmlspecialchars(strip_tags(trim($data)));
}

// Start a new session
session_start();

// Process form data
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize and hash the password
    $name = sanitizeInput($_POST['name']);
    $passport = sanitizeInput($_POST['passport']);
    $email = sanitizeInput($_POST['email']);
    $phone = sanitizeInput($_POST['phone']);
    $date = sanitizeInput($_POST['date']);
    $password = password_hash($_POST['password'], PASSWORD_BCRYPT); // Use BCRYPT hashing
    $amountBefore = sanitizeInput($_POST['amountBefore']);
    $fromCurrency = sanitizeInput($_POST['fromCurrency']);
    $toCurrency = sanitizeInput($_POST['toCurrency']);
    $amountAfter = sanitizeInput($_POST['amountAfter']);

    // Check if the passport already exists in the 'users' table
    $checkPassportQuery = $conn->prepare("SELECT * FROM users WHERE passport = ?");
    $checkPassportQuery->bind_param("s", $passport);
    $checkPassportQuery->execute();
    $result = $checkPassportQuery->get_result();

    if ($result->num_rows > 0) {
        // Passport exists, update the data in 'users' table
        $updateUserQuery = $conn->prepare("UPDATE users SET name=?, email=?, phone=?, password=? WHERE passport=?");
        $updateUserQuery->bind_param("sssss", $name, $email, $phone, $password, $passport);

        if ($updateUserQuery->execute() === FALSE) {
            die("Error updating data in 'users' table: " . $updateUserQuery->error);
        } else {
            echo '<script>alert("User data successfully updated.");</script>';
        }

        $updateUserQuery->close();
    } else {
        // Passport does not exist, insert data into 'users' table
        $userInsertQuery = $conn->prepare("INSERT INTO users (name, passport, email, phone, password) VALUES (?, ?, ?, ?, ?)");
        $userInsertQuery->bind_param("sssss", $name, $passport, $email, $phone, $password);

        if ($userInsertQuery->execute() === FALSE) {
            die("Error inserting data into 'users' table: " . $userInsertQuery->error);
        } else {
            echo '<script>alert("User data successfully inserted.");</script>';
        }

        $userInsertQuery->close();
    }

    $checkPassportQuery->close();

    // Insert or update data in 'transactions' table
    $transactionsQuery = $conn->prepare("SELECT * FROM transactions WHERE passport = ?");
    $transactionsQuery->bind_param("s", $passport);
    $transactionsQuery->execute();
    $result = $transactionsQuery->get_result();

    if ($result->num_rows > 0) {
        // Passport exists, update the data in 'transactions' table
        $updateTransactionsQuery = $conn->prepare("UPDATE transactions SET password=?, date=?, amountBefore=?, Fromcurrency=?, Tocurrency=?, amountAfter=? WHERE passport=?");
        $updateTransactionsQuery->bind_param("sssssss", $password, $date, $amountBefore, $fromCurrency, $toCurrency, $amountAfter, $passport);

        if ($updateTransactionsQuery->execute() === FALSE) {
            die("Error updating data in 'transactions' table: " . $updateTransactionsQuery->error);
        } else {
            echo '<script>alert("Transaction data successfully updated.");</script>';
        }

        $updateTransactionsQuery->close();
    } else {
        // Passport does not exist, insert data into 'transactions' table
        $transactionsInsertQuery = $conn->prepare("INSERT INTO transactions (passport, password, date, amountBefore, Fromcurrency, Tocurrency, amountAfter) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $transactionsInsertQuery->bind_param("sssssss", $passport, $password, $date, $amountBefore, $fromCurrency, $toCurrency, $amountAfter);

        if ($transactionsInsertQuery->execute() === FALSE) {
            die("Error inserting data into 'transactions' table: " . $transactionsInsertQuery->error);
        } else {
            echo '<script>alert("Transaction data successfully inserted.");</script>';
        }

        $transactionsInsertQuery->close();
    }

    $transactionsQuery->close();

    // Set session variables
    $_SESSION['username'] = $name;
    $_SESSION['passport'] = $passport;  // Updated line to store the passport instead of the phone number

    // Set cookies
    setcookie("user_name", $name, time() + (86400 * 30), "/"); // Cookie valid for 30 days
    setcookie("user_passport", $passport, time() + (86400 * 30), "/"); // Updated line to store the passport instead of the phone number

    // Close the connection
    $conn->close();

    header("Location: SEARCH.html");
    exit();
}
?>
