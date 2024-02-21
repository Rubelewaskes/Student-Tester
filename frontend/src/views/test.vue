<template>
    <div class="testContainer">
        <p class="testName">{{ testName }}</p>
        <questionsContent v-for="(question, index) in questions.questions" :key="question.question_id" :question="question" :index="index"></questionsContent>
        <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
        <div class="button">
            <button id="loginButton" @click="answers">Отправить</button>
        </div>
    </div>
</template>

<script>
    import {getTestInfo} from '../../api/tests'
    import {getTestName} from '../../api/tests'
    import {postAnswers} from '../../api/tests'
    import questionsContent from '../components/questions.vue'
    import router from '../router/index.js'
    
    export default {
        data(){
            return{
                test_id: this.$route.query.test_id,
                questions: {},
                testName: '',
                errorMessage: ''
            };
        },
        async created () {
            try {
                this.testName = await getTestName({test_id: this.test_id, login: localStorage.getItem('login')});
                this.questions = await getTestInfo({test_id: this.test_id, login: localStorage.getItem('login')});
            } catch (e) {
                console.log(e);
            }
        },
        components:{
            questionsContent
        },
        methods: {
            async answers(){
                try{
                    const data = this.questions.questions.map(question => ({
                        question_id: question.question_id,
                        user_id: localStorage.getItem('token'),
                        login: localStorage.getItem('login'),
                        answer: question.userAnswer || ''
                    }));

                    const result = await postAnswers(data);
                    if (result.exit === "success") {
                        router.push('/mainpage/student/testlist');
                    }
                    else{
                        this.errorMessage = result.exit;
                    }
                } catch (e){
                    console.log(e);
                }
            }
        }
    }
</script>

<style scoped>
    .testContainer{
        height: 100%;
        width: 80%;
        margin-left: 10%;
        overflow: auto;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #4B413A;
    }

    .error-message {
        color: rgb(149, 38, 38);
        font-size: 30px;
        margin-top: 10px;
        text-align: center;
    }
    .testName{
        font-size: 30px;
        padding-top: 5%;
    }

    button{
        width:clamp(400px, 50%, 800px);
        height: clamp(40px, 10%, 60px);
        margin: auto auto 10px auto;
        background-color: #F5F3F1;
        border: 5px solid #4B413A;
        border-radius: 50px;
        text-align: center;
        font-size: 35px;
        color: #4B413A;
        line-height: 100%;
        cursor: pointer;
        margin-top: 1%;
        padding: 3px 3px 3px 3px;
    }

    .button{
        text-align: center;
    }
</style>