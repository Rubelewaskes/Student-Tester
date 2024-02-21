<template>
    <div class="testInfo">
        <div :class="testItem">
            <p class="testName">{{ test.test_name }}</p>
            <div class="testGrid">
                <p class="description">{{ test.fio_teacher }}</p>
                <p class="score">{{ test.minimum_score }}</p>
                <p class="description">Дисциплина: {{ test.discipline }}</p>
                <p class="description" style="font-size: 18px;">{{ test.end_time }}</p>
            </div>
        </div>
        <div class="buttons">
            <div class="button" @click="goResults">
                Результаты
            </div>
            <div class="button" @click="goEdit">
                Редактировать
            </div>
        </div>
    </div>
</template>

<script>
import router from '../router';

export default {
  props: {
    test: {},
    testItem: String
  },
  methods: {
    goEdit(){
        router.push({ path: '/mainpage/admin/testedit', query: { test_id: this.test.test_id } });
    },
    goResults(){
        router.push({ path: '/mainpage/admin/testresults', query: { test_id: this.test.test_id } });
    }
  }
};
</script>

<style scoped>
    .testItem{
        width: 100%;
        margin-top: 3%;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #4B413A;
        padding: 3% 3% 3% 3%;
        border-radius: 45px;
        border: 4px solid #4B413A;
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
    .buttons{
        display: grid;
        width: 100%;
        grid-template-columns: 50% 50%;
        justify-content: center;
        align-items: center;
        margin-top: 0.5%
    }
    .button{
        width:90%;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #4B413A;
        margin: auto auto 1% auto;
        background-color: #F5F3F1;
        border: 3px solid #4B413A;
        border-radius: 50px;
        font-size: 35px;
        color: #4B413A;
        line-height: 100%;
        cursor: pointer;
        padding: 3px 3px 3px 3px;
        text-align: center;
        border: 3px solid #4B413A;
    }

    .present{
        background-color: rgba(80, 115, 94, 0.3);
    }
    .past{
        background-color: rgba(191, 109, 96, 0.3);
    }
</style>