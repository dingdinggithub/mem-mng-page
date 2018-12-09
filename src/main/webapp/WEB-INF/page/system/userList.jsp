<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--outter-wp-->
<div class="outter-wp">
<!--sub-heard-part-->
    <div class="sub-heard-part">
        <ol class="breadcrumb m-b-0">
            <li><a href="index.html">系统</a></li>
            <li class="active">用户管理</li>
        </ol>
    </div>
<!--//sub-heard-part-->
    <div class="graph-visual tables-main">
        <h4 class="inner-tittle">
            <div class="share share_size_large share_type_twitter">
                <a class="share__btn" href="#" data-toggle="modal" data-target="#createModal">新增用户</a>
                <span id="testSpan"></span>
            </div>
        </h4>

        <div class="graph">
            <div class="tables">
                <table class="table" id="tableList">
                </table>
            </div>
        </div>
        <ul class="pagination pagination-sm" id="pageStyleId">
            <li id = "preClassId"><a><i class="fa fa-angle-double-left"><input type="hidden" name="prePage" id="prePageId"></i></a></li>
            <li class="active"><a><input type="hidden" name="currentPage" id="currentPageId"></a></li>
            <li id = "nextClassId"><a><i class="fa fa-angle-double-right"><input type="hidden" name="nextPage" id="nextPageId"></i></a></li>
        </ul>
    </div>
<!--//graph-visual-->

<script type="text/javascript">

    //页面刷新
    function flushPage() {
        <!--初始化列表-->
        $.ajax({
            url : "http://localhost:8001/user/queryPage",
            contentType: "application/json;charset=UTF-8",
            type: "post",
            dataType: "json",
            data:"{}",
            success : function(data) {

                if(data.success) {
                    buildList(data.model);
                    buildPageParam(data);
                } else {
                    alert(data.errorMessage);
                }

            },
            error : function() {
                alert("请求失败")
            }
        });
    }

    //组装分页参数
    function buildPageParam(data) {
        $("#pageStyleId").empty();
        var pageCont ="";
        if (data.pageIndex == 1) {
            pageCont = pageCont + "<li class='disabled'><a><i class='fa fa-angle-double-left'></i></a></li>";
        } else {
            pageCont = pageCont + "<li onclick='prePageFun("+(data.pageIndex-1)+")'><a><i class='fa fa-angle-double-left'><input type='hidden' name='prePage' id='prePageId'></i></a></li>";
        }
        pageCont = pageCont + "<li class='active'><a>" + data.pageIndex +"</a></li>";
        if (data.pageIndex == data.totalPage) {
            pageCont = pageCont + "<li class='disabled'><a><i class='fa fa-angle-double-right'><input type='hidden' name='nextPage' id='nextPageId'></i></a></li>";
        } else {
            pageCont = pageCont + "<li  onclick='prePageFun("+(data.pageIndex+1)+")'><a><i class='fa fa-angle-double-right'><input type='hidden' name='nextPage' id='nextPageId'></i></a></li>";
        }

        $("#pageStyleId").append(pageCont);
    }

    //翻页动作
    function prePageFun(pageIndex) {

        var pageData = "{\"pageIndex\" : " + pageIndex + "}";

        $(document).ready(function() {
            <!--初始化列表-->
            $.ajax({
                url: "http://localhost:8001/user/queryPage",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: pageData,
                success: function (data) {

                    if (data.success) {
                        buildList(data.model);
                        buildPageParam(data);
                    } else {
                        alert(data.errorMessage);
                    }

                },
                error: function () {
                    alert("请求失败")
                }
            });
        });
    }


    //响应数据列表构建
    function buildList(list) {
        //清空列表
        $("#tableList").empty();
        var headCont = "<thead><tr><th>id</th> <th>用户名</th> <th>用户密码</th> <th>用户状态</th> <th>手机号</th> <th>邮箱</th> <th>部门id</th><th>操作</th></tr></thead>";

        $("#tableList").append(headCont);
        for ( var i = 0; i < list.length; i++) {
            var cont = "<tbody><tr><td>" + list[i].id + "</td>";
            cont = cont + "<td>" + list[i].username + "</td>";
            cont = cont + "<td>" + list[i].password + "</td>";
            cont = cont + "<td>" + list[i].status + "</td>";
            cont = cont + "<td>" + list[i].telephone + "</td>";
            cont = cont + "<td>" + list[i].mail + "</td>";
            cont = cont + "<td>" + list[i].deptId + "</td>";
            cont = cont + "<td><div class='share share_size_large share_type_twitter'>" +
                "<button id='updateButtonId' class='share__btn' onclick = 'updateUser(" +
                list[i].id+
                ")'>编辑</button>" +
                "</div>\n" +
                "<div class='share share_size_large share_type_gplus'>" +
                "<a class='share__btn' onclick = 'deleteUser(" +
                list[i].id+
                ")'>删除</a>" +
                "</div>" +
                "</td>" +
                "</tr>" +
                "</tbody>";

            $("#tableList").append(cont);
        }
    }

    $(document).ready(function() {

        flushPage();

        <!--新建操作-->
        $('#createButtonId').click(function() {

            var formData=JSON.stringify($('#createFormId').serializeJSON());

            $.ajax({
                url: "http://localhost:8001/user/insertUser",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: formData,
                success: function (data) {
                    $("#createModal").modal('hide');
                    alert("创建成功~~");
                    flushPage();
                },
                error: function (data) {
                    alert(data.errorMessage);
                }
            });

            /*$.when(createAjax).done(function () {

            });*/
        });

        <!--更新操作-->
        $('#updateButtonId').click(function() {

            var formData=JSON.stringify($('#editFormlId').serializeJSON());

            $.ajax({
                url: "http://localhost:8001/user/updateUser",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: formData,
                success: function (data) {
                    $("#editModal").modal('hide');
                    if(data.success) {
                        alert("更新成功~~");
                        flushPage();
                    } else {
                        alert(data.errorMessage);
                    }
                },
                error: function () {
                    alert("请求访问异常！！！");
                }
            });
        });

    });


    <!--前往更新页面-->
    function updateUser(primaryKey) {
        $(document).ready(function() {
            <!--新建列表-->
            $.ajax({
                url: "http://localhost:8001/user/queryUser?id="+primaryKey,
                type: "get",
                success: function (data) {
                    var dataModel = data.model;
                    $('#editId').val(dataModel.id);
                    $('#editUsernameId').val(dataModel.username);
                    $('#editPasswordId').val(dataModel.password);
                    $('#editStatusId').val(dataModel.status);
                    $('#editTelephoneId').val(dataModel.telephone);
                    $('#editMailId').val(dataModel.mail);
                    $('#editDeptIdId').val(dataModel.deptId);
                    $("#editModal").modal('show');
                },
                error: function () {
                    alert("请求访问异常！！！");
                }
            });
        });
    }

    <!--删除操作-->
    function deleteUser(primaryKey) {
        $(document).ready(function() {
            <!--新建列表-->
            $.ajax({
                url: "http://localhost:8001/user/deleteUser?id="+primaryKey,
                type: "get",
                success: function (data) {
                    if(data.success) {
                        alert("删除成功~~");
                        flushPage();
                    } else {
                        alert(data.errorMessage);
                    }
                },
                error: function () {
                    alert("请求访问异常！！！");
                }
            });
        });
    }

