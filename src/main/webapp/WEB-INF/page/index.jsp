<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE HTML>
<html>
<head>
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />

<%@include file="/WEB-INF/page/base.jsp"%>

</head>
<body>
   <div class="page-container">
   <!--/content-inner-->
	<div class="left-content">
	   <div class="inner-content">
			<!-- header-starts -->
           <div class="header-section">
               <!--menu-right-->
               <div class="top_menu">
                   <!--/profile_details-->
                   <div class="profile_details_left">
                       <ul class="nofitications-dropdown">
                           <li class="dropdown note dra-down">

                           </li>
                           <li class="dropdown note">
                               <a href="#" class="dropdown-toggle"></a>

                           </li>

                           <div class="clearfix"></div>
                       </ul>
                   </div>
                   <div class="clearfix"></div>
                   <!--//profile_details-->
               </div>
               <!--//menu-right-->
               <div class="clearfix"></div>
           </div>
			<!-- //header-ends -->

            <!--inner content start-->
           <%@include file="/WEB-INF/page/tree.jsp" %>
           <c:choose>
               <c:when test="${module == '1-1'}">
                   <%@include file="/WEB-INF/page/system/userList.jsp" %>
               </c:when>
               <c:when test="${module == '1-2'}">
                   <%@include file="/WEB-INF/page/system/moduleList.jsp" %>
               </c:when>
               <c:when test="${module == '1-3'}">
                   <%@include file="/WEB-INF/page/system/roleList.jsp" %>
               </c:when>
               <c:when test="${module == '1-4'}">
                   <%@include file="/WEB-INF/page/system/authModuleList.jsp" %>
               </c:when>
           </c:choose>
            <!--inner content end-->

			<!--footer section start-->
            <footer>
               <p>留下记忆的印记</p>
            </footer>
			<!--footer section end-->
		</div>
	</div>
	<!--//content-inner-->
	<!--/sidebar-menu-->
	<div class="sidebar-menu">

        <header class="logo">
            <a href="#" class="sidebar-icon"> <span class="fa fa-bars"></span> </a>
            <a href="index.jspindex.html">
                <span id="logo"> <h1>回忆密码</h1></span>
            </a>
        </header>

		<div style="border-top:1px solid rgba(69, 74, 84, 0.7)"></div>

        <div class="down">
            <ul>
                <li><a class="tooltips" href="/page/index.html"><span>系统介绍</span><i class="lnr lnr-user"></i></a></li>
                <li><a class="tooltips" href="/page/index.html"><span>系统配置</span><i class="lnr lnr-cog"></i></a></li>
                <li><a class="tooltips" href="/page/login.html"><span>注销</span><i class="lnr lnr-power-switch"></i></a></li>
            </ul>
        </div>

        <div class="menu">
            <ul id="menu" >
                <li><a href="#"><i class="fa fa-table"></i> <span>系统模块</span>
                        <span class="fa fa-angle-right" style="float: right"></span></a>
                    <ul id="menu-academico-sub" >
                        <li id="menu-academico-avaliacoes" ><a href="/page/index.html?module=1-1">用户管理</a></li>
                        <li><a href="/page/index.html?module=1-2">模块管理</a></li>
                        <li><a href="/page/index.html?module=1-3">角色管理</a></li>
                        <li><a href="/page/index.html?module=1-4">权限管理</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
       <div class="clearfix"></div>
   </div>
   <script>
       var toggle = true;

       $(".sidebar-icon").click(function() {
           if (toggle)
           {
               $(".page-container").addClass("sidebar-collapsed").removeClass("sidebar-collapsed-back");
               $("#menu span").css({"position":"absolute"});
           }
           else
           {
               $(".page-container").removeClass("sidebar-collapsed").addClass("sidebar-collapsed-back");
               setTimeout(function() {
                   $("#menu span").css({"position":"relative"});
               }, 400);
           }

           toggle = !toggle;
       });
   </script>

   </div>
	<div class="clearfix"></div>
   </div>

</body>
</html>