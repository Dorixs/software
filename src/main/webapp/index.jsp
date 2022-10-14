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
<div style="margin: 5px auto; width: 150px; height: 50px; background-color: pink;">
    <p style="text-align: center;">欢迎来到软件体系结构教学软件</p>
</div>
<div style="width: 350px; height: 350px; border-style: solid; margin: 20px auto; display: flex; justify-items: left;">
    <form action="../upload" method="post" enctype="multipart/form-data" style="text-align: center">
        选择方式 <br>
        <input type="radio" value="1" name="name" >   主程序-子程序软件体系结构
        <a href="details1.jsp"><button type="button">点击查看原理</button></a>
        <br>
        <input type="radio" value="2" name="name" > 面向对象软件体系结构
        <a href="details2.jsp"><button type="button">点击查看原理</button></a>
        <br>
        <input type="radio" value="3" name="name" > 事件系统软件体系结构
        <a href="details3.jsp"><button type="button">点击查看原理</button></a>
        <br>
        <input type="radio" value="4" name="name" >管道-过滤软件体系结构
        <a href="details4.jsp"><button type="button">点击查看原理</button></a>
        <br>
        <input type="file" name="file"  >  <br>
        <input type="submit" value="提交" id="sbt">  <br>
    </form>
</div>
</body>

</html>