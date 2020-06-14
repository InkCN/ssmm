<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--    引入JQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--    引入Bootstrap样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <%--    <link rel="shortcut icon" href="${APP_PATH}\WEB-INF\views\bitbug_favicon.ico" type="image/x-icon" />--%>
    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">--%>
</head>
<body>

<!-- 添加员工的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加臭猪</h4>
            </div>
            <div class="modal-body">

                <%--表单--%>
                <form class="form-horizontal" id="add_emp_form">

                    <div class="form-group">
                        <label class="col-sm-2 control-label">臭猪名字</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="请输入臭猪名字">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">臭猪邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="请输入臭猪Email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id即可--%>
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

<!-- 编辑员工的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改臭猪</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="Update_emp_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_Update_input"
                                   readonly>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="emp_Update_email"
                                   placeholder="">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <div>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender1_Update_input" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender2_Update_input" value="W"> 女
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门编号</label>
                        <div class="col-sm-6">
                            <select class="form-control" name="dId" id="Update_select_depts">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_Update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--    标题--%>
    <div class="row">
        <div class="col-md-12"><h1>SSM-CRUD</h1></div>
    </div>
    <%--    按钮--%>
    <div class="row" style="margin-bottom: 0.5%;">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_all">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>

            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--        分页文字信息--%>
        <div class="col-md-7" id="page_info_area"></div>
        <%--    分页条信息--%>
        <div class="col-md-5">
            <nav aria-label="Page navigation" id="page_nav_area">

            </nav>
        </div>
    </div>
