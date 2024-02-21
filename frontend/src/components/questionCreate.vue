<template>
    <div class="allQuestion">
        <div class="question">
            <p class="index">{{ this.index + 1 }}</p>
            <textarea class="questionArea" placeholder="Введите вопрос" :rows="this.rows" v-model="question.text" @input="adjustTextareaHeight" ref="textarea"></textarea>
            <div class="deleteButton" @click="deleteQuestion"></div>
        </div>
        <div class="answers">
            <answerContent v-for="(answer, index) in question.answers" :key="index" :answer="answer" :index="index" @deleteAnswer="()=>deleteAnswer(answer.answervariant_id, index)"></answerContent>
            <button class="addAnswerButton" @click="addAnswer">+ Добавить ответ </button>
        </div>
        <input class="rightAnswer" placeholder="Введите ответ" v-model="question.rightAnswer"/>
        <div style="margin-top: 1%; margin-left: 2%">
            <p class="infoP" style="display: inline-block;">Количество баллов:</p>
            <input class="rightAnswer" style="display: inline-block; width: 56%;" v-model="this.question.score"/>
        </div>
    </div>
</template>

<script>
    import answerContent from './answerCreate.vue'
    
    export default {
        data(){
            return{
                rows: 1
            }
        },
        props: {
            index: Number,
            question: {},
            deleted: Array
        },
        methods: {
            addAnswer(){
                this.question.answers.push({text: '', answervariant_id: '-1'}); 
            },
            deleteAnswer(id ,index){
                this.question.answers.splice(index, 1);
                try{
                    if (id){
                        this.deleted.push(id);
                    }
                    else{
                        this.deleted.push('-1');
                    }
                }
                catch(e){
                    
                }
            },
            deleteQuestion(){
                this.$emit('deleteQuestion', this.index);
            },
            adjustTextareaHeight() {
                const textarea = this.$refs.textarea;
                if (textarea) {
                    if (textarea.scrollHeight > textarea.clientHeight) {
                        this.rows += 1;
                    }
                }
            }
            
        },
        components:{
            answerContent
        }
    }
</script>

<style scoped>
    .allQuestion{
        align-items: center;
    }
    .question{
        margin-top: 2%;
        display: flex;
    }
    .questionArea{
        margin-left: 1%;
        width:85%;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 20px;
        font-family: 'Roboto', sans-serif;
        font-size: 25px;
        color:#4B413A;
        display: inline-block;
        box-sizing: border-box;
        resize: none;
        padding: 5px 5px 5px 5px;
        overflow:visible;
    }
    .index{
        display: inline-block;
        font-family: 'Roboto', sans-serif;
        font-size: 35px;
        color:#4B413A;
    }
    .deleteButton{
        margin-left: 1%;
        background-image: url(../assets/delete.png);
        background-size: cover;
        height: 40px;
        width: 40px;
        display: inline-block;
        cursor: pointer;
    }
    .answers{
        margin-left: 5%;
    }
    .addAnswerButton{
        width:clamp(250px, 30%, 500px);
        height: clamp(40px, 10%, 60px);
        margin: auto auto 10px auto;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 50px;
        text-align: center;
        font-size: 20px;
        color: #4B413A;
        line-height: 100%;
        cursor: pointer;
        margin-top: 1%;
        padding: 3px 3px 3px 3px;
    }
    .rightAnswer{
        margin-left: 1%;
        width:96%;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 20px;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color:#4B413A;
        resize: none;
        padding: 5px 5px 5px 5px;
        overflow:visible;
    }
    .infoP{
        font-family: 'Roboto', sans-serif;
        font-size: 25px;
        color: #4B413A;
        width: 40%
    }
</style>