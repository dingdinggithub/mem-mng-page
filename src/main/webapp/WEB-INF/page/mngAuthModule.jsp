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
        function setRoleForUser(primaryKey) {
            $(document).ready(function() {
                <!--新建列表-->
                $.ajax({
                    url: "http://localhost:8001/user/queryRoleUnderUser?id="+primaryKey,
                    type: "get",
                    success: function (data) {
                        if(data.success) {
                            var treeData = eval("("+data.model+")");
                            $.fn.zTree.init($("#editUserRoleTree"), setting, treeData);
                            $("#editUserRoleModal").modal('show');
                        } else {
                            alert("wrong"+data.errorMessage);
                        }
                    },
                    error: function () {
                        alert("请求访问异常！！！");
                    }
                });
            });
        }
    </SCRIPT>
</HEAD>

<!--用户角色编辑窗页面-->
<div class="modal fade" id="editUserRoleModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                </button>
                <h4 class="modal-title" id="editUserRoleLabel">
                    用户角色编辑窗页面
                </h4>
            </div>
            <div class="modal-body">
                <div class="content_wrap">
                    <div class="zTreeDemoBackground left" style="width: 600px;">
                        <ul id="editUserRoleTree" class="ztree"></ul>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="share share_size_large share_type_twitter">
                    <button class="share__btn" data-dismiss="modal">关闭</button>
                </div>
                <div class="share share_size_large share_type_gplus">
                    <button class="share__btn" id="updateButtonId">更新角色</button>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>