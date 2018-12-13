<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Bootstrap Core CSS -->
<link href="/static/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<!-- Custom CSS -->
<link href="/static/css/style.css" rel='stylesheet' type='text/css' />
<!-- Graph CSS -->
<link href="/static/css/font-awesome.css" rel="stylesheet">
<!-- jQuery -->
<link href='https://fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'>
<!-- lined-icons -->
<link rel="stylesheet" href="/static/css/icon-font.min.css" type='text/css' />
<!--tree-css -->
<link rel="stylesheet" href="/static/css/ztree_metroStyle/metroStyle.css">

<!-- //lined-icons -->
<script type="text/javascript" src="/static/js/jquery-3.2.1.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/amcharts.js"></script>
<script src="/static/js/serial.js"></script>
<script src="/static/js/light.js"></script>
<script src="/static/js/radar.js"></script>
<link href="/static/css/barChart.css" rel='stylesheet' type='text/css' />
<link href="/static/css/fabochart.css" rel='stylesheet' type='text/css' />


<script type="text/javascript" src="/static/js/jquery.serializejson.js"></script>
<%--<script type="text/javascript" src="/staticjs/myjs/action.js"></script>--%>
<!--clock init-->
<script src="/static/js/css3clock.js"></script>
<!--Easy Pie Chart-->

<!--skycons-icons-->
<script src="/static/js/skycons.js"></script>
<script src="/static/js/jquery.easydropdown.js"></script>
<!--//skycons-icons-->

<!--tree-js -->
<script src="/static/js/layui.js"></script>
<script src="/static/js/tree.js"></script>

<script type="text/javascript" src="/static/js/ztree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="/static/js/ztree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="/static/js/ztree/jquery.ztree.exedit.js"></script>

<!--Tail JS-->
<!--js -->
<link rel="stylesheet" href="/static/css/vroom.css">
<script type="text/javascript" src="/static/js/TweenLite.min.js"></script>
<script type="text/javascript" src="/static/js/CSSPlugin.min.js"></script>
<script src="/static/js/jquery.nicescroll.js"></script>
<script src="/static/js/scripts.js"></script>

<!--获取项目绝对路径-->
<script type="text/javascript">
    var currentPath = window.document.location.href;
    var pathName = window.document.location.pathname;
    var pos = currentPath.indexOf(pathName);
    var serverPath = currentPath.substring(0, pos);
    var projectName = pathName
        .substring(0, pathName.substr(1).indexOf('/') + 1);
    var realPath = serverPath + projectName;
</script>