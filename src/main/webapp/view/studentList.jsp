<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>学生信息列表</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/css/demo.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/js/validateExtends.js"></script>
	<script type="text/javascript">
	$(function() {	
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'学生专业列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible: false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"${pageContext.request.contextPath}/StudentServlet?method=getStudentList&t="+new Date().getTime(),
	        idField:'id', 
	        singleSelect: true,//是否单选 
	        pagination: true,//分页控件 
	        rownumbers: false,//行号 
	        sortName: 'id',
	        sortOrder: 'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'sid',title:'学号',width:50, sortable: true},    
 		        {field:'studentname',title:'学生姓名',width:100},
 		        {field:'gender',title:'性别',width:200},
 		        {field:'region',title:'籍贯',width:200},
 		        {field:'cid',title:'班级',width:200},
 		        {field:'gid',title:'年级',width:200},
 		        {field:'nationality',title:'国籍',width:200},
 		        {field:'politics',title:'政治面貌',width:200},
 		        {field:'dorm',title:'宿舍号',width:200},
 		        {field:'bank',title:'银行卡号',width:200},
 		        {field:'id',title:'身份证号',width:200},
 		        {field:'tel',title:'电话号',width:200},
 		        {field:'email',title:'邮箱',width:200},
 		        {field:'qq',title:'QQ号',width:200},
 		        {field:'weichat',title:'微信',width:200},
 		        {field:'weibo',title:'微博',width:200},
 		        {field:'mother',title:'母亲',width:200},
 		        {field:'mothertel',title:'母亲手机号',width:200},
 		        {field:'father',title:'父亲',width:200},
 		        {field:'fathertel',title:'父亲手机号',width:200},
 		        {field:'residence',title:'户口',width:200},
 		        {field:'home',title:'现居地',width:200},
 		        {field:'status',title:'状态',width:200},
 		        {field:'memo',title:'备注',width:200},
 		        {field:'tid',title:'教师学号',width:200},
 		        
	 		]], 
	        toolbar: "#toolbar"
	    }); 
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    });
	    //设置工具类按钮
	    $("#add").click(function(){
	    	$("#addDialog").dialog("open");
	    });
	    //删除
	    $("#delete").click(function(){
	    	var selectRow = $("#dataList").datagrid("getSelected");
	    	//console.log(selectRow);
        	if(selectRow == null){
            	$.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
           	return ;
        	} else{
            	var gradeid = selectRow.id;
            	$.messager.confirm("消息提醒", "将删除学生信息（如果该年级专业存在学生或教师则不能删除），确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "${pageContext.request.contextPath}/StudentServlet?method=DeleteStudent",
							data: {studentsid: studentsid},
							success: function(msg){
								if(msg == "success"){
									$.messager.alert("消息提醒","删除成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
								} else{
									$.messager.alert("消息提醒","删除失败!","warning");
									return;
								}
							}
						});
            		}
            	});
            }
	    });
	    
	    
	  	
	  	//设置添加班级窗口
	    $("#addDialog").dialog({
	    	title: "添加学生信息",
	    	width: 500,
	    	height: 400,
	    	iconCls: "icon-add",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'添加',
					plain: true,
					iconCls:'icon-add',
					handler:function(){
						var validate = $("#addForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							//var gradeid = $("#add_gradeList").combobox("getValue");
							$.ajax({
								type: "post",
								url: "${pageContext.request.contextPath}/StudentServlet?method=AddStudent",
								data: $("#addForm").serialize(),
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","添加成功!","info");
										//关闭窗口
										$("#addDialog").dialog("close");
										//清空原表格数据
										$("#add_sid").textbox('setValue', "");
										$("#add_studentname").textbox('setValue', "");
										$("#add_gender").textbox('setValue', "");
										$("#add_region").textbox('setValue', "");
										$("#add_cid").textbox('setValue', "");
										$("#add_gid").textbox('setValue', "");
										$("#add_nationality").textbox('setValue', "");
										$("#add_politics").textbox('setValue', "");
										$("#add_dorm").textbox('setValue', "");
										$("#add_bank").textbox('setValue', "");
										$("#add_id").textbox('setValue', "");
										$("#add_tel").textbox('setValue', "");
										$("#add_email").textbox('setValue', "");
										$("#add_qq").textbox('setValue', "");
										$("#add_weichat").textbox('setValue', "");
										$("#add_weibo").textbox('setValue', "");
										$("#add_mother").textbox('setValue', "");
										$("#add_mothertel").textbox('setValue', "");
										$("#add_father").textbox('setValue', "");
										$("#add_fathertel").textbox('setValue', "");
										$("#add_residence").textbox('setValue', "");
										$("#add_home").textbox('setValue', "");
										$("#add_status").textbox('setValue', "");
										$("#add_tid").textbox('setValue', "");
										
										$("#add_memo").val("");
										//重新刷新页面数据
							  			//$('#gradeList').combobox("setValue", gradeid);
							  			$('#dataList').datagrid("reload");
										
									} else{
										$.messager.alert("消息提醒","添加失败!","warning");
										return;
									}
								}
							});
						}
					}
				},
				{
					text:'重置',
					plain: true,
					iconCls:'icon-reload',
					handler:function(){
						$("#add_name").textbox('setValue', "");
						//重新加载年级专业
						$("#info").val("");
					}
				},
			]
	    });
	  	
	  	
	  	//搜索按钮监听事件
	  	$("#search-btn").click(function(){
	  		$('#dataList').datagrid('load',{
	  			gradeName: $('#gradeName').val()
	  		});
	  	});
	  	
	  //修改按钮监听事件
	  	$("#edit-btn").click(function(){
	  		var selectRow = $("#dataList").datagrid("getSelected");
	    	//console.log(selectRow);
        	if(selectRow == null){
            	$.messager.alert("消息提醒", "请选择数据进行修改!", "warning");
            	return;
            }
        	$("#editDialog").dialog("open");
	  	});
	  
	  //设置编辑学生窗口
	    $("#editDialog").dialog({
	    	title: "编辑学生信息",
	    	width: 500,
	    	height: 400,
	    	iconCls: "icon-add",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'确定修改',
					plain: true,
					iconCls:'icon-add',
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							//var gradeid = $("#add_gradeList").combobox("getValue");
							$.ajax({
								type: "post",
								url: "StudentServlet?method=EditStudent",
								data: $("#editForm").serialize(),
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","修改成功!","info");
										//关闭窗口
										$("#editDialog").dialog("close");
										//清空原表格数据
										$("#edit_sid").textbox('setValue', "");
										$("#editstudentname").textbox('setValue', "");
										$("#edit_gender").textbox('setValue', "");
										$("#edit_region").textbox('setValue', "");
										$("#edit_cid").textbox('setValue', "");
										$("#edit_gid").textbox('setValue', "");
										$("#edit_nationality").textbox('setValue', "");
										$("#edit_politics").textbox('setValue', "");
										$("#edit_dorm").textbox('setValue', "");
										$("#edit_bank").textbox('setValue', "");
										$("#edit_id").textbox('setValue', "");
										$("#edit_tel").textbox('setValue', "");
										$("#edit_email").textbox('setValue', "");
										$("#edit_qq").textbox('setValue', "");
										$("#edit_weichat").textbox('setValue', "");
										$("#edit_weibo").textbox('setValue', "");
										$("#edit_mother").textbox('setValue', "");
										$("#edit_mothertel").textbox('setValue', "");
										$("#edit_father").textbox('setValue', "");
										$("#edit_fathertel").textbox('setValue', "");
										$("#edit_residence").textbox('setValue', "");
										$("#edit_home").textbox('setValue', "");
										$("#edit_status").textbox('setValue', "");
										$("#edit_tid").textbox('setValue', "");
										
										$("#edit_memo").val("");
										//重新刷新页面数据
							  			//$('#gradeList').combobox("setValue", gradeid);
							  			$('#dataList').datagrid("reload");
										
									} else{
										$.messager.alert("消息提醒","修改失败!","warning");
										return;
									}
								}
							});
						}
					}
				},
				{
					text:'重置',
					plain: true,
					iconCls:'icon-reload',
					handler:function(){
						$("#edit_sid").textbox('setValue', "");
						$("#edit_studentname").textbox('setValue', "");
						$("#edit_gender").textbox('setValue', "");
						$("#edit_region").textbox('setValue', "");
						$("#edit_cid").textbox('setValue', "");
						$("#edit_gid").textbox('setValue', "");
						$("#edit_nationality").textbox('setValue', "");
						$("#edit_politics").textbox('setValue', "");
						$("#edit_dorm").textbox('setValue', "");
						$("#edit_bank").textbox('setValue', "");
						$("#edit_id").textbox('setValue', "");
						$("#edit_tel").textbox('setValue', "");
						$("#edit_email").textbox('setValue', "");
						$("#edit_qq").textbox('setValue', "");
						$("#edit_weichat").textbox('setValue', "");
						$("#edit_weibo").textbox('setValue', "");
						$("#edit_mother").textbox('setValue', "");
						$("#edit_mothertel").textbox('setValue', "");
						$("#edit_father").textbox('setValue', "");
						$("#edit_fathertel").textbox('setValue', "");
						$("#edit_residence").textbox('setValue', "");
						$("#edit_home").textbox('setValue', "");
						$("#edit_status").textbox('setValue', "");
						$("#edit_tid").textbox('setValue', "");
						
						//重新加载年级
						$("#edit_memo").val("");
					}
				},
			],
			onBeforeOpen: function(){
				var selectRow = $("#dataList").datagrid("getSelected");
				//console.log(selectRow);
				//设置值
				$("#edit_sid").textbox('setValue', selectRow.sid);
				$("#edit_studentname").textbox('setValue', selectRow.studentname);
				$("#edit_gender").textbox('setValue', selectRow.gender);
				$("#edit_region").textbox('setValue', selectRow.region);
				$("#edit_cid").textbox('setValue', selectRow.cid);
				$("#edit_gid").textbox('setValue', selectRow.gid);
				$("#edit_nationality").textbox('setValue', selectRow.nationality);
				$("#edit_politics").textbox('setValue', selectRow.politics);
				$("#edit_dorm").textbox('setValue', selectRow.dorm);
				$("#edit_bank").textbox('setValue', selectRow.bank);
				$("#edit_id").textbox('setValue', selectRow.id);
				$("#edit_tel").textbox('setValue', selectRow.tel);
				$("#edit_email").textbox('setValue', selectRow.email);
				$("#edit_qq").textbox('setValue', selectRow.qq);
				$("#edit_weichat").textbox('setValue', selectRow.weichat);
				$("#edit_weibo").textbox('setValue', selectRow.weibo);
				$("#edit_mother").textbox('setValue', selectRow.mother);
				$("#edit_mothertel").textbox('setValue', selectRow.mothertel);
				$("#edit_father").textbox('setValue', selectRow.father);
				$("#edit_fathertel").textbox('setValue', selectRow.fathertel);
				$("#edit_residence").textbox('setValue', selectRow.residence);
				$("#edit_home").textbox('setValue', selectRow.home);
				$("#edit_status").textbox('setValue', selectRow.status);
				$("#edit_tid").textbox('setValue', selectRow.tid);
				$("#edit_memo").val(selectRow.memo);
			}
	    });
	  
	});
	</script>
