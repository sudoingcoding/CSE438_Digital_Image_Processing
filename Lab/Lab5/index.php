<?php
include 'db.php';

// Check if edit is requested
$edit_user = null;
if (isset($_GET['edit'])) {
    $id = intval($_GET['edit']);
    $result = $conn->query("SELECT * FROM users WHERE id = $id");
    if ($result->num_rows > 0) {
        $edit_user = $result->fetch_assoc();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h2 {
            text-align: center;
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        form label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #555;
        }

        form input, form textarea, form button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        form button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        form button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #007BFF;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            text-decoration: none;
            color: #007BFF;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Management System</h1>
        
        <!-- Form for Creating/Updating User -->
        <form action="process.php" method="POST">
            <input type="hidden" name="id" value="<?php echo $edit_user['id'] ?? ''; ?>">
            <label>First Name:</label>
            <input type="text" name="first_name" value="<?php echo htmlspecialchars($edit_user['first_name'] ?? ''); ?>" required>
            
            <label>Last Name:</label>
            <input type="text" name="last_name" value="<?php echo htmlspecialchars($edit_user['last_name'] ?? ''); ?>" required>
            
            <label>Email:</label>
            <input type="email" name="email" value="<?php echo htmlspecialchars($edit_user['email'] ?? ''); ?>" required>
            
            <label>Phone:</label>
            <input type="text" name="phone" value="<?php echo htmlspecialchars($edit_user['phone'] ?? ''); ?>">
            
            <label>Username:</label>
            <input type="text" name="username" value="<?php echo htmlspecialchars($edit_user['username'] ?? ''); ?>" required>
            
            <label>Password:</label>
            <input type="password" name="password" <?php echo isset($edit_user) ? '' : 'required'; ?>>
            
            <label>Address:</label>
            <textarea name="address" rows="4"><?php echo htmlspecialchars($edit_user['address'] ?? ''); ?></textarea>
            
            <?php if ($edit_user): ?>
                <button type="submit" name="update">Update</button>
            <?php else: ?>
                <button type="submit" name="create">Create</button>
            <?php endif; ?>
        </form>
        
        <!-- Display Users -->
        <h2>Users</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Username</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $result = $conn->query("SELECT * FROM users");
                while ($row = $result->fetch_assoc()) {
                    echo "<tr>
                        <td>{$row['id']}</td>
                        <td>{$row['first_name']}</td>
                        <td>{$row['last_name']}</td>
                        <td>{$row['email']}</td>
                        <td>{$row['phone']}</td>
                        <td>{$row['username']}</td>
                        <td>
                            <a href='index.php?edit={$row['id']}'>Update</a> |
                            <a href='process.php?delete={$row['id']}'>Delete</a>
                        </td>
                    </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>
