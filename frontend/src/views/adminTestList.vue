<template>
    <div class="testsContainer">
        <p class="pageName">Список тестов</p>
        <testContent v-for="test in tests.present" :key="test.test_id" :test="test" testItem="testItem present"></testContent>
        <testContent v-for="test in tests.past" :key="test.test_id" :test="test" testItem="testItem past"></testContent>
    </div>
</template>

<script>
import {getTests} from '../../api/tests'
import testContent from '../components/adminTestInfo.vue'

export default {
    data(){
        return{
            tests: {},
        };
    },
    async created () {
        try {
            const forTestsInfo = {role: localStorage.getItem('role_sys'), login: localStorage.getItem('login') };
            this.tests = await getTests(forTestsInfo);
        } catch (e) {
            console.log(e)
        }
    },
    components:{
        testContent
    }
}
</script>

<style scoped>
    .testsContainer{
        height: 100%;
        width: 80%;
        margin-left: 10%;
        overflow: auto;
    }

    .pageName{
        padding-top:2%;
        cursor: default;
        font-family: 'Roboto', sans-serif;
        font-size: 45px;
        color: #4B413A;
    }
    
</style>