</head>
<body>
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	</table> 
	
	<!-- 工具栏 -->
	<div id="toolbar">
		<div style="float: left;"><a id="add" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
		<div style="float: left; margin-right: 10px;"><a id="edit-btn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
		<div style="float: left; margin-right: 10px;"><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
		<div style="margin-top: 3px;">年级：<input id="改改改gradeName" class="easyui-textbox" name="gradeName" />
			<a id="search-btn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">搜索</a>
		</div>
	</div>
	
	<!-- 添加窗口 -->
	<div id="addDialog" style="padding: 10px">  
    	<form id="addForm" method="post">
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>学号:</td>
	    			<td><input id="add_sid" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="sid"  data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="add_studentname" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="major"  data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td>
	    				<input id="add_gender" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>籍贯:</td>
	    			<td>
	    				<input id="add_region" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>班级:</td>
	    			<td>
	    				<input id="add_class" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>年级:</td>
	    			<td>
	    				<input id="add_grade" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>国籍:</td>
	    			<td>
	    				<input id="add_nationality" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>政治面貌:</td>
	    			<td>
	    			     <input id="add_politics" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>宿舍号:</td>
	    			<td>
	    				<input id="add_dorm" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>银行卡号:</td>
	    			<td>
	    				<input id="add_bank" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>身份证号:</td>
	    			<td>
	    				<input id="add_id" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td>
	    				<input id="add_tel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>邮箱:</td>
	    			<td>
	    				<input id="add_email" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>qq:</td>
	    			<td>
	    				<input id="add_qq" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>微信:</td>
	    			<td>
	    				<input id="add_weichat" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>微博:</td>
	    			<td>
	    				<input id="add_weibo" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>母亲:</td>
	    			<td>
	    				<input id="add_mother" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>母亲电话:</td>
	    			<td>
	    				<input id="add_mothertel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>父亲:</td>
	    			<td>
	    				<input id="add_father" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>父亲电话:</td>
	    			<td>
	    				<textarea id="add_fathertel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>户口:</td>
	    			<td>
	    				<textarea id="add_residence" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>现居地:</td>
	    			<td>
	    				<input id="add_home" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>状态:</td>
	    			<td>
	    				<input id="add_status" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td>
	    				<input id="add_memo" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>教师学号:</td>
	    			<td>
	    				<input id="add_tid" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
	<!-- 编辑窗口 -->
	<div id="editDialog" style="padding: 10px">  
    	<form id="editForm" method="post">
    	<input type="hidden" id="edit_id" name="id">
	    	<table cellpadding="8" >
	    		<tr>
	    			<td>学号:</td>
	    			<td><input id="edit_sid" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="sid"  data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td><input id="edit_studentname" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="major"  data-options="required:true, missingMessage:'不能为空'" /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td>
	    				<input id="edit_gender" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>籍贯:</td>
	    			<td>
	    				<textarea id="edit_region" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>班级:</td>
	    			<td>
	    				<textarea id="edit_class" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>年级:</td>
	    			<td>
	    				<textarea id="edit_grade" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>国籍:</td>
	    			<td>
	    				<input id="edit_nationality" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>政治面貌:</td>
	    			<td>
	    				<textarea id="edit_politics" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>宿舍号:</td>
	    			<td>
	    				<input id="edit_dorm" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>银行卡号:</td>
	    			<td>
	    				<input id="edit_bank" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>身份证号:</td>
	    			<td>
	    				<input id="edit_id" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td>
	    				<input id="edit_tel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>邮箱:</td>
	    			<td>
	    				<input id="edit_email" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>qq:</td>
	    			<td>
	    				<textarea id="edit_qq" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>微信:</td>
	    			<td>
	    				<textarea id="edit_weichat" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>微博:</td>
	    			<td>
	    				<textarea id="edit_weibo" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>母亲:</td>
	    			<td>
	    				<input id="edit_mother" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>母亲电话:</td>
	    			<td>
	    				<input id="edit_mothertel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>父亲:</td>
	    			<td>
	    				<textarea id="edit_father" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>父亲电话:</td>
	    			<td>
	    				<textarea id="edit_fathertel" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>户口:</td>
	    			<td>
	    				<textarea id="edit_residence" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>现居地:</td>
	    			<td>
	    				<input id="edit_home" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>状态:</td>
	    			<td>
	    				<input id="edit_status" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td>
	    				<input id="edit_memo" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>教师学号:</td>
	    			<td>
	    				<input id="edit_tid" name="memo" style="width: 200px; height: 60px;" class="" ></textarea>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
</body>
</html>