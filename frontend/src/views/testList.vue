<template>
    <div class="testsContainer">
        <p class="pageName">Список тестов</p>
        <testContent class="present" v-for="test in tests.present" :time="'present'" :key="test.test_id" :test="test"></testContent>
        <testContent class="past" v-for="test in tests.past" :time="'past'" :key="test.test_id" :test="test"></testContent>
    </div>
</template>

<script>
import {getTests} from '../../api/tests'
import testContent from '../components/testInfo.vue'

export default {
    data(){
        return{
            tests: {},
            forTestsInfo: {
                role: localStorage.getItem('role_sys'),
                group_id: localStorage.getItem('group_id'),
                login: localStorage.getItem('login'),
                token: localStorage.getItem('token')
            }
        };
    },
    async created () {
        try {
            this.tests = await getTests(this.forTestsInfo);
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
    .present{
        background-color: rgba(80, 115, 94, 0.3);
    }
    .past{
        background-color: rgba(191, 109, 96, 0.3);
    }
</style>