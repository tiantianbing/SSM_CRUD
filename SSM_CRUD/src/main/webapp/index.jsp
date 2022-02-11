<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/2/7 0007
  Time: 20:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入bootstrap样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>员工信息管理系统</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_btn">编辑</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--新增员工的模态框--%>
        <div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel1">新增员工</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">员工姓名</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="empName" id="name_add_input" placeholder="如：张三">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">员工邮箱</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="empEmail" id="email_add_input" placeholder="如：zs@126.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">员工性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked">男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="empGender" id="gender0_add_input" value="F">女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所在部门</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="dId" id="dept_add_select">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <%--更新员工的模态框--%>
        <div class="modal fade" id="emp_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">更新员工</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">员工姓名</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="name_update_static"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">员工邮箱</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="empEmail" id="email_update_input" placeholder="如：zs@126.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">员工性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="empGender" id="gender1_update_input" value="M" checked="checked">男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="empGender" id="gender0_update_input" value="F">女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所在部门</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="dId" id="dept_update_select">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                    </div>
                </div>
            </div>
        </div>
    <%--显示员工数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/>全选</th>
                        <th>员工ID</th>
                        <th>员工姓名</th>
                        <th>员工性别</th>
                        <th>员工邮箱</th>
                        <th>所在部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
               <tbody>

               </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecords;//总记录数
    var currentPage; //当前页面数

    //为新增员工的编辑按钮绑定单击事件,同时发送ajax请求，向服务器获取部门信息
    $("#emp_add_btn").click(function () {
        //首先清空表单里的信息
        reset_form("#emp_add_modal form");
        //查询部门信息
        getDepts("#emp_add_modal select");
        //弹出模态框
        $("#emp_add_modal").modal({
            backdrop:"static"
        });
    });
    //页面加载完成以后，直接发送ajax请求,获取分页数据
    $(function () {
        //访问首页的员工信息
        to_page(1);
    });

    function to_page(pageNo) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNo="+pageNo,
            type:"GET",
            success:function (result) {
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                //遍历获取到的部门列表，加入到select标签中
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

        function build_emps_table(result) {
            //清空emps_table表格的内容
            $("#emps_table tbody").empty();
            //获取员工信息的list
            var emps = result.extend.pageInfo.list;
            //构建员工信息
            $.each(emps,function(index,item){
                var checkTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var empGenderTd = $("<td></td>").append(item.empGender=='M'?"男":"女");
                var empEmailTd = $("<td></td>").append(item.empEmail);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit-btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit-id",item.empId);
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete-btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("delete-id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>")
                    .append(checkTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(empGenderTd)
                    .append(empEmailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        function build_page_info(result) {
            //清空page_info_area的内容
            $("#page_info_area").empty();
            //构建分页信息
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总共"+
                result.extend.pageInfo.pages+"页,总共"+
                result.extend.pageInfo.total+"条记录");
            totalRecords = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        function build_page_nav(result) {
            //清空page_nav_area的内容
            $("#page_nav_area").empty();
            //构建分页条元素ul
            var ul = $("<ul></ul>").addClass("pagination");
            //构建首页和前一页的li元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            //当没有前一页时禁止点击首页和前一页
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //当有前一页时为首页和前一页绑定单击事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum -1);
                });
            }
            //同理构建末页和下一页的li元素
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.extend.pageInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.pageInfo.pages);
                });
            }
            //添加首页和前一页 的提示
            ul.append(firstPageLi).append(prePageLi);
            //遍历连续显示的页码，并激活当前页码
            $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                //为每个页面的跳转绑定单击事件
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //把下一页和末页的li元素添加到ul中
            ul.append(nextPageLi).append(lastPageLi);
            //把ul添加到nav元素中
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //重置表单里的信息
        function reset_form(ele){
            //重置表单信息
            $(ele)[0].reset();
            //重置表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //保存新增的员工信息
        $("#emp_save_btn").click(function () {
            //先对用户名和邮箱的合法性进行前端校验
            if (!is_validate_add()){
                return false;
            }
            //再检验用户名是否已经存在
            if ($(this).attr("check_info") == "error"){
                return false;
            }
            //点击保存，发送ajax请求保存员工信息
            $.ajax({
                url: "${APP_PATH}/emp",
                type:"POST",
                data:$("#emp_add_modal form").serialize(),
                success:function (result) {
                    if (result.code == 100){
                        //员工保存成功
                        //关闭模态框
                        $("#emp_add_modal").modal('hide');
                        //返回最后一页
                        to_page(totalRecords);
                    }else {
                        //员工保存失败
                        if(undefined != result.extend.errorFields.empEmail){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.empEmail);
                        }
                        if(undefined != result.extend.errorFields.empName){
                            //显示员工名字的错误信息
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                        }
                    }
                }
            });

        });

    //获取要用户名和邮箱，使用正则表达式进行校验
        function is_validate_add() {
            //获取用户名和正则表达式进行验证
            var empName = $("#name_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)){
                show_validate_msg("#name_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                return false;
            }else {
                show_validate_msg("#name_add_input","success","");
            }
            //获取邮箱和正则表达式进行验证
            var empEmail = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(empEmail)){
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_add_input","success","");
            }
            return true;
        }

        //设置显示检验结果的样式信息
        function show_validate_msg(ele,status,msg) {
            //首先清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            if("success"== status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //检验用户名是否已经存在
        $("#name_add_input").blur(function () {
           //发送ajax请求检验用户名是否存在
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"empName="+empName,
                type:"GET",
                success:function (result) {
                    if (result.code == 100){
                        show_validate_msg("#name_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("check_info","success");
                    }else{
                        show_validate_msg("#name_add_input","error",result.extend.check_msg);
                        $("#emp_save_btn").attr("check_info","error");
                    }
                }
            });
        });

        //给每个员工的编辑按钮都绑定单击事件
        $(document).on("click",".edit-btn",function () {
            //发送ajax请求，显示部门列表
            getDepts("#emp_update_modal select");
            //发送ajax请求，查询员工信息
            getEmp($(this).attr("edit-id"));
            //把员工的id也传给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            //弹出模态框
            $("#emp_update_modal").modal({
                backdrop:"static"
            });
        });

        function getEmp(id) {
            $.ajax({
               url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empData = result.extend.emp;
                    $("#name_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.empEmail);
                    $("#emp_update_modal input[name=empGender]").val([empData.empGender]);
                    $("#emp_update_modal select").val([empData.dId]);
                }
            });
        }
        //为每个员工的更新按钮绑定单机事件
        $("#emp_update_btn").click(function () {
            //检验邮箱格式是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_update_input", "success", "");
            }
            //发送ajax请求，保存当前表单的员工数据，完成更新
            $.ajax({
               url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
               type:"PUT",
               data:$("#emp_update_modal form").serialize(),
               success:function (result) {
                    //关闭模态框
                   $("#emp_update_modal").modal("hide");
                   //返回被更新员工的页面
                    to_page(currentPage);
               }
            });
        });

        //为每个员工的删除按钮绑定单机事件
        $(document).on("click",".delete-btn",function () {
                //弹出是否确认删除对话框
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("delete-id");
                if (confirm("确认删除【"+empName+"】吗?")){
                    //确认删除后，发送ajax请求
                    $.ajax({
                       url:"${APP_PATH}/emp/"+empId,
                       type:"DELETE",
                       success:function (result) {
                            alert(result.message);
                            //回到本页
                            to_page(currentPage);
                       }
                    });
                }
            }
        );

        //全选和全不选的功能
        $("#check_all").click(function () {
            //点击全选框后，页面每一条记录的选择框也随之改变
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        //全选框的状态随当前页面记录的选择框的改变而改变
        $(document).on("click",".check_item",function () {
            //判断当前页面选中的记录数是否等于总记录数
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        });

        //批量删除功能
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var empIds = "";
            //分别拼接name和id
            $.each($(".check_item:checked"),function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                empIds += $(this).parents("tr").find("td:eq(1)").text()+",";
            });
            //去除name和id多余的逗号
            empNames = empNames.substring(0,empNames.length - 1);
            empIds = empIds.substring(0,empIds.length - 1);
            //弹出确认框
            if (confirm("确认删除【"+empNames+"】吗?")){
                //发送ajax请求删除员工信息
                $.ajax({
                    url:"${APP_PATH}/emp/"+empIds,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.message);
                        //返回当页
                        to_page(currentPage);
                    }
                });
            }
        });
</script>
</body>
</html>
