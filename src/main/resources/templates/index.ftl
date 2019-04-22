<!DOCTYPE html>
<html>
    <title>端口统计</title>
    <#include "./common/head.ftl">
    
<body>
	
	<div id="app">
	
		<div class="page-header">
			<h3 class="text-center text-info"> <span style="color">10.92.183.128</span>服务端口统计表 </h3>
		</div>
		
		<div class="panel panel-info">
			<div class="panel-footer form-inline">
				<label style="width:280px">
					请输入关键字（范围：端口到更新时间）
				</label>
				<input type="text" class="form-control" v-model="kw_key" placeholder="如：80">
				&nbsp; <input type="button" value="查询" class="btn btn-info" @click="searchKeyword(1, 10)">
				&nbsp; <span class="text-muted">{{default_text}}</span>
				<span class="label label-warning">{{kw_key_color}}</span>
				
				<div class="pull-right">
					<a id="modal-509177" href="#modal-container-509177" role="button" class="btn btn-info" data-toggle="modal">新增</a>
				</div>
			</div>
		</div>
		
		<div class="panel panel-info">
			<table class="table table-bordered table-hover table-striped">
				<thead>
					<tr>
						<th> 端口 </th>
						<th> 服务名 </th>
						<th> 服务作用与说明 </th>
						<th> 核心数据或配置文件目录 </th>
						<th> 维护者 </th>
						<th> 状态 </th>
						<th> 创建时间 </th>
						<th> 更新时间 </th>
						<th> 修改 </th>
					</tr>
				</thead>
				<tbody>
					<tr v-if="flag" v-for="serverInfo in listServerInfo" :key="serverInfo.id">
						<td> {{serverInfo.port}} </td>
						<td> {{serverInfo.name}} </td>
						<td> {{serverInfo.purpose}} </td>
						<td> {{serverInfo.conf}} </td>
						<td> {{serverInfo.author}} </td>
						<td> {{serverInfo.status}} </td>
						<td> {{serverInfo.createTime}} </td>
						<td> {{serverInfo.updateTime}} </td>
						
						<td> <a href="#" class="btn-link">编辑</a> </td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--  默认紧靠右侧自适应（可指定列宽：class="col-lg-4 pull-right"） -->
		<div class="pull-right">
	      <ul id="page" class="pagination"></ul>
	    </div>
		
		
		<!-- 新增遮罩层 -->
		<div class="modal fade" id="modal-container-509177" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">
							新增服务
						</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal serverInfoForm">
				            <div class="row form-group">
				                <label class="control-label col-lg-4" for="name">端口</label>
				                <div class="col-lg-8 col-md-6">
				                    <input class="form-control" v-model="server_port" name="port" id="port" type="number" placeholder="80" min="0" max="65535">
				                </div>
				            </div>
				            <div class="row form-group">
				                <label class="control-label col-lg-4" for="name">服务名</label>
				                <div class="col-lg-8 col-md-6">
				                    <input class="form-control" v-model="server_name" name="name" id="name" type="text" placeholder="nginx" >
				                </div>
				            </div>
				            <div class="row form-group">
				                <label class="control-label col-lg-4" for="name">服务作用与说明</label>
				                <div class="col-lg-8 col-md-6">
				                    <input class="form-control" v-model="server_purpose" name="purpose" id="purpose" type="text" placeholder="web服务器" >
				                </div>
				            </div>
				            <div class="row form-group">
				                <label class="control-label col-lg-4" for="name">核心数据或配置文件目录</label>
				                <div class="col-lg-8 col-md-6">
				                    <input class="form-control" v-model="server_conf" name="conf" id="conf" type="text" placeholder="/usr/local/nginx" >
				                </div>
				            </div>
				            <div class="row form-group">
				                <label class="control-label col-lg-4" for="name">维护者</label>
				                <div class="col-lg-8 col-md-6">
				                    <input class="form-control" v-model="server_author" name="author" id="author" type="text" placeholder="张三" >
				                </div>
				            </div>
						</form>
					</div>
					<div class="modal-footer">
						 <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> 
						 <button type="button" class="btn btn-primary" data-dismiss="modal" @click="addServer()">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>


</body>
</html>
	