</script>


<!--编辑弹窗页面-->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title" id="editModalLabel">
                    更新用户信息
                </h4>
            </div>
            <div class="modal-body">
                <div class="forms-main">
                    <!--/forms-inner-->
                    <div class="forms-inner">
                        <!--/set-1-->
                        <div class="set-1">
                                <div class="grid-1">
                                    <div class="form-body">
                                        <form class="form-horizontal" id="editFormlId">
                                            <input name="id" type="hidden" class="form-control" id="editId">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">username</label>
                                                <div class="col-sm-9">
                                                    <input name="username" type="text" class="form-control" placeholder="username" id="editUsernameId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">password</label>
                                                <div class="col-sm-9">
                                                    <input name="password" type="text" class="form-control" placeholder="password" id="editPasswordId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">status</label>
                                                <div class="col-sm-9">
                                                    <input name="status" type="text" class="form-control" placeholder="status" id="editStatusId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">telephone</label>
                                                <div class="col-sm-9">
                                                    <input name="telephone" type="text" class="form-control" placeholder="telephone" id="editTelephoneId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">mail</label>
                                                <div class="col-sm-9">
                                                    <input name="mail" type="text" class="form-control" placeholder="mail" id="editMailId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">deptId</label>
                                                <div class="col-sm-9">
                                                    <input name="deptId" type="text" class="form-control" placeholder="deptId" id="editDeptIdId">
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            <div class="clearfix"> </div>
                        </div>
                        <!--//set-1-->
                    </div>
                    <!--//forms-inner-->
                </div>
                <!--//forms-->

            </div>
            <div class="modal-footer">
                <div class="share share_size_large share_type_twitter">
                    <button class="share__btn" data-dismiss="modal">关闭</button>
                </div>
                <div class="share share_size_large share_type_gplus">
                    <button class="share__btn" id="updateButtonId">更新</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!--创建弹窗页面-->
<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="createModalLabel">
                    创建用户信息
                </h4>
            </div>
            <div class="modal-body">

                <div class="forms-main">
                    <!--/forms-inner-->
                    <div class="forms-inner">
                        <!--/set-1-->
                        <div class="set-1">
                            <div class="grid-1">
                                <div class="form-body">
                                    <form class="form-horizontal" id="createFormId">

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">username</label>
                                            <div class="col-sm-9">
                                                <input name="username" type="text" class="form-control" placeholder="username">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">password</label>
                                            <div class="col-sm-9">
                                                <input name="password" type="text" class="form-control" placeholder="password">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">status</label>
                                            <div class="col-sm-9">
                                                <input name="status" type="text" class="form-control" placeholder="status">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">telephone</label>
                                            <div class="col-sm-9">
                                                <input name="telephone" type="text" class="form-control" placeholder="telephone">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">mail</label>
                                            <div class="col-sm-9">
                                                <input name="mail" type="text" class="form-control" placeholder="mail">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">deptId</label>
                                            <div class="col-sm-9">
                                                <input name="deptId" type="text" class="form-control" placeholder="deptId">
                                            </div>
                                        </div>

                                    </form>
                                </div>

                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <!--//set-1-->
                    </div>
                    <!--//forms-inner-->
                </div>
                <!--//forms-->

            </div>
            <div class="modal-footer">
                <div class="share share_size_large share_type_twitter">
                    <button class="share__btn" data-dismiss="modal">关闭</button>
                </div>
                <div class="share share_size_large share_type_gplus">
                    <button class="share__btn" id="createButtonId">创建</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

</div>
<!--//outer-wp-->

    