<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>教师列表</title>
	<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="easyui/css/demo.css">
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/js/validateExtends.js"></script>
	<script type="text/javascript">
	$(function() {	
		var table;
		
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'教师列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"TeacherServlet?method=TeacherList&t="+new Date().getTime(),
	        idField:'tid', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'tid',
	        sortOrder:'ASC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'tid',title:'工号',width:100, sortable: true},    
 		        {field:'teachername',title:'姓名',width:100},
 		        {field:'gender',title:'性别',width:50},
 		        {field:'college',title:'学院',width:150},
 		        {field:'tel',title:'电话',width:100},
 		        {field:'email',title:"邮箱",width:200},
 		        {field:'qq',title:'QQ',width:100},
 		        {field:'wechat',title:'微信',width:150},
 		        {field:'position',title:'职称',width:80},
 		       	{field:'admin',title:'类别',width:80,formatter:function(value,row,index){
 		       		if(value=="1")
 		       			return "管理员";
 		       		if(value=="3")
 		       			return "教师";
 		       	}}
	 		]], 
	        toolbar: "#toolbar",
	       
	        onLoadSuccess : function(){
	       
	        	try{
	        		var rows = $("#dataList").datagrid("getRows"); //这段代码是获取当前页的所有行。
	        		for(var i=0;i<rows.length;i++)
	        		{
	        		//获取每一行的数据
	        		//alert(rows[i].id);//假设有id这个字段
	        		//alert(rows[i].admin);
	        		if(rows[i].admin=="3"){
	        			rows[i].admin="教师";
	        		}
	        		if(rows[i].admin=="1"){
	        			rows[i].admin="管理员";
	        		}
	        		$("#dataList").datagrid("refreshRow",i);
	        		}
	        		
	        	}catch(err){
	        		preLoadTeacher();
	        	}
	       
	        }
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
	    	table = $("#addTable");
	    	$("#addDialog").dialog("open");
	    });
	    //修改
	    $("#edit").click(function(){
	    	table = $("#editTable");
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	if(selectRows.length != 1){
            	$.messager.alert("消息提醒", "请选择一条数据进行操作!", "warning");
            } else{
		    	$("#editDialog").dialog("open");
            }
	    });
	    
	    //导出
	    $("#export").click(function(){
	    	$.messager.confirm("消息提醒", "将导出教师相关的所有数据，确认继续？", function(r){
        		if(r){
        			$.ajax({
						type: "post",
						url: "TeacherServlet?method=ExportTeacher",
						
						success: function(msg){
							if(msg == "success"){
								$.messager.alert("消息提醒","导出成功!","info");
							
							} else{
								$.messager.alert("消息提醒","删除失败!","warning");
								return;
							}
						}
					});
        		}
        	});
	    });
	    //String[] s;
	    // for(String t:s)
	    //删除
	    $("#delete").click(function(){
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	var selectLength = selectRows.length;
        	if(selectLength == 0){
            	$.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
            	return;
            } else{
            	//var ids = [];
            	var ids = "";
            	$(selectRows).each(function(i, row){
            	//	ids[i] = row.id;
            	ids = ids + "," + row.tid;   //,10250001,10240003
            	});
            	$.messager.confirm("消息提醒", "将删除与教师相关的所有数据，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "TeacherServlet?method=DeleteTeacher",
							data: {ids: ids},
							success: function(msg){
								if(msg == "success"){
									$.messager.alert("消息提醒","删除成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
									$("#dataList").datagrid("uncheckAll");
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
	    
	    function preLoadTeacher(){
	  		$("#teacherList").combobox({
		  		width: "150",
		  		height: "25",
		  		valueField: "id",
		  		textField: "name",
		  		multiple: false, //可多选
		  		editable: false, //不可编辑
		  		method: "post",
		  		url: "TeacherServlet?method=getTeacherList&t="+new Date().getTime()+"&from=combox",
		  		onChange: function(newValue, oldValue){
		  			//加载班级下的学生
		  			//$('#dataList').datagrid("options").queryParams = {clazzid: newValue};
		  			//$('#dataList').datagrid("reload");
		  		}
		  	});
	  	}
	    
	  	//设置添加窗口
	    $("#addDialog").dialog({
	    	title: "添加教师",
	    	width: 850,
	    	height: 650,
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
					iconCls:'icon-user_add',
					handler:function(){
						var validate = $("#addForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							
							$.ajax({
								type: "post",
								url: "TeacherServlet?method=AddTeacher",
								data: $("#addForm").serialize(),
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","添加成功!","info");
										//关闭窗口
										$("#addDialog").dialog("close");
										//清空原表格数据
										$("#add_tid").textbox('setValue', "");
										$("#add_teachername").textbox('setValue', "");
										$("#add_gender").combobox('setValue', "男");
										$("#add_tel").textbox('setValue', "");
										$("#add_qq").textbox('setValue', "");
										$("#add_email").textbox('setValue', "");
										$("#add_position").combobox('setValue', "讲师");
										$("#add_password").textbox('setValue',"");
										$("#add_college").textbox('setValue',"");
										$("#add_admin").combobox('setValue',"1");
										$("#add_wechat").textbox('setValue',"")
										//重新刷新页面数据
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
						$("#add_tid").textbox('setValue', "");
						$("#add_teachername").textbox('setValue', "");
						$("#add_gender").combobox('setValue', "男");
						$("#add_tel").textbox('setValue', "");
						$("#add_qq").textbox('setValue', "");
						$("#add_email").textbox('setValue', "");
						$("#add_position").combobox('setValue', "讲师");
						$("#add_password").textbox('setValue',"");
						$("#add_college").textbox('setValue',"");
						$("#add_admin").combobox('setValue',"1");
						$("#add_wechat").textbox('setValue',"")
						
					}
				},
			],
			onClose: function(){
				$("#add_tid").textbox('setValue', "");
				$("#add_teachername").textbox('setValue', "");
				$("#add_gender").combobox('setValue', "男");
				$("#add_tel").textbox('setValue', "");
				$("#add_qq").textbox('setValue', "");
				$("#add_email").textbox('setValue', "");
				$("#add_position").combobox('setValue', "讲师");
				$("#add_password").textbox('setValue',"");
				$("#add_college").textbox('setValue',"");
				$("#add_admin").combobox('setValue',"1");
				$("#add_wechat").textbox('setValue',"")
				
				
			}
	    });
	  	
	  	
	  
	  	
	  	//编辑教师信息
	  	$("#editDialog").dialog({
	  		title: "修改教师信息",
	    	width: 850,
	    	height: 650,
	    	iconCls: "icon-edit",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'提交',
					plain: true,
					iconCls:'icon-user_add',
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
						//	var clazzid = $("#edit_clazzList").combobox("getValue");
							
							var qq = $("#edit_qq").textbox("getText");
							var tid = $("#edit_tid").textbox('getValue');
							var teachername = $("#edit_teachername").textbox('getValue');
							var gender=$("#edit_gender").combobox('getValue');
							var college = $("#edit_college").textbox('getValue');
							var tel=$("#edit_tel").textbox('getValue');
							var email=$("#edit_email").textbox('getValue');
							var password=$("#edit_password").textbox('getValue');
							var wechat=$("#edit_wechat").textbox('getValue');		
							var admin=$("#edit_admin").combobox('getValue');
							var position=$("#edit_position").combobox('getValue');
							
							var data = {tid:tid, gender:gender,teachername:teachername,college:college,tel:tel,qq:qq,email:email,password:password,wechat:wechat,admin:admin,position:position};
							
							$.ajax({
								type: "post",
								url: "TeacherServlet?method=EditTeacher",
								data: data,
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","修改成功!","info");
										//关闭窗口
										$("#editDialog").dialog("close");
										//清空原表格数据
										$("#edit_tid").textbox('setValue', "");
										$("#edit_teachername").textbox('setValue',"");
										$("#edit_gender").combobox('setValue', "男");
										$("#edit_college").textbox('setValue',"");
										$("#edit_tel").textbox('setValue', "");
										$("#edit_email").textbox('setValue', "");
										$("#edit_password").textbox('setValue',"");
										$("#edit_wechat").textbox('setValue', "");			
										$("#edit_qq").textbox('setValue', "");
										$("#edit_admin").combobox('setValue', "1");
										$("#edit_position").combobox('setValue', "讲师");
										
										//重新刷新页面数据
							  			$('#dataList').datagrid("reload");
							  			$('#dataList').datagrid("uncheckAll");
										
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
						$("#edit_tid").textbox('setValue', "");
						$("#edit_teachername").textbox('setValue',"");
						$("#edit_gender").combobox('setValue', "男");
						$("#edit_college").textbox('setValue',"");
						$("#edit_tel").textbox('setValue', "");
						$("#edit_email").textbox('setValue', "");
						$("#edit_password").textbox('setValue',"");
						$("#edit_wechat").textbox('setValue', "");			
						$("#edit_qq").textbox('setValue', "");
						$("#edit_admin").combobox('setValue', "1");
						$("#edit_position").combobox('setValue', "讲师");
						
					}
				},
			],
			onBeforeOpen: function(){
				var selectRow = $("#dataList").datagrid("getSelected");
				//设置值
				$("#edit_tid").textbox('setValue', selectRow.tid);
				$("#edit_teachername").textbox('setValue', selectRow.teachername);
				$("#edit_gender").textbox('setValue', selectRow.gender);
				$("#edit_college").textbox('setValue', selectRow.college);
				$("#edit_tel").textbox('setValue', selectRow.tel);
				$("#edit_email").textbox('setValue', selectRow.email);
				$("#edit_password").textbox('setValue',"");
				$("#edit_wechat").textbox('setValue', selectRow.wechat);		
				$("#edit_qq").textbox('setValue', selectRow.qq);
			//	$("#edit_admin").textbox('setValue', selectRow.admin);
				$("#edit_position").textbox('setValue', selectRow.position);
				
				$.ajax({
						type:"post",
						url:"PhotoServlet?method=getPhoto",
						data:{tid:selectRow.tid},
						success:function(msg){
							
							$("#edit_photo").attr("src","."+msg);
						}
					});
			    //为hidden输入域赋值，教师工号
				$("#set-photo-id").val(selectRow.tid);
				var typeid = selectRow.admin;
				if(typeid=="1")
				{
					$("#edit_admin").combobox('setValue',"1");
				}	
				else if(typeid=="3"){
					$("#edit_admin").combobox('setValue',"3");
				}
				
			},
			onClose: function(){
				$("#edit_tid").textbox('setValue', "");
				$("#edit_teachername").textbox('setValue',"");
				$("#edit_gender").combobox('setValue', "男");
				$("#edit_college").textbox('setValue',"");
				$("#edit_tel").textbox('setValue', "");
				$("#edit_email").textbox('setValue', "");
				$("#edit_password").textbox('setValue',"");
				$("#edit_wechat").textbox('setValue', "");			
				$("#edit_qq").textbox('setValue', "");
				$("#edit_admin").combobox('setValue', "1");
				$("#edit_position").combobox('setValue', "讲师");
			}
	    });
	   	
	  	 //搜索按钮监听事件
	  	$("#search-btn").click(function(){
	  		$('#dataList').datagrid('load',{
	  			teacherName: $('#search_teachername').val()
	  		});
	  	});
		});
	
	//上传图片按钮事件
	$("#upload-photo-btn").click(function(){
		
	});
	function uploadPhoto(){
		var action = $("#uploadForm").attr('action');
		var pos = action.indexOf('tid');
		if(pos != -1){
			action = action.substring(0,pos-1);
		}
		$("#uploadForm").attr('action',action+'&tid='+$("#set-photo-id").val());
		$("#uploadForm").submit();
		setTimeout(function(){
			var message =  $(window.frames["photo_target"].document).find("#message").text();
			$.messager.alert("消息提醒",message,"info");
			
			$("#edit_photo").attr("src", "PhotoServlet?method=getPhoto&tid="+$("#set-photo-id").val());
		}, 1500)
	}
	</script>
</head>
<body>
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	    
	</table> 
	<!-- 工具栏 -->
	<div id="toolbar">
		<c:if test="${userType == 1}">
		<div style="float: left;"><a id="add" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a></div>
			<div style="float: left;" class="datagrid-btn-separator"></div>
		</c:if>
		<div style="float: left;"><a id="edit" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></div>
			<div style="float: left;" class="datagrid-btn-separator"></div>
		<c:if test="${userType == 1}">
		<div style="float: left;"><a id="delete" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
		</c:if>
		<c:if test="${userType == 1}">
		<div style="float: left;"><a id="export" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-man',plain:true">导出</a></div>
		</c:if>
		<div style="float: left;margin-top:4px;" class="datagrid-btn-separator" >&nbsp;&nbsp;姓名：<input id="search_teachername" class="easyui-textbox" name="search_teachername" /></div>
		<div style="margin-left: 10px;margin-top:4px;" >
			<a id="search-btn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">搜索</a>
		</div>		
	</div>
	
	<!-- 添加窗口 -->
	<div id="addDialog" style="padding: 10px;">  
		<div style=" position: absolute; margin-left: 560px; width: 200px; border: 1px solid #EEF4FF" id="photo">
	    	<img id="add_photo" alt="照片" style="max-width: 200px; max-height: 400px;" title="照片" src="" />
	    	<form id="add_uploadForm" method="post" enctype="multipart/form-data" action="PhotoServlet?method=SetPhoto" target="photo_target">
	    		<!-- StudentServlet?method=SetPhoto -->
	    		<input type="hidden" name="tid" id="set-photo-id">
		    	<input class="easyui-filebox" name="photo" data-options="prompt:'选择照片'" style="width:200px;">
		    	<input id="upload-photo-btn" onClick="uploadPhoto()" class="easyui-linkbutton" style="width: 50px; height: 24px;" type="button" value="上传"/>
		    </form>
	    </div> 
   		<form id="addForm" method="post">
	    	<table id="addTable" border=0 style="width:800px; table-layout:fixed;" cellpadding="6" >
	    		<tr>
	    			<td>工号:</td>
	    			<td colspan="4"><input id="add_tid" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="tid" data-options="required:true, missingMessage:'请填写工号'" valideType="number"/></td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td colspan="4"><input id="add_teachername" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teachername" data-options="required:true, missingMessage:'请填写姓名'" /></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td colspan="4"><input id="add_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password" name="password" data-options="required:true, missingMessage:'请填写密码'" /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td colspan="4"><select id="add_gender" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 60, height: 30" name="gender"><option value="男">男</option><option value="女">女</option></select></td>
	    		</tr>
	    		<tr>
	    			<td>学院:</td>
	    			<td colspan="4"><input id="add_college" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="college" /></td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td colspan="4"><input id="add_tel" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="tel" validType="mobile" /></td>
	    		</tr>
	    		<tr>
	    			<td>QQ:</td>
	    			<td colspan="4"><input id="add_qq" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="qq" validType="number" /></td>
	    		</tr>
	    		<tr>
	    			<td>EMail:</td>
	    			<td colspan="4"><input id="add_email" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="email" validType="email" /></td>
	    		</tr>
	    		<tr>
	    			<td>微信号:</td>
	    			<td colspan="4"><input id="add_wechat" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="wechat" /></td>
	    		</tr>
	    		<tr>
	    			<td>职称:</td>
	    			<td colspan="4"><select id="add_position" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 100, height: 30" name="position"><option value="教授">教授</option>
	    			<option value="副教授">副教授</option><option value="讲师">讲师</option><option value="助教">助教</option></select></td>
	    		</tr>
	    		<tr>
	    			<td>是否管理员:</td>
	    			<td colspan="4"><select id="add_admin" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 60, height: 30" name="admin"><option value="1">是</option><option value="3">否</option></select></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
	
	<!-- 修改窗口 -->
	<div id="editDialog" style="padding: 10px">
		<div style=" position: absolute; margin-left: 560px; width: 200px; border: 1px solid #EEF4FF">
	    	<img id="edit_photo" alt="照片" style="max-width: 200px; max-height: 400px;" title="照片" src="" />
	    	<form id="uploadForm" method="post" enctype="multipart/form-data" action="PhotoServlet?method=SetPhoto" target="photo_target">
	    		<!-- StudentServlet?method=SetPhoto -->
	    		<input type="hidden" name="tid" id="set-photo-id">
		    	<input class="easyui-filebox" name="photo" data-options="prompt:'选择照片'" style="width:200px;">
		    	<input id="upload-photo-btn" onClick="uploadPhoto()" class="easyui-linkbutton" style="width: 50px; height: 24px;" type="button" value="上传"/>
		    </form>
	    </div>   
    	<form id="editForm" method="post">
	    	<table id="editTable" border=0 style="width:800px; table-layout:fixed;" cellpadding="6" >
	    		<tr>
	    			<td>工号:</td>
	    			<td colspan="4"><input id="edit_tid" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="tid" data-options="required:true, missingMessage:'请填写工号'" readonly="readonly" valideType="number"/></td>
	    		</tr>
	    		<tr>
	    			<td>姓名:</td>
	    			<td colspan="4"><input id="edit_teachername" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="teachername" data-options="required:true, missingMessage:'请填写姓名'" /></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td colspan="4"><input id="edit_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password" name="password" data-options="required:true, missingMessage:'请填写密码'" /></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td colspan="4"><select id="edit_gender" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 60, height: 30" name="gender"><option value="男">男</option><option value="女">女</option></select></td>
	    		</tr>
	    		<tr>
	    			<td>学院:</td>
	    			<td colspan="4"><input id="edit_college" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="college" /></td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td colspan="4"><input id="edit_tel" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="tel" validType="mobile" /></td>
	    		</tr>
	    		<tr>
	    			<td>QQ:</td>
	    			<td colspan="4"><input id="edit_qq" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="qq" validType="number" /></td>
	    		</tr>
	    		<tr>
	    			<td>EMail:</td>
	    			<td colspan="4"><input id="edit_email" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="email" validType="email" /></td>
	    		</tr>
	    		<tr>
	    			<td>微信号:</td>
	    			<td colspan="4"><input id="edit_wechat" style="width: 200px; height: 30px;" class="easyui-textbox" type="text" name="wechat" /></td>
	    		</tr>
	    		<tr>
	    			<td>职称:</td>
	    			<td colspan="4"><select id="edit_position" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 100, height: 30" name="position"><option value="教授">教授</option>
	    			<option value="副教授">副教授</option><option value="讲师">讲师</option><option value="助教">助教</option></select></td>
	    		</tr>
	    		<tr>
	    			<td>是否管理员:</td>
	    			<td colspan="4"><select id="edit_admin" class="easyui-combobox" data-options="editable: false, panelHeight: 50, width: 60, height: 30" name="admin"><option value="1">是</option><option value="3">否</option></select></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
<iframe id="photo_target" name="photo_target"></iframe>  	
</body>
</html>