<script type="text/javascript">
	var vm = new Vue({
		el: '#app',
		data: {
			flag: false,
			default_key: '114',
			default_text: '查询数据为空 o(╥﹏╥)o',
			kw_key: '',
			kw_key_color: '',
			listServerInfo: [],
			
			server_port: '',
			server_name: '',
			server_purpose: '',
			server_conf: '',
			server_author: '',
			
		},
		/* 页面加载完, (1)查询列表; (2)结果分页；(3)分页查询列表 */
		mounted(){
			this.searchList(1, 10);
		},
		methods: {
			/* 0、分页 */
			page(totalCounts, pageSize, currentPage){
				$("#page").jqPaginator({
		        	totalCounts: totalCounts,	//总条数
		        	pageSize: pageSize,			//每页显示条数
		        	currentPage: currentPage,	//当前页
		        	first: '<li class="first"><a href="javascript:void(0);">首页<\/a><\/li>',
		        	prev: '<li class="prev"><a href="javascript:void(0);">上一页<\/a><\/li>',
		        	next: '<li class="next"><a href="javascript:void(0);">下一页<\/a><\/li>',
		        	last: '<li class="last"><a href="javascript:void(0);">末页<\/a><\/li>',
		        	page: '<li class="page"><a href="javascript:void(0);">{{page}}<\/a><\/li>',
		        	onPageChange: function(current, type) {
		            	if (type == 'change') {
		            		vm.searchList(current, pageSize);
		            	}
		        	}
		      	})
			},
			
			/* 1、默认查询列表 */
			searchList(pageNum, pageSize){
				this.default_text = "数据加载中，请稍候...";
				var requestUrl = "${url}" + "/serverInfo?pageNum=" + pageNum + "&pageSize=" + pageSize;
				console.log("--1.searchList--requestUrl=" + requestUrl);
				var _this = this;
				/* jquery方式 */
				$.ajax({
					type: "GET",
					url: requestUrl,
					success : function (obj) {
						_this.flag = true;
						_this.default_text = "";
						_this.kw_key_color = "";
						if(200 == obj.code){
							var listServerInfo = obj.data.list;
							var totalCounts = obj.data.total;
							_this.listServerInfo = listServerInfo;
							console.log("--searchList--result-totalCounts=" + totalCounts);
							if(0 == totalCounts){
								_this.default_text = "查询结果为空";
							}else {
								vm.page(totalCounts, pageSize, pageNum);
							}
						}else {
							_this.default_text = "未查询到结果，请尝试其它关键字";
						}
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						_this.flag = false;
						_this.default_text = "服务异常，未查询到结果，请刷新或稍后重试";
						_this.kw_key_color = '';
						_this.kw_key = '';
						console.log(JSON.stringify(errorThrown)+JSON.stringify(textStatus)+JSON.stringify(XMLHttpRequest));
					}
				});
			},
			
			/* 2、关键词查询列表 */
			searchKeyword(pageNum, pageSize){
				if(!this.kw_key){
					vm.searchList(pageNum, pageSize);
				}else {
					this.default_text = "数据查询中，请稍候...";
					var requestUrl = "${url}" + "/serverInfo/keyword?keyword=" + this.kw_key + "&pageNum=" + pageNum + "&pageSize=" + pageSize;
					console.log("--2.searchKeyword--requestUrl=" + requestUrl);
					var _this = this;
					this.listServerInfo = [];
					$.ajax({
						type: "GET",
						url: requestUrl,
						success : function (obj) {
							_this.flag = true;
							_this.kw_key_color = "关键字："+_this.kw_key;
							_this.kw_key = '';
							_this.default_text = '';
							if(200 == obj.code){
								var listServerInfo = obj.data.list;
								var totalCounts = obj.data.total;
								_this.listServerInfo = listServerInfo;
								console.log("--searchList--result-totalCounts=" + totalCounts);
								if(0 == totalCounts){
									_this.default_text = "查询结果为空";
								}else {
									vm.page(totalCounts, pageSize, pageNum);
								}
							}else {
								_this.default_text = "未查询到结果，请尝试其它关键字";
							}
						},
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							_this.flag = false;
							_this.default_text = "服务异常，未查询到结果，请刷新或稍后重试";
							_this.kw_key_color = '';
							_this.kw_key = '';
							console.log(JSON.stringify(errorThrown)+JSON.stringify(textStatus)+JSON.stringify(XMLHttpRequest));
						}
					});
				}
			},
			
			/* 3、新增服务 */
			addServer(){
				this.default_text = "新增服务，数据存储中...";
				var requestUrl = "${url}" + "/serverInfo/add";
				console.log("--3.addServer--requestUrl=" + requestUrl);
				var config = {
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				}
				var formDataJson = vm.transformToJson("serverInfoForm");
				var _this = this;
				axios.post(requestUrl, formDataJson, config).then(
					function(response) {
						if(response && response.data && response.data.code==200){
							console.log(response.data.message);
							/* 列表查询 */
							vm.searchList(1, 10);
						}
					}).catch(
			            function(error) {
			            	alert("网络请求出错");
			            	console.error(error.stack);
			        });
			},
			
			/* 附：表单转为json数据格式(formClassName = form表单class属性值) */
		    transformToJson(formClassName){
		    	var formDataJsonArray = $("." + formClassName).serializeArray();
		        var obj={}
		        for (var data in formDataJsonArray) {
		            obj[formDataJsonArray[data].name] = formDataJsonArray[data]['value'];
		        }
		        var jsonObj = JSON.stringify(obj)
		        return jsonObj;
		    },
			
			/* 4、编辑/修改服务  */	  
			updateServer(){
				
			},
			
		},
		
	});
    
      
</script>