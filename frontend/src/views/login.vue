<template>
  <div class="loginContainer">
    <div class="loginForm">
      <div class="login">
        <p>Логин</p>
        <input type="text" v-model="userInfo.login">
      </div>
      <div class="password">
        <p>Пароль</p>
        <input type="password" v-model="userInfo.password">
      </div>
      <button class="button" id="loginButton" @click="login">Войти</button>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </div>
  </div>
</template>

<script>
  import { toLogin } from '../../api/login'


  export default {
    name: 'login',
    data () {
      return {
        userInfo: {
          login: '',
          password: ''
        },
        errorMessage: ''
      }
    },
    methods: {
      async login () {
        try {
          await toLogin(this.userInfo)
          this.errorMessage = ''
        } catch (e) {
          console.log(e)
          this.errorMessage = 'Ошибка. Данные введены некорректно.'
        }
      }
    }
  }
</script>

<style scoped>
.loginContainer{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #50735E;
  width: 36.4vw;
  height: 39vw;
  border: 6px solid #4B413A;
  border-radius: 100px;
}

.loginForm{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 85%;
  height: 85%;
  background-color: #CFC9C3;
  border: 6px solid #4B413A;
  border-radius: 50px;
  text-align: center;
  font-family: 'Roboto', sans-serif;
  font-size: 55px;
  color: #4B413A;
}

button{
  width:clamp(290px, 50%, 350px);
  height: clamp(60px, 10%, 70px);
  margin: auto auto 10px auto;
  background-color: #F8F1EA;
  border: 6px solid #4B413A;
  border-radius: 50px;
  text-align: center;
  font-family: 'Roboto', sans-serif;
  font-size: 55px;
  color: #4B413A;
  line-height: 100%;
  cursor: pointer;
}

.error-message {
  color: rgb(149, 38, 38);
  font-size: 30px;
  margin-top: 10px;
}

.login{
  margin-top: 10%;
}

.password{
  margin-top: 10%;
  margin-bottom: 15%;
}


input{
  width:80%;
  height: 50%;
  background-color: #F8F1EA;
  border: 5px solid #4B413A;
  border-radius: 20px;
  font-family: 'Roboto', sans-serif;
  font-size: 40px;
  color:#4B413A;
}

p{
  margin-block-start: 0px;
  margin-block-end: 0px;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
  cursor: default;
}
</style>