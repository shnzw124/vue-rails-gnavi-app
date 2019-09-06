<template>
  <div>
    <div v-if="errors.length" class="error-box">
      <ul>
        <li v-for="error in errors" class="errors-list">{{ error }}</li>
      </ul>
    </div>
    <div class="row justify-content-center search-box">
      <div class="col-offset-2 col-sm-8 col-offset-2">
        <form @submit.prevent="exec">
          <div class="input-group">
            <input v-model="area" class="form-control text-center" placeholder="場所は？？">
            <span class="de-style food-form">で</span>
            <input v-model="food" class="form-control text-center food-form" placeholder="何が食べたい？？">
            <span class="input-group-addon btn"><button type="submit">検索</button></span>
          </div>
        </form>
      </div>
    </div>
    <div class="row justify-content-center">
        <div v-for="shop in shops" v-if="shops" v-bind:id="'row_shop_' + shop.id">
            <div class="shop-list">
              <a :href="shop.url" target="_blank">
                {{shop.name}}
                <img :src="shop.image_url.shop_image1">
              </a>
            </div>
        </div>
    </div>
  </div>
</template>


<script>
  let alert = document.getElementsByClassName("errors-list"); 
  let alert_box = document.getElementsByClassName("error-box");

  import axios from 'axios';
  export default{
    data: function(){
      return{
        errors: [],
        shops: [],
        area:  "",
        food:  ""
      }
    },
    methods: {
      exec: function(){
        this.errors.length = 0;
        if(!this.area){
          this.errors.push("エリアを入力してください");
        }
        if(!this.food){
          this.errors.push("食べたいものを入力してください");
        }
        if(this.errors.length){
          for(let i = 0; i < alert.length; i++){
            alert[i].style.display="block";
          }
          setTimeout(function(){
             for(let i = 0; i < alert.length; i++){
                alert[i].style.display="none";
              }
          },3000);
          return;
        }

        axios.get('/api/v1/searches',{
          params: {
            area: this.area,
            food: this.food
          },
        })
        .then((response) => {
          this.shops.length = 0;
          if(!response.data.length){
            for(let i = 0; i < alert.length; i++){
              alert[i].style.display="block";
            }
            this.errors.push("指定された条件の店舗が存在しません");
            setTimeout(function(){
              for(let i = 0; i < alert.length; i++){
                alert[i].style.display="none";
                }
            },3000);
          }
          for(let i = 0; i < response.data.length; i++) {
            this.shops.push(response.data[i]);
          }
         }, (error) => {
           console.log(error);
         });
      }
    }
  };
</script>

<style scoped>
.search-box{
  margin-top:70px;
}

.shop-list{
  margin:15px;
}

.food-form{
  margin-left:10px !important; 
}

.de-style{
  font-size:25px;
}

.errors-list{
  list-style: none;
}

.error-box{
  position: absolute;
  top: 65px;
  left: 25%;
  color:red;
  font-size: 1.2rem;
}

.errors-list{
  animation : fadeOut 3s;
  animation-fill-mode: both;
}
@keyframes fadeOut {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}
</style>
