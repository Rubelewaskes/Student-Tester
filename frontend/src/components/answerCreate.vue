<template>
    <div class="answer">
        <p class="index">{{ this.index + 1 }}</p>
        <textarea class="answerArea" placeholder="Введите ответ" :rows="this.rows" v-model="answer.text" @input="adjustTextareaHeight" ref="textarea"></textarea>
        <div class="deleteButton" @click="deleteAnswer"></div>
    </div>
</template>

<script>
    export default{
        data(){
            return{
                rows: 1
            }
        },
        props: {
            index: Number,
            answer: {}
        },
        methods:{
            adjustTextareaHeight() {
                const textarea = this.$refs.textarea;
                if (textarea) {
                    if (textarea.scrollHeight > textarea.clientHeight) {
                        this.rows += 1;
                    }
                }
            },

            deleteAnswer(){
                this.$emit('deleteAnswer');
            }
        }
    }
</script>

<style>
    .answer{
        margin-top: 1%;
        display: flex;
    }
    .index{
        display: inline-block;
        font-family: 'Roboto', sans-serif;
        font-size: 32px;
        color:#4B413A;
    }
    .answerArea{
        margin-left: 1%;
        width:85%;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 20px;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color:#4B413A;
        display: inline-block;
        box-sizing: border-box;
        resize: none;
        padding: 5px 5px 5px 5px;
        overflow:visible;
    }
    .deleteButton{
        margin-left: 1%;
        background-image: url(../assets/delete.png);
        background-size: cover;
        height: 30px;
        width: 30px;
        display: inline-block;
        cursor: pointer;
    }
</style>