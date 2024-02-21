<template>
    <div class="testItem" @click="goTest">
        <p class="testName">{{ test.test_name }}</p>
        <div class="testGrid">
            <p class="description">{{ test.fio_teacher }}</p>
            <p class="score">{{ test.minimum_score }}</p>
            <p class="description">Дисциплина: {{ test.discipline }}</p>
            <p class="description" style="font-size: 18px;">{{ test.end_time }}</p>
        </div>
    </div>
</template>

<script>
import router from '../router';
import {findAnswers} from '../../api/results'

export default {
  props: {
    test: {},
    time: String
  },
  methods: {
    async goTest(){
        if (localStorage.getItem('role_sys') == "student"){
            await findAnswers({ test_id: this.test.test_id, token: localStorage.getItem('token'), time: this.time});
        }
        else if (localStorage.getItem('role_sys') == "teacher"){
            router.push({ path: '/mainpage/teacher/testresults', query: { test_id: this.test.test_id } });
        }
    }
  }
};
</script>

<style scoped>
    .testItem{
        width: 92%;
        margin-top: 3%;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #4B413A;
        padding: 3% 3% 3% 3%;
        border-radius: 45px;
        cursor: pointer;
        border: 5px solid rgb(238, 225, 216);
    }
    .testItem:hover{
        border: 5px solid;
    }
    .testName{
        font-size: 27px;
    }
    .testGrid{
        display: grid;
        grid-template-columns: 80% 20%;
    }
    .description{
        margin-top: 1%;
    }
    .score{
        height: 25px;
        width: 25px;
        background-color: rgba(256, 256, 256, 0.3);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }
</style>