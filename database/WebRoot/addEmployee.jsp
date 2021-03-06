<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.page import="java.sql.Date"/>
<jsp:directive.page import="com.helloweenvsfei.dao.EmployeeDAO"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.helloweenvsfei.bean.Employee"/>
<jsp:directive.page import="com.helloweenvsfei.dao.DepartmentDAO"/>
<jsp:directive.page import="com.helloweenvsfei.bean.Department"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	
	if("add".equals(action)){
		Department department = DepartmentDAO.find(Integer.parseInt(request.getParameter("departmentId")));
		Employee employee = new Employee();
		employee.setDepartment(department);
		employee.setName(request.getParameter("name"));
		employee.setSex(request.getParameter("sex"));
		employee.setEmployedDate(Date.valueOf(request.getParameter("employedDate")));
		
		System.out.println(employee.getEmployedDate());
		
		EmployeeDAO.insert(employee);
		
		response.sendRedirect("listEmployee.jsp");
		return;
	}

	List departmentList = DepartmentDAO.listDepartments();
	request.setAttribute("departmentList", departmentList);
	
	boolean isEdit = "edit".equals(action);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= isEdit ? "修改员工资料" : "新建员工资料" %></title>
<style type="text/css">body, td{font-size:12px; }</style>
</head>
<body>

<script type="text/javascript" src="js/calendar.js"></script>

<form action="addEmployee.jsp" method="post">

<input type="hidden" name="action" value="<%= isEdit ? "save" : "add" %>">
<input type="hidden" name="id" value="${ employee.id }">

<fieldset>
	<legend><%= isEdit ? "修改人员资料" : "新建员工资料" %></legend>
	<table align=center>
		<tr>
			<td>姓名</td>
			<td><input type="text" name="name" value="${ employee.name }"/></td>
		</tr>
		<tr>
			<td>部门</td>
			<td>
				<select name="departmentId">
					<c:forEach items="${ departmentList }" var="department">
						<option value="${ department.id }">${ department.name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>性别</td>
			<td>
				<input type="radio" name="sex" value="男" id="sex_male" /><label for="sex_male">男</label>
				<input type="radio" name="sex" value="女" id="sex_female" /><label for="sex_female">女</label>
			</td>
		</tr>
		<tr>
			<td>入职日期</td>
			<td>
				<input type="text" name="employedDate" onfocus="setday(employedDate)" value="${ employee.employedDate }"/>
				<img src="images/calendar.gif" onclick="setday(employedDate);" />
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="submit" value="<%= isEdit ? "保存" : "添加员工信息" %>"/>
				<input type="button" value="返回" onclick="history.go(-1); " />
			</td>
		</tr>
	</table>
</fieldset>
</form>


</body>
</html>