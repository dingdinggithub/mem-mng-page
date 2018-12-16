<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--outter-wp-->
<div class="outter-wp">
<!--sub-heard-part-->
    <div class="sub-heard-part">
        <ol class="breadcrumb m-b-0">
            <li><a href="index.html">系统</a></li>
            <li class="active">权限管理</li>
        </ol>
    </div>
<!--//sub-heard-part-->
    <div class="graph-visual tables-main">
        <h4 class="inner-tittle">
            <div class="share share_size_large share_type_twitter">
                <a class="share__btn" href="#" onclick="toCreatePage()">新增权限</a>
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

    <!--字典全局变量-->
    var moduleDirc;

    $(document).ready(function() {
        <!--获取状态字典-->
        $.ajax({
            url: "http://localhost:8001/dict/getModule",
            type: "get",
            success: function (data) {
                if (data.success) {
                    moduleDirc = data.model;
                } else {
                    $("#optResultContent").empty();
                    $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                    $("#resultMessageModal").modal('show');
                }
            },
            error: function () {
                alert("请求失败")
            }
        });
    });

    //页面刷新
    function flushPage() {
        <!--初始化列表-->
        $.ajax({
            url : "http://localhost:8001/authModule/queryPage",
            contentType: "application/json;charset=UTF-8",
            type: "post",
            dataType: "json",
            data:"{}",
            success : function(data) {

                if(data.success) {
                    buildList(data.model);
                    buildPageParam(data);
                } else {
                    $("#optResultContent").empty();
                    $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                    $("#resultMessageModal").modal('show');
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
                url: "http://localhost:8001/authModule/queryPage",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: pageData,
                success: function (data) {

                    if (data.success) {
                        buildList(data.model);
                        buildPageParam(data);
                    } else {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                        $("#resultMessageModal").modal('show');
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
        var headCont = "<thead><tr><th>权限名称</th> <th>所属模块</th> <th>请求的url</th> <th>类型</th><th>状态</th><th>操作</th></tr></thead>";

        $("#tableList").append(headCont);
        for ( var i = 0; i < list.length; i++) {
            var cont = "<tbody><tr>";
            cont = cont + "<td>" + list[i].name + "</td>";
            cont = cont + "<td>" + list[i].moduleName + "</td>";
            cont = cont + "<td>" + list[i].url + "</td>";
            cont = cont + "<td>" + list[i].typeDesc + "</td>";
            cont = cont + "<td>" + list[i].statusDesc + "</td>";
            cont = cont + "<td><div class='share share_size_large share_type_twitter'>" +
                "<button id='updateButtonId' class='share__btn' onclick = 'updateAuthModule(" +
                list[i].id+
                ")'>编辑</button>" +
                "</div>\n" +
                "<div class='share share_size_large share_type_gplus'>" +
                "<a class='share__btn' onclick = 'deleteAuthModule(" +
                list[i].id+
                ")'>删除</a>" +
                "</div>" +
                "</td>" +
                "</tr>" +
                "</tbody>";

            $("#tableList").append(cont);
        }
    }

    <!--前往新建页面-->
    function toCreatePage() {
        $('#createTypeId').empty();
        var createAuthTypeStr = "";
        for (var i = 0; i < authTypeDirc.length; i++) {
            createAuthTypeStr = createAuthTypeStr + "<option value='";
            createAuthTypeStr = createAuthTypeStr + authTypeDirc[i].code + "'>";
            createAuthTypeStr = createAuthTypeStr + authTypeDirc[i].desc +"</option>";
        }
        $('#createTypeId').append(createAuthTypeStr);

        $('#createModuleIdId').empty();
        var moduleStr = "";
        for (var i = 0; i < moduleDirc.length; i++) {
            moduleStr = moduleStr + "<option value='";
            moduleStr = moduleStr + moduleDirc[i].code + "'>";
            moduleStr = moduleStr + moduleDirc[i].desc +"</option>";
        }
        $('#createModuleIdId').append(moduleStr);

        $("#createModal").modal('show');
    };


    $(document).ready(function() {

        flushPage();

        <!--新建操作-->
        $('#createButtonId').click(function() {

            var formData=JSON.stringify($('#createFormId').serializeJSON());

            $.ajax({
                url: "http://localhost:8001/authModule/insertAuthModule",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: formData,
                success: function (data) {
                    if(data.success) {
                        $("#createModal").modal('hide');
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: green'>操作成功</div>");
                        $("#resultMessageModal").modal('show');
                        flushPage();
                    } else {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                        $("#resultMessageModal").modal('show');
                    }
                },
                error: function (data) {
                    alert(data);
                }
            });

            /*$.when(createAjax).done(function () {

            });*/
        });

        <!--更新操作-->
        $('#updateButtonId').click(function() {

            var formData=JSON.stringify($('#editFormlId').serializeJSON());

            $.ajax({
                url: "http://localhost:8001/authModule/updateAuthModule",
                contentType: "application/json;charset=UTF-8",
                type: "post",
                dataType: "json",
                data: formData,
                success: function (data) {
                    $("#editModal").modal('hide');
                    if(data.success) {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: green'>操作成功</div>");
                        $("#resultMessageModal").modal('show');
                        flushPage();
                    } else {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                        $("#resultMessageModal").modal('show');
                    }
                },
                error: function () {
                    alert("请求访问异常！！！");
                }
            });
        });

    });

    <!--前往更新页面-->
    function updateAuthModule(primaryKey) {
        $(document).ready(function() {
            <!--新建列表-->
            $.ajax({
                url: "http://localhost:8001/authModule/queryAuthModule?id="+primaryKey,
                type: "get",
                success: function (data) {
                    var dataModel = data.model;
                    $('#editId').val(dataModel.id);
                    $('#editNameId').val(dataModel.name);

                    $('#editModuleIdId').empty();
                    var moduleStr = "";
                    for (var i = 0; i < moduleDirc.length; i++) {
                        moduleStr = moduleStr + "<option value='";
                        moduleStr = moduleStr + moduleDirc[i].code + "'";
                        if (dataModel.moduleId == moduleDirc[i].code) {
                            moduleStr = moduleStr + " selected = 'selected'>";
                        } else {
                            moduleStr = moduleStr + ">";
                        }
                        moduleStr = moduleStr + moduleDirc[i].desc +"</option>";
                    }
                    $('#editModuleIdId').append(moduleStr);

                    $('#editUrlId').val(dataModel.url);

                    $('#editTypeId').empty();
                    var authTypeStr = "";
                    for (var i = 0; i < authTypeDirc.length; i++) {
                        authTypeStr = authTypeStr + "<option value='";
                        authTypeStr = authTypeStr + authTypeDirc[i].code + "'";
                        if (dataModel.type == authTypeDirc[i].code) {
                            authTypeStr = authTypeStr + " selected = 'selected'>";
                        } else {
                            authTypeStr = authTypeStr + ">";
                        }
                        authTypeStr = authTypeStr + authTypeDirc[i].desc +"</option>";
                    }
                    $('#editTypeId').append(authTypeStr);

                    $('#editStatusId').empty();
                    var selectStr = "";
                    for (var i = 0; i < statusDirc.length; i++) {
                        selectStr = selectStr + "<option value='";
                        selectStr = selectStr + statusDirc[i].code + "'";
                        if (dataModel.status == statusDirc[i].code) {
                            selectStr = selectStr + " selected = 'selected'>";
                        } else {
                            selectStr = selectStr + ">";
                        }
                        selectStr = selectStr + statusDirc[i].desc +"</option>";
                    }
                    $('#editStatusId').append(selectStr);

                    $("#editModal").modal('show');
                },
                error: function () {
                    alert("请求访问异常！！！");
                }
            });
        });
    }

    <!--删除操作-->
    function deleteAuthModule(primaryKey) {
        $(document).ready(function() {
            <!--新建列表-->
            $.ajax({
                url: "http://localhost:8001/authModule/deleteAuthModule?id="+primaryKey,
                type: "get",
                success: function (data) {
                    if(data.success) {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: green'>操作成功</div>");
                        $("#resultMessageModal").modal('show');
                        flushPage();
                    } else {
                        $("#optResultContent").empty();
                        $("#optResultContent").append("<div style='display:block; text-align: center;color: red'>操作失败<br/>原因: "+data.errorMessage+"</div>");
                        $("#resultMessageModal").modal('show');
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
                    更新权限
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
                                                <label class="col-sm-2 control-label">name</label>
                                                <div class="col-sm-9">
                                                    <input name="name" type="text" class="form-control" placeholder="name" id="editNameId">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">moduleId</label>
                                                <div class="col-sm-9">
                                                    <select name="moduleId" id="editModuleIdId" class="form-control1">
                                                        <option selected = selected></option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">url</label>
                                                <div class="col-sm-9">
                                                    <input name="url" type="text" class="form-control" placeholder="url" id="editUrlId">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">type</label>
                                                <div class="col-sm-8">
                                                    <select name="type" id="editTypeId" class="form-control1">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="editStatusId" class="col-sm-2 control-label">status</label>
                                                <div class="col-sm-8">
                                                    <select name="status" id="editStatusId" class="form-control1">
                                                        <option selected = selected></option>
                                                    </select>
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
                    创建权限
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
                                            <label class="col-sm-2 control-label">name</label>
                                            <div class="col-sm-9">
                                                <input name="name" type="text" class="form-control" placeholder="name">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">moduleId</label>
                                            <div class="col-sm-9">
                                                <select name="moduleId" id="createModuleIdId" class="form-control1">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">url</label>
                                            <div class="col-sm-9">
                                                <input name="url" type="text" class="form-control" placeholder="url">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">type</label>
                                            <div class="col-sm-8">
                                                <select name="type" id="createTypeId" class="form-control1">
                                                </select>
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

    