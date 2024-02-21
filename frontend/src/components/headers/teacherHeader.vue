<template>
    <header>
        <div class="logo" @click="goHome">
        </div>

        <div class="doField" >
            <div class="do"  @click="goTests">
                Результаты
            </div>
            <div class="do"  @click="goCreateTest">
                Создать тест
            </div>
        </div>

        <div class="exit" @click="logout"></div>
    </header>
</template>

<script>
  import router from '../../router';


  export default {
    name: 'header',
    methods: {
        async logout () {
            try {
                localStorage.clear();
                this.errorMessage = '';
                router.push('/');
            } catch (e) {
                console.log(e)
            }
        },
        async goTests() {
            router.push('/mainpage/teacher/testlist');
        },
        async goCreateTest() {
            router.push('/mainpage/teacher/testcreate');
        },
        async goHome() {
            router.push('/mainpage/teacher');
        },

    }
  }
</script>
<style scoped>
    header{
        background-color: #50735E;
        position: relative;
        top: 5vh;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 100vw;
        height: 10vh;
        border-bottom: 3px solid #4B413A;
        display: flex;
        justify-content: space-between;
        align-items: center;
        z-index: 1;
    }
    
    .logo{
        margin-left: 100px;
        margin-top: 0px;
        background-image: url(../../assets/logo.png);
        background-size: cover;
        height: 90px;
        width: 90px;
        display: inline-block;
        cursor: pointer;
    }

    .exit{
        margin-right: 100px;
        background-image: url(../../assets/exit.png);
        background-size: cover;
        object-fit: fill;
        height: 80px;
        width: 80px;
        display: inline-block;
        cursor: pointer;
    }

    .doField{
        height: 100%;
        width: 60%;
        display: flex;
        justify-content: center;
    }

    .do{
        padding-left: 1%;
        padding-right: 1%;
        display: inline-block;
        text-align: center;
        line-height: 10vh;
        font-family: 'Roboto', sans-serif;
        font-size: 35px;
        color: #2e2723;
        cursor: pointer;
        border: 2px solid rgba(238, 225, 216, 0);
        padding: 3px 3px 3px 3px;
    }
    .do:hover {
        border: 2px solid rgba(238, 225, 216, 0.5);
        background-color: #618b72;
    }
</style>