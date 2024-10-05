<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .form-container {
            width: 40%;
            margin: 100px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            margin-bottom: 5px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
        }
        input, select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
             width:95%;
        }
        select{
            width:100%;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border: none;
            padding: 12px;
            font-size: 16px;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .form-group-row {
            display: flex;
            justify-content: space-between;
        }
        .form-group-row > .form-group {
            flex: 1;
            margin-right: 15px;
        }
        .form-group-row > .form-group:last-child {
            margin-right: 0;
        }
        .navbar {
                background-color: #007BFF;
                display: flex;
                justify-content: flex-end; /* Aligns items to the right */
            }

            .navbar a {
                display: block;
                color: #f2f2f2;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }
    </style>
</head>
<body>
    <div class="navbar">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <a href="admin-login.jsp">Logout</a>
        </div>
    <div class="form-container">
        <h2>Faculty Registration</h2>
        <form action="register-action.jsp" class="form" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="fid">Faculty ID:</label>
                <input required type="text" id="fid" name="fid" placeholder="2013ME09">
            </div>

            <div class="form-group">
                <label for="name">Name:</label>
                <input required type="text" id="name" name="name" placeholder="Enter your name">
            </div>

            <div class="form-group">
                <label for="designation">Designation:</label>
                <input required type="text" id="designation" name="designation" placeholder="Assistant Professor (Sr. Grade)">
            </div>

            <div class="form-group">
                <label for="dept">Department:</label>
                <select id="dept" name="dept">
                    <option value="CS">Computer Science and Engineering</option>
                    <option value="EC">Electronics and Communication Engineering</option>
                    <option value="EE">Electrical and Electronics Engineering</option>
                    <option value="AD">Artificial Intelligence and Data Science</option>
                    <option value="CE">Civil Engineering</option>
                    <option value="ME">Mechanical Engineering</option>
                    <option value="IT">Information Technology</option>
                </select>
            </div>

            <div class="form-group-row">
                <div class="form-group">
                    <label for="doj">Date of Joining:</label>
                    <input required type="date" id="doj" name="doj">
                </div>

                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input required type="date" id="dob" name="dob">
                </div>
            </div>

            <div class="form-group-row">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input required type="email" id="email" name="email" placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label for="phone">Mobile Number:</label>
                    <input required type="tel" id="phone" name="phone" placeholder="Enter your phone number">
                </div>
            </div>

            <div class="form-group-row">
                <div class="form-group">
                    <label for="age">Age:</label>
                    <input required type="number" id="age" name="age" placeholder="Enter your age">
                </div>

                <div class="form-group">
                    <label for="gender">Sex:</label>
                    <select id="gender" name="gender">
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="marital">Marital Status:</label>
                <select id="marital" name="marital">
                    <option value="Married">Married</option>
                    <option value="Unmarried">Unmarried</option>
                </select>
            </div>

            <div class="form-group">
                <label for="citizenship">Citizenship:</label>
                <input required type="text" id="citizenship" name="citizenship" placeholder="Indian">
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input required type="password" id="password" name="password" placeholder="****">
            </div>

            <div class="form-group">
                <label for="cpsw">Confirm Password:</label>
                <input required type="password" id="cpsw" name="cpsw" placeholder="****">
            </div>

            <div class="form-group">
                <label for="profileImage">Upload Profile Image:</label>
                <input type="file" id="profileImage" name="profileImage" accept="image/*">
            </div>

            <input type="submit" name="submit" value="Register">
        </form>
    </div>

</body>
</html>
