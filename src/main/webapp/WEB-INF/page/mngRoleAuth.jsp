<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<HTML>
<HEAD>
    <link rel="stylesheet" href="/static/css/ztree_metroStyle/demo.css">
    <SCRIPT type="text/javascript">
        <!--
        var setting = {
            view: {
                selectedMulti: false,
                fontCss: { 'color': '#3ce625', 'font-family': '微软雅黑', 'border': '0px'}
            },
            check: {
                enable: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            edit: {
                enable: false
            }
        };

        <!--设置用户角色-->
        function setAuthForRole(primaryKey) {
            $(document).ready(function() {
                <!--新建列表-->
                $.ajax({
                    url: "http://localhost:8001/role/queryAuthUnderRole?id="+primaryKey,
                    type: "get",
                    success: function (data) {
                        if(data.success) {
                            var treeData = eval("("+data.model.treeJson+")");
                            $.fn.zTree.init($("#editRoleAuthTree"), setting, treeData);
                            $("#modelId").val(data.model.modelId)
                            $("#editRoleAuthModal").modal('show');
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

        $(document).ready(function() {

            $("#updateAuthButtonId").click(function () {
                var treeObj=$.fn.zTree.getZTreeObj("editRoleAuthTree");
                var checkedNodeList = nodes=treeObj.getCheckedNodes(true);

                var idList = "[";
                for (var i = 0; i < checkedNodeList.length; i++) {
                    if (checkedNodeList[i].id.toString() != '0') {
                        idList = idList + checkedNodeList[i].id.toString();
                        idList = idList + ",";
                    }
                }
                if(checkedNodeList.length > 0) {
                    idList = idList.substr(0, idList.length-1) + "]";
                } else {
                    idList = idList + "]";
                }

                var modelId = $("#modelId").val();

                var requestData = "{";
                requestData = requestData + "\"modelId\" : " + modelId;
                requestData = requestData + ",\"modelIdList\" : " + idList;
                requestData = requestData + "}";

                <!--更新用户下的角色列表-->
                $.ajax({
                    url: "http://localhost:8001/role/updateAuthUnderRole",
                    contentType: "application/json;charset=UTF-8",
                    type: "post",
                    dataType: "json",
                    data: requestData,
                    success: function (data) {
                        if(data.success) {
                            $("#editRoleAuthModal").modal('hide');

                            $("#optResultContent").empty();
                            $("#optResultContent").append("<div style='display:block; text-align: center;color: green'>操作成功</div>");
                            $("#resultMessageModal").modal('show');
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

    </SCRIPT>
</HEAD>

<!--用户角色编辑窗页面-->
<div class="modal fade" id="editRoleAuthModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title" id="editRoleAuthLabel">
                    角色权限编辑窗
                </h4>
            </div>
            <div class="modal-body">
                <div class="content_wrap">
                    <div class="zTreeDemoBackground left" style="width: 600px;">
                        <input id="modelId" type="hidden">
                        <ul id="editRoleAuthTree" class="ztree"></ul>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="share share_size_large share_type_twitter">
                    <button class="share__btn" data-dismiss="modal">关闭</button>
                </div>
                <div class="share share_size_large share_type_gplus">
                    <button class="share__btn" id="updateAuthButtonId">更新角色</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>