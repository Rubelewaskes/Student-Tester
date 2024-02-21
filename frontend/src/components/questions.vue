<template>
    <div class="question">
        <p class="questionContent">№{{ index + 1 }} {{ this.question.question_content }}</p>
        <answers class="present" v-for="(answer, index) in question.answers" :answer="answer" :index="index"></answers>
        <input class="answerInput" v-model="question.userAnswer"/>
    </div>
</template>

<script>
    import answers from './answer.vue'

     export default {
        props: {
            question: {},
            index: Number
        },
        components: {
            answers
        },
        data() {
            return {
                userAnswer: ''
            };
        },
    }
</script>

<style scoped>
    .question{
        margin-left: 1%;
        padding: 1% 1% 1% 1%;
        margin-top: 2%;
    }
    .questionContent{
        margin-top:1%;
        margin-bottom:1%;
    }
    .answerInput{
        margin-top:1%;
        width:98%;
        background-color: #F5F3F1;
        border: 5px solid #4B413A;
        border-radius: 20px;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color:#4B413A;
        
    }
</style>