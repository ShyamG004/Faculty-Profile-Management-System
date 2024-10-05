<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="java.sql.*, java.io.*" %>
<%
    String fid = (String) session.getAttribute("fid");

    if (fid == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Faculty Dashboard</title>
        <style>
            /* Styles here (remains unchanged) */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f9;
                color: #333;
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
            .faculty-profile{
                display:flex;
            }
            .faculty-details table {
                width: 85%;
                border-collapse: collapse;
                margin: 20px 0;
            }

            .faculty-details table, th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .faculty-details th {
                background-color: #f2f2f2;
                color: #333;
                font-weight: bold;
            }

            .faculty-details td {
                color: #555;
            }

            .faculty-details img {
                border: 1px solid black;
                padding: 5px;
                border-radius: 5px;
                cursor: pointer;
            }

            .add-items {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin: 20px 0;
                flex-wrap: wrap;
            }

            .add-items button {
                font-family: Arial, sans-serif;
                color: white;
                background-color: #007bff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s;
                border-radius: 5px;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
                min-width: 150px;
            }

            .add-items button:hover {
                background-color: #0056b3;
            }

            .add-items button:active {
                background-color: #004494;
            }

            button.edit-info {
                background-color: #28a745;
                min-width: 150px;
            }

            button.edit-info:hover {
                background-color: #218838;
            }

            button.edit-info:active {
                background-color: #1e7e34;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            button[type="submit"] {
                background-color: #28a745;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button[type="submit"]:hover {
                background-color: #218838;
            }

            button[type="submit"]:active {
                background-color: #1e7e34;
            }

            h2 {
                color: #007bff;
                margin-bottom: 20px;
                text-align: center;
            }

            h3 {
                color: #333;
            }

            h3, th {
                text-align: center;
            }

            input[type="file"] {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #f9f9f9;
            }

            form {
                max-width: 500px;
                margin: auto;
            }


            faculty-details{
                display: flex;
                justify-content: space-around;
                align-items: center;
                margin-bottom: 20px;
            }
            /* Dropdown container */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            /* Dropdown button */
            .dropbtn {
                background-color: #4CAF50;
                color: white;
                padding: 10px;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

            /* Dropdown content (hidden by default) */
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            /* Links inside the dropdown */
            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            /* Change color of dropdown links on hover */
            .dropdown-content a:hover {
                background-color: #f1f1f1
            }

            /* Show the dropdown menu on hover */
            .dropdown:hover .dropdown-content {
                display: block;
            }

            /* Change the background color of the dropdown button when the dropdown content is shown */
            .dropdown:hover .dropbtn {
                background-color: #3e8e41;
            }
.tabs {
    position: fixed; /* Makes the navbar fixed */
    top: 0; /* Positions it at the top of the page */
    width: 100%; /* Stretches the navbar across the width of the page */
    background-color: #007bff; /* Background color for the navbar */
    z-index: 1000; /* Ensures the navbar stays on top of other content */
    box-shadow: 0px 4px 2px -2px gray; /* Optional: Adds a shadow for better visibility */
}

.tablinks, .dropbtn {
    padding: 14px 20px;
    margin: 0;
    display: inline-block;
    background-color: #333;
    color: white;
    text-align: center;
    cursor: pointer;
    text-decoration: none;
    border: none;
}

.dropdown-content a {
    display: block;
    padding: 12px 16px;
    background-color: white;
    color: black;
    text-decoration: none;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown:hover .dropdown-content {
    display: block;
}

/* Ensures the rest of the page content is not hidden behind the navbar */
body {
    padding-top: 50px; /* Adjust the padding as per the height of your navbar */
}

        </style>
    </head>
    <body>


        <div class="tabs">
            <button class="tablinks" onclick="openTab(event, 'home')" id="defaultOpen">Home</button>

            <div class="dropdown">
                <button class="dropbtn">Add</button>
                <div class="dropdown-content">
                    <a href="add-education.jsp?fid=<%= fid%>">Educational Qualification</a>
                    <a href="add_professional_experience.jsp?fid=<%=fid%>">Professional Experience</a>
                    <a href="#" onclick="openTab(event, 'project')">Project</a>
                    <a href="#" onclick="openTab(event, 'conference')">Conference</a>
                    <a href="#" onclick="openTab(event, 'journal')">Journal</a>
                    
                </div>
            </div>

            <!-- Combined Show Button -->
            <div class="dropdown">
                <button class="dropbtn">Show</button>
                <div class="dropdown-content">
                    <a href="#eduData" onclick="showEducations()" id="b1">Educational Qualifications</a>
                    <a href="#expData" onclick="showExperience()" id="b2">Professional Experiences</a>
                    <a href="#projectData" onclick="showProjects()" id="b3">Projects</a>
                    <a href="#conferenceData" onclick="showConferences()" id="b4">Conferences</a>
                    <a href="#journelData" onclick="showJournals()" id="b5">Journals</a>
                </div>
            </div>
            <button class="tablinks" onclick="location.href = 'generateReport.jsp?fid=<%=fid%>';" >Download Profile</button>
            <button class="tablinks" onclick="window.location.href = 'login.jsp'">LOGOUT</button>
        </div>

        <!-- Home Tab Content -->
        <div id="home" class="tab-content active">
            <h2>Faculty Profile</h2>
            <div class="faculty-details">
                <%
                    try {
                        String url = "jdbc:derby://localhost:1527/fpms_db";
                        String user = "shyam";  // Your database username
                        String pass = "123";    // Your database password

                        conn = DriverManager.getConnection(url, user, pass);
                        String sql = "SELECT * FROM faculty WHERE fid = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, fid);

                        rs = ps.executeQuery();

                        if (rs.next()) {
                %>
                <div class="faculty-profile">
                    <table style="float:left;">
                        <tr><th>Name of the Staff</th><td> <%= rs.getString("name")%></td></tr>
                        <tr><th>Designation</th><td> <%= rs.getString("designation")%></td></tr>
                        <tr><th>Date of Joining</th><td> <%= rs.getDate("doj")%></td></tr>
                        <tr><th>Email Id</th><td> <%= rs.getString("email")%></td></tr>
                        <tr><th>Mobile Number</th><td> <%= rs.getString("phone")%></td></tr>
                        <tr><th colspan="2" style='text-align:center'><strong>Personal Details</strong></th></tr>
                        <tr><th>Age</th><td> <%= rs.getInt("age")%></td></tr>
                        <tr><th>Date of Birth</th><td> <%= rs.getDate("dob")%></td></tr>
                        <tr><th>Sex & Marital Status</th><td> <%= rs.getString("gender")%> & <%= rs.getString("marital")%></td></tr>
                        <tr><th>Citizenship</th><td> <%= rs.getString("citizenship")%></td></tr>
                    </table>
                    <div style="float:right; padding-left: 20px;">
                        <div style="position: relative;">
                            <img src="displayImage.jsp?fid=<%= rs.getString("fid")%>" alt="Faculty Image" width="150" height="150" style="border: 1px solid black; cursor: pointer;" onclick="document.getElementById('profileImageInput').click();">
                            <div style="margin-top: 10px;">
                                <form action="UploadImageServlet" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="fid" value="<%= fid%>">
                                    <input type="file" id="profileImageInput" name="profileImage" accept="image/*" style="display: none;" onchange="this.form.submit();" required>

                                    <button type="submit" style="background-color:#28a745; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; margin-bottom:10px;" onclick="document.getElementById('profileImageInput').click();">Change Profile Image</button>
                                </form>
                            </div>
                            <div >
                                <!-- Button to Change Password -->
                                <button class="edit-info" onclick="location.href = 'changePassword.jsp?fid=<%= rs.getString("fid")%>';" style="background-color: #28a745; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; margin-bottom:10px;">Change Password</button><br>
                                <button class="edit-info" onclick="location.href = 'editFaculty.jsp?fid=<%= rs.getString("fid")%>';" style="background-color:#28a745; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">Edit Information</button>
                            </div>
                        </div>
                    </div>


                </div>



                <%
                        } else {
                            out.println("<h3>Faculty details not found.</h3>");
                        }
                    } catch (Exception e) {
                        out.println(e);
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (ps != null) {
                            ps.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                %>
            </div>
            <div id="eduData" class="edu-data" style="margin-top: 20px;"></div>
            <div id="expData" class="exp-data" style="margin-top: 20px;"></div>
            <div id="projectData" class="project-data" style="margin-top: 20px;"></div>
            <div id="conferenceData" class="conference-data" style="margin-top: 20px;"></div>
            <div id="journelData" class="journal-data" style="margin-top: 20px;"></div>
        </div>

        <!-- Add Conference Tab Content -->
        <div id="conference" class="tab-content">
            <h2>Add Conference</h2>
            <form action="add-conference.jsp" method="post">
                <label for="confPaperId">Conference Paper ID:</label>
                <input type="text" id="confPaperId" name="confPaperId" required><br><br>

                <label for="titleOfPaper">Title of Paper:</label>
                <input type="text" id="titleOfPaper" name="titleOfPaper" required><br><br>

                <label for="confName">Conference Name:</label>
                <input type="text" id="confName" name="confName" required><br><br>

                <label for="authors">Authors:</label>
                <input type="text" id="authors" name="authors" required><br><br>

                <label for="pageStart">Page Start:</label>
                <input type="number" id="pageStart" name="pageStart" required><br><br>

                <label for="pageEnd">Page End:</label>
                <input type="number" id="pageEnd" name="pageEnd" required><br><br>

                <label for="year">Year:</label>
                <input type="number" id="year" name="year" required><br><br>

                <button type="submit">Add Conference</button>
            </form>
        </div>

        <!-- Add Journal Tab Content -->
        <div id="journal" class="tab-content">
            <h2>Add Journal</h2>
            <form action="add-journel.jsp" method="post">
                <label for="journalPaperId">Journal Paper ID:</label>
                <input type="text" id="journalPaperId" name="journalPaperId" required><br><br>

                <label for="paperTitle">Title of Paper:</label>
                <input type="text" id="paperTitle" name="paperTitle" required><br><br>

                <label for="journalName">Journal Name:</label>
                <input type="text" id="journalName" name="journalName" required><br><br>

                <label for="journalAuthors">Authors:</label>
                <input type="text" id="journalAuthors" name="journalAuthors" required><br><br>

                <label for="volume">Volume:</label>
                <input type="number" id="volume" name="volume" required><br><br>

                <label for="journalNumber">Number:</label>
                <input type="number" id="journalNumber" name="journalNumber" required><br><br>

                <label for="journalPageStart">Page Start:</label>
                <input type="number" id="journalPageStart" name="journalPageStart" required><br><br>

                <label for="journalPageEnd">Page End:</label>
                <input type="number" id="journalPageEnd" name="journalPageEnd" required><br><br>

                <label for="journalYear">Year:</label>
                <input type="number" id="journalYear" name="journalYear" required min="1900" max="2100"><br><br>

                <button type="submit">Add Journal</button>
            </form>
        </div>

        <!-- Add Project Tab Content -->
        <div id="project" class="tab-content">
            <h2>Add Project</h2>
            <form action="add-project.jsp" method="post">
                <label for="projectId">Project Id:</label>
                <input type="text" id="projectId" name="projectId" required><br><br>

                <label for="projectTitle">Project Title:</label>
                <input type="text" id="projectTitle" name="projectTitle" required><br><br>

                <label for="sponsorshipAgency">Sponsorship Agency:</label>
                <input type="text" id="sponsorshipAgency" name="sponsorshipAgency" required><br><br>

                <label for="budget">Budget:</label>
                <input type="number" id="budget" name="budget" required><br><br>

                <label for="pi">Principal Investigator (PI):</label>
                <input type="text" id="pi" name="pi" required><br><br>

                <label for="coPi">Co-Principal Investigator (Co-PI):</label>
                <input type="text" id="coPi" name="coPi"><br><br>

                <button type="submit">Add Project</button>
            </form>
        </div>

        <script>
            function openTab(evt, tabName) {
                var i, tabcontent, tablinks;

                tabcontent = document.getElementsByClassName("tab-content");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }

                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }

                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }

            // Open the default tab (Home)
            document.getElementById("defaultOpen").click();

            function showProjects() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "fetch-projects.jsp?fid=<%= fid%>", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById("projectData").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
            function showConferences() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "fetch-conferences.jsp?fid=<%= fid%>", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById("conferenceData").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
            function showJournals() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "fetch-Journels.jsp?fid=<%= fid%>", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById("journelData").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
            function showEducations() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "fetch-education.jsp?fid=<%= fid%>", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById("eduData").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
            function showExperience() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "fetch-experience.jsp?fid=<%= fid%>", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById("expData").innerHTML = xhr.responseText;
                    }
                };
                xhr.send();
            }
//            window.onload =  document.getElementById("b1").click();
//            window.onload =  document.getElementById("b2").click();
//            window.onload =  document.getElementById("b3").click();
//            window.onload =  document.getElementById("b4").click();
//            window.onload =  document.getElementById("b5").click();
        </script>

    </body>
</html>