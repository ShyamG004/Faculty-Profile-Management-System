<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Educational Qualifications</title>
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

        #qualification-container {
            margin-bottom: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .qualification-entry {
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
        input[type="number"],
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
    <% String fid = (String) session.getAttribute("fid");%>
<div class="tabs">
            
            <button class="tablinks" onclick="location.href = 'faculty.jsp?fid=<%= fid%>';">Home</button>
            <button class="tablinks" onclick="window.location.href = 'login.jsp'">LOGOUT</button>
        </div>
<h2>Add Educational Qualifications</h2>

<form action="add_qualification_action.jsp" method="post">
    <div id="qualification-container">
        <div class="qualification-entry">
            
            <input type="hidden" name="faculty_id[]" value="<%=fid%>">

            <label for="qual">Qualification:</label>
            <input type="text" name="qual[]" required>

            <label for="branch">Branch:</label>
            <input type="text" name="branch[]" required>

            <label for="institution">Institution:</label>
            <input type="text" name="institution[]" required>

            <label for="yr_pass">Year of Passing:</label>
            <input type="number" name="yr_pass[]" required>

            <label for="class_div">Class Division:</label>
            <input type="text" name="class_div[]" required>
        </div>
    </div>
    <button type="button" class="add-more-button" onclick="addQualificationEntry()">Add More</button>
    <button type="submit">Submit</button>
</form>

<script>
function addQualificationEntry() {
    const container = document.getElementById('qualification-container');
    const newEntry = document.createElement('div');
    newEntry.classList.add('qualification-entry');
    newEntry.innerHTML = `
        
        <input type="hidden" name="faculty_id[]" value="<%=fid%>">

        <label for="qual">Qualification:</label>
        <input type="text" name="qual[]" required>

        <label for="branch">Branch:</label>
        <input type="text" name="branch[]" required>

        <label for="institution">Institution:</label>
        <input type="text" name="institution[]" required>

        <label for="yr_pass">Year of Passing:</label>
        <input type="number" name="yr_pass[]" required>

        <label for="class_div">Class Division:</label>
        <input type="text" name="class_div[]" required>
    `;
    container.appendChild(newEntry);
}
</script>

</body>
</html>
