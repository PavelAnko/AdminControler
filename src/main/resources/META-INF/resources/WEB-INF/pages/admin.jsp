<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Prog.kiev.ua</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="crossorigin="anonymous"></script>
</head>
<body>
<div align="center">
    <h1>Secret page for admins only!</h1>
    <p>Click to go back: <a href="/">back</a></p>
    <p>Click to logout: <a href="/logout">LOGOUT</a></p>

    <c:if test="${admin}">
        <button type="button" id="add_user">Add</button>
        <button type="button" id="delete_user">Delete</button>
        <button type="button" id="save_user">Save roles</button>
    </c:if>

    <table border="1">
        <c:forEach items="${users}" var="user">
            <tr>
                <td><input type="checkbox" name="toDelete" value="${user.id}" id="check_${user.id}"></td>
                <td><c:out value="${user.login}"/></td>
                <td>
                    <select name="role" id="role_${user.id}">
                        <c:forEach items="${userRoles}" var="role">
                            <option value="${role}" ${user.role eq role ? 'selected' : ''}>${role}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    $(document).ready(function() {
        $('#add_user').click(function(){
            window.location.href = "/register";
        });

        $('#delete_user').click(function() {
            var data = { 'toDelete': {} };
            $(":checked").each(function() {
                var userId = $(this).val();
                var role = $("#role_" + userId).val();
                data['toDelete'][userId] = role;
            });
            sendRequest('/delete', data);
        });

        $('#save_user').click(function() {
            var data = { 'userRoles': {} };
            $(":checked").each(function() {
                var userId = $(this).val();
                var role = $("#role_" + userId).val();
                data['userRoles'][userId] = role;
            });
            sendRequest('/updateRoles', data);
        });
    });

    function sendRequest(url, data) {
        var jsonData = JSON.stringify(data);
        $.ajax({
            type: 'POST',
            url: url,
            contentType: 'application/json',
            data: jsonData,
            success: function(data, status) {
                window.location.reload();
            }
        });
    }
</script>
</body>
</html>