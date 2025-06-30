<?php
include 'db.php';

if (isset($_POST['create'])) {
    // Insert new user
    $stmt = $conn->prepare("INSERT INTO users (first_name, last_name, email, phone, username, password, address) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param(
        "sssssss",
        $_POST['first_name'],
        $_POST['last_name'],
        $_POST['email'],
        $_POST['phone'],
        $_POST['username'],
        password_hash($_POST['password'], PASSWORD_BCRYPT),
        $_POST['address']
    );
    $stmt->execute();
    $stmt->close();
    header("Location: index.php");
    exit;
}

if (isset($_POST['update'])) {
    // Update user
    $stmt = $conn->prepare("UPDATE users SET first_name = ?, last_name = ?, email = ?, phone = ?, username = ?, password = ?, address = ? WHERE id = ?");
    $stmt->bind_param(
        "sssssssi",
        $_POST['first_name'],
        $_POST['last_name'],
        $_POST['email'],
        $_POST['phone'],
        $_POST['username'],
        password_hash($_POST['password'], PASSWORD_BCRYPT),
        $_POST['address'],
        $_POST['id']
    );
    $stmt->execute();
    $stmt->close();
    header("Location: index.php");
    exit;
}

if (isset($_GET['delete'])) {
    // Delete user
    $id = intval($_GET['delete']);
    $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $stmt->close();
    header("Location: index.php");
    exit;
}

$conn->close();
?>
