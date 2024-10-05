<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Professional Experience</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0px;
            background-color: #f4f4f4;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        #experience-container {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .experience-entry {
            margin-bottom: 15px;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        .add-more-button {
            background-color: #007bff;
            margin-left: 10px;
            margin-right: 10px;
        }

        .add-more-button:hover {
            background-color: #0056b3;
        }
        .tabs {
                display: flex;
                background-color: #007bff;
                justify-content: center;
            }

            .tabs button {
                background-color: inherit;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 14px 16px;
                color: white;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            .tabs button:hover {
                background-color: #0056b3;
            }

            .tabs button.active {
                background-color: #0056b3;
            }

            .tab-content {
                display: none;
                padding: 20px;
                border: 1px solid #ddd;
                border-top: none;
                background-color: white;
                margin-top: -1px;
            }

            .tab-content.active {
                display: block;
            }
    </style>
</head>
<body>
    <% String fid = (String) session.getAttribute("fid"); %>
    <div class="tabs">
        <button class="tablinks" onclick="location.href = 'faculty.jsp?fid=<%= fid %>';">Home</button>
        <button class="tablinks" onclick="window.location.href = 'login.jsp'">LOGOUT</button>
    </div>
    <h2>Add Professional Experience</h2>

    <form action="add_professional_experience_action.jsp" method="post">
        <div id="experience-container">
            <div class="experience-entry">
                <input type="hidden" name="faculty_id[]" value="<%= fid %>">

                <label for="designation">Designation:</label>
                <input type="text" name="designation[]" required>

                <label for="institution">Institution/Organization:</label>
                <input type="text" name="institution[]" required>

                <label for="period">Period:</label>
                <input type="text" name="period[]" required>

                <label for="nature_of_duties">Nature of Duties:</label>
                <input type="text" name="nature_of_duties[]" required>
            </div>
        </div>
        <button type="button" class="add-more-button" onclick="addExperienceEntry()">Add More</button>
        <button type="submit">Submit</button>
    </form>

    <script>
        function addExperienceEntry() {
            const container = document.getElementById('experience-container');
            const newEntry = document.createElement('div');
            newEntry.classList.add('experience-entry');
            newEntry.innerHTML = `
                <input type="hidden" name="faculty_id[]" value="<%= fid %>">

                <label for="designation">Designation:</label>
                <input type="text" name="designation[]" required>

                <label for="institution">Institution/Organization:</label>
                <input type="text" name="institution[]" required>

                <label for="period">Period:</label>
                <input type="text" name="period[]" required>

                <label for="nature_of_duties">Nature of Duties:</label>
                <input type="text" name="nature_of_duties[]" required>
            `;
            container.appendChild(newEntry);
        }
    </script>

</body>
</html>
