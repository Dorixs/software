<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>经典软件体系结构教学软件</title>
</head>
<body>
<h2 style="text-align: center">您选择的方法是${method},输出结果是</h2> <br>
<div style="width: 400px ; height: 400px; border-style: solid;margin: 20px auto;">
<c:forEach items="${details}" var="item">
    <h5 style="text-align: center">${item}</h5>
</c:forEach>
    <a href="index.jsp"><button >返回</button></a>
</div>
</body>

</html>