</div>
<script type="text/javascript">
    let totalPages,crrentPage;

    // 在页面加载完成以后，直接去发送一个ajax请求，要到分页数据，展示即可
    $(function () {
        to_page(1);
    });

    //跳转到第几页
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                // 1.解析并显示员工数据
                build_emps_table(result);

                // 解析显示分页信息
                build_page_info(result);

                // 解析显示分页条信息
                build_page_nav(result);

            }
        });
    }

    // 解析并显示员工数据
    function build_emps_table(result) {
        // 清空表格
        $("#emps_tables tbody").empty();

        //清除多选框的状态
        $("#check_all").prop("checked",false);

        let emps = result.map.pageInfo.list;
        $.each(emps, function (index, item) {
            let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            let empIdTd = $("<td></td>").append(item.empId);
            let empNameTd = $("<td></td>").append(item.empName);
            let empgenderTd = $("<td></td>").append(item.gender === "M" ? "男" : "女");
            let empemailTd = $("<td></td>").append(item.email);
            let deptNameTd = $("<td></td>").append(item.department.deptName);


            // 添加按钮
            let editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");

            //为编辑按钮添加一个自定义的属性，表示当前员工的id
            editBtn.attr("edit-id",item.empId);

            let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");

            //为删除按钮添加一个自定义的属性，表示当前员工的id
            delBtn.attr("delete-id", item.empId);

            let btnId = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);
            // alert(item.empName);

            // append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empgenderTd)
                .append(empemailTd)
                .append(deptNameTd)
                .append(btnId)
                .appendTo("#emps_tables");
        });
    }

    // 解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        let page_info = result.map.pageInfo;
        $("#page_info_area").append("当前第 " + page_info.pageNum + " 页,总页数 " + page_info.pages + " 页,总记录数 " + page_info.total + " 条");
        totalPages = page_info.total;
        crrentPage=page_info.pageNum;
    }

    // 解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        let ul = $("<ul></ul>").addClass("pagination");

        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        // 当有上一页时
        if (result.map.pageInfo.hasPreviousPage) {

            //为首页添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });

            //将首页按钮添加到ul中
            ul.append(firstPageLi);

            //为上一页添加单击事件
            prePageLi.click(function () {
                to_page(result.map.pageInfo.pageNum - 1);
            });

            //将上一页按钮添加到ul中
            ul.append(prePageLi);
        }


        $.each(result.map.pageInfo.navigatepageNums, function (index, item) {
            let numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.map.pageInfo.pageNum === item)
                numLi.addClass("active");

            //为numLi创造单击事件
            numLi.click(function () {
                to_page(item);
            });


            ul.append(numLi);
        });

        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        let lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

        // 当有下一页时
        if (result.map.pageInfo.hasNextPage) {

            //为下一页添加单击事件
            nextPageLi.click(function () {
                to_page(result.map.pageInfo.pageNum + 1);
            });

            //将尾页按钮添加到ul中
            ul.append(nextPageLi).append(lastPageLi);

            //为下一页添加单击事件
            lastPageLi.click(function () {
                to_page(result.map.pageInfo.pages);
            });

            //将尾页按钮添加到ul中
            ul.append(lastPageLi);
        }

        //将分页条元素添加到导航栏中
        let navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 点击新增按钮打开模态框
    $("#emp_add_modal_btn").click(function () {
        //重置模态框
        reset_form("#empAddModal form");
        // 打开之前，向发送ajax请求，查出部门信息
        // 显示在下拉列表中
        getDepts("#empAddModal select");

        // 打开模态框
        $("#empAddModal").modal({
                //点击背景不隐藏
                backdrop: "static",
                //点击键盘ESC键会退出
                keyboard:true
            }
        )
    });

    // 查出所有的部门信息并显示在下拉列表
    function getDepts(ele) {

        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                // $("#dept_add_select").append();
                $.each(result.map.depts, function (index, item) {
                    let optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele);

                })
            }
        });
    }

    // 校验表单方法之名字
    function validate_add_form_name() {
        // 拿到要校验的数据，使用正则表达式
        // 姓名校验（6-16位英文或者2-10位中文组合）
        let empName = $("#empName_add_input").val();
        let regName = /(^[A-Za-z0-9_-]{6,16}$)|(^[\-\u4e00-\u9fa5]{2,10})/;

        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "error:用户名可以是2-10位中文或者6-16位英文数字组合");
            return false;
        }else{
            show_validate_msg("#empName_add_input", "success", "");
            return true;
        }
    }

    // 校验表单方法之邮箱
    function validate_add_form_email() {
        // 邮箱校验
        let email = $("#email_add_input").val();
        // let regEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        let regEmail = /^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\.[a-z]{2,}$/
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "error:邮箱不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input", "success", "");
            return true;
        }
    }

    //显示输入框的校验状态信息
    function show_validate_msg(ele, status, msg) {
        // 清除当前元素检验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if (status=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status=="error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //重置表单方法
    function reset_form(ele){
        document.getElementById("add_emp_form").reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //改变名字输入框内容时进行前端校验
    $("#empName_add_input").change(function () {
        if (!validate_add_form_name()){
            return false;
        }
        let empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code===100){
                    show_validate_msg("#empName_add_input","success","用户名可用")
                }else {
                    show_validate_msg("#empName_add_input","error","用户名不可用")
                }
            }
        });

    });

    // 改变邮箱输入框内容时进行前端校验
    $("#email_add_input").change(function () {
        if (!validate_add_form_email()){
            return false;
        }
        let email=this.value;
        $.ajax({
            url:"${APP_PATH}/checkemail",
            data:"email="+email,
            type:"POST",
            success:function (result) {
                if (result.code===100){
                    show_validate_msg("#email_add_input","success","邮箱可用")
                }else {
                    show_validate_msg("#email_add_input","error","邮箱不可用")
                }
            }
        });
    });

    // 点击保存按钮
    $("#emp_save_btn").click(function () {
        // alert($("#empAddModal form").serialize());
        let a=0;
        // 进行后端名字校验
        $("#empName_add_input").change(function () {
            if (!validate_add_form_name()){
                a=1;
            }
            let empName=this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if (result.code===100){
                        show_validate_msg("#empName_add_input","success","用户名可用")
                        $("#emp_save_btn").attr("ajax-va","success");
                        a=0;
                    }else {
                        show_validate_msg("#empName_add_input","error","用户名不可用")
                        // $("#emp_save_btn").attr("ajax-va","error");
                        a=1;
                    }
                }
            });
        });
        if(a===1) return;
        // 进行后端邮箱校验
        $("#email_add_input").change(function () {
            if (!validate_add_form_email()){
                $("#emp_save_btn").attr("ajax-va","error");
            }
            let email=this.value;
            $.ajax({
                url:"${APP_PATH}/checkemail",
                data:"email="+email,
                type:"POST",
                success:function (result) {
                    if (result.code===100){
                        show_validate_msg("#email_add_input","success","邮箱可用")
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#email_add_input","error","邮箱不可用")
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });
        });

        //进行判断是否为"error"
        if ($(this).attr("ajax-va")==="error"){
            return false;
        }

        // 发送ajax请求保存员工

        $.ajax({
                        url: "${APP_PATH}/emp",
                        type: "POST",
                        data: $("#empAddModal form").serialize(),
                        success: function (result) {
                            if(result.code==100){
                                //员工保存成功后，关闭模态框
                                $("#empAddModal").modal('hide');
                                // 来到最后一页
                                to_page(totalPages + 1);
                            }else{
                                console.log(result);
                            }

                            // console.log(result.msg);


                        }
                    });
    });


    //编辑按钮事件
   $(document).on("click",".edit_btn",function () {
       //    查出信息并显示
       //部门信息
       getDepts("#empUpdateModal select")
       //员工信息
       getEmp($(this).attr("edit-id"));
       //把员工id传递给模态框的更新按钮
       $("#emp_Update_btn").attr("edit-id", $(this).attr("edit-id"));
       $("#empUpdateModal").modal({
           backdrop: "static"
       })
   });

   //根据员工id查询员工
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                let empData = result.map.emp;
                $("#empName_Update_input").val(empData.empName);
                $("#emp_Update_email").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.empGender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击员工更新按钮
    $("#emp_Update_btn").click(function () {
        //    验证邮箱是否合法
        var email = $("#emp_Update_email").val();
        var regEmail = /^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\.[a-z]{2,}$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#emp_Update_email", "error", "error:邮箱不正确")
            show_validate_msg("#emp_Update_email", "error", "error:邮箱不正确")
            return false;
        } else {
            show_validate_msg("#emp_Update_email", "success", "")
        }

        //    发送ajax请求保存更新数据
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //关闭模态框
                $("#empUpdateModal").modal('hide');
                //    跳回本页面
                to_page(crrentPage);
            }
        });
    });

    //单个删除
    $(document).on("click",".del_btn",function () {
        //确认要删除的员工名字
        //alert($(this).parents("tr").find("td:eq(1)").text());
        //let empName = $(this).parents("tr").find("td:eq(1)").text();
        let empId = $(this).attr("delete-id");
        $.ajax({
            url:"${APP_PATH}/emp/"+empId,
            type:"DELETE",
            success:function (result) {
                // alert(result.msg);
                to_page(crrentPage);
            }
        });
        // if (confirm("确认删除"+empName+"吗？")){
        //     //确认后发送ajax请求删除即可
        //
        // }
    });

    //多个删除
    $("#check_all").click(function () {
        let prop = $(this).prop("checked");
        $(".check_item").prop("checked",prop);
    });

    $(document).on("click",".check_item",function () {
       let flag= $(".check_item:checked").length===$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_del_all").click(function () {
        let empNames="";
        let del_idstr="";
        $.each($(".check_item:checked"),function () {
            let text = $(this).parents("tr").find("td:eq(2)").text()+",";
            empNames+=text;

            //组成装要删除的id字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames= empNames.substring(0,empNames.length-1);
        del_idstr= del_idstr.substring(0,del_idstr.length-1);
        //确认confirm，这里不写

        $.ajax({
            url:"${APP_PATH}/emp/"+del_idstr,
            type:"DELETE",
            success:function (result) {
                alert(result.msg);
                to_page(crrentPage);
            }
        });
    });












</script>
</body>
</html>
