<html>
	<#include "./common/head.ftl">
<body>
	<div id="app">
		<div class="page-header">
			<h3 class="text-center"> DEMO示例 </h3>
		</div>
	
		<div class="panel panel-info">
			<div class="panel-heading form-inline">
				<label style="width:200px">
					地址新增
				</label>
				<input type="text" class="form-control" v-model="address" placeholder="如：广州海珠区阅江西路222号">
				&nbsp; <input type="button" value="添加" class="btn btn-primary" @click="add()">
			</div>
			<div class="panel-footer form-inline">
				<label style="width:200px">
					地址查询
				</label>
				<input type="text" class="form-control" v-model="keywords" placeholder="如：222号">
			</div>
		</div>
		
		<div class="panel panel-primary">
			<table class="table table-bordered table-hover table-striped">
				<thead>
					<tr>
						<th>id</th>
						<th>address</th>
						<th>Ctime</th>
						<th>Operation</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item in search(keywords)" :key="item.id">
						<td>{{ item.id }}</td>
						<td v-text="item.address"></td>
						<td>{{ item.ctime }}</td>
						<td>
							<a href="" @click.prevent="del(item.id)">删除</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
			
	<script>
		var vm = new Vue({
			el: '#app',
			data: {
				id: 0,
				address: '',
				keywords: '',
				list: [
					{id:1, address:'广州黄埔区科学城总部经济区A2栋8楼', ctime: new Date()},
					{id:2, address:'广州海珠区阅江西路222号', ctime: new Date()},
				]
			},
			methods: {
				add(){
					var poi = {id: this.list.length!=0?(this.list[this.list.length - 1].id+1):1, address: this.address!=''?this.address:'中国(默认)', ctime: new Date()}
					this.list.push(poi)
					this.address = ''
				},
				del(id){
					var index = this.list.findIndex(item => {
						if(item.id == id){
							return true;
						}
					})
					this.list.splice(index, 1)
				},
				search(keywords){
					return this.list.filter(item => {
						if(item.address.includes(keywords)){
							return item
						}
					})
				}
			}
		});
		
	</script>
</body>
</html>