<template>
    <div class="allContainer">
        <div class="testContainer"> 
            <p class="pageName">Создание теста</p>
            <p class="pageName" style="color: rgb(149, 38, 38); font-size: 25px">{{ errorMessage }}</p>
            <div class="block">
                <p>Название:</p>
                <input class="infoInput" style="width: 98%" v-model="this.testData.name"/>
                <div class="grid">
                    <div>
                        <p>Дата начала:</p>
                        <input type="datetime-local" class="infoDate" v-model="this.testData.start_date">
                    </div>
                    <div>
                        <p>Дата окончания:</p>
                        <input type="datetime-local" class="infoDate" v-model="this.testData.end_date">
                    </div>
                    <div>
                        <p>Минимальный балл:</p>
                        <input class="infoInput" v-model="this.testData.minimum_score"/>
                    </div>
                    <div>
                        <p>Дисциплина:</p>
                        <input class="infoInput" v-model="this.testData.discipline"/>
                    </div>
                </div>
            </div>
            <div class="block">
                <questionContent v-for="(question, index) in questions" :key="index" :question="question" :index="index" @deleteQuestion="deleteQuestion"></questionContent>
            </div>
            <div class="button">
                <button class="addQuestionButton" @click="addQuestion">+ Добавить вопрос</button>
            </div>
            <div class="block">
                <p>Список групп:</p>
                <div class="selectedGroups">
                    <div class="oneGroup" style="display:flex; margin-top: 0.3%" v-for="group in selectedGroups" :key="group.id" :value="group.name">
                        <p style="font-size: 20px;">{{ group.name }}</p> 
                        <div class="deleteButton" @click="()=>deleteGroup(group.group_id)"></div>
                    </div>
                </div>
                <input
                    class="infoInput"
                    list="groups"
                    style="width: 98%; margin-top: 0.5%"
                    v-model="searchText"                        
                    placeholder="Введите первые символы группы"
                    @change="handleInput"
                    />
                <datalist id="groups">
                    <option v-for="group in groups" :key="group.group_id" :value="group.name">
                    </option>
                </datalist>
            </div>
        </div>
        <div class="buttonTest">
                <button class="createTestButton" @click="createTest">Создать тест</button>
        </div>
    </div>
</template>

<script>
    import questionContent from '../components/questionCreate.vue'
    import {postTest} from '../../api/tests.js'
    import {getGroups} from '../../api/groups.js'
    import router from '../router/index.js'

    export default {
        data(){
            return{
                errorMessage: '',
                questions: [{text: '', rightAnswer: '', answers: [], score: ''}],
                testData: {
                    name: '',
                    start_date: '',
                    end_date: '',
                    minimum_score: '',
                    discipline: ''
                },
                searchText: '',
                selectedGroups:[],
                groups: []
            };
        },
        async created(){
            try{
                this.groups = await getGroups();
            }
            catch (e){
                console.log(e);
            }
        },
        methods:{
            addQuestion(){
                this.questions.push({text: '', rightAnswer: '', answers: [], score: ''}); 
            },
            deleteQuestion(index){
                this.questions.splice(index, 1);
            },
            deleteGroup(index){
                this.selectedGroups = this.selectedGroups.filter(group => group.group_id !== index);
            },
            handleInput(){
                const selectedGroup = this.groups.find(group => group.name.toString() == this.searchText);
                if (selectedGroup && !this.selectedGroups.find(group => group.group_id == selectedGroup.group_id)) {
                    this.selectedGroups.push(selectedGroup);
                }

            },
            async createTest(){
                try{
                    if (this.testData.name.length < 1){
                        this.errorMessage = 'Название теста не указано';
                        return;
                    }
                    if (this.testData.end_date.length < 1){
                        this.errorMessage = 'Дата окончания теста не указана';
                        return;
                    }
                    if (isNaN(this.testData.minimum_score)){
                        this.errorMessage = 'Неверно указан минимальный балл за тест';
                        return;
                    }
                    if (this.questions.length < 1){
                        this.errorMessage = 'Не указаны вопросы';
                        return;
                    }
                    let sum = 0;
                    for (let i = 0; i < this.questions.length; i++) {
                        if (isNaN(this.questions[i].score)){
                            this.errorMessage = 'Неверно указан балл за вопрос';
                            return;
                        }
                        if (this.questions[i].rightAnswer.length < 1){
                            this.errorMessage = 'Не указан ответ на вопрос';
                            return;
                        }
                        sum += parseInt(this.questions[i].score);
                    }
                    if (sum < parseInt(this.testData.minimum_score)){
                        this.errorMessage = 'Минимальный балл слишком высок';
                        return;
                    }
                    if(this.selectedGroups.length < 1){
                        this.errorMessage = 'Группы не добавлены';
                        return;
                    }
                    if(new Date(this.testData.end_date) < new Date(this.testData.start_date)){
                        this.errorMessage = 'Неверно указано время теста';
                        return;
                    }

                    
                    
                    const data = { name: this.testData.name, discipline: this.testData.discipline,
                        start_date: this.testData.start_date, end_date: this.testData.end_date, 
                        minimum_score: this.testData.minimum_score, teacher_id: localStorage.getItem('token'), 
                        login: localStorage.getItem('login'),
                        groups: this.selectedGroups.map(group => ({
                            group_id: group.group_id
                        })),
                        questions: this.questions.map(question => ({
                        answers: question.answers || '',
                        question: question.text || '',
                        rightAnswer: question.rightAnswer || '',
                        score: question.score || 0
                        }))
                    };
                    
                    const testCreate = await postTest(data)

                    if (testCreate.exit === "success") {
                        router.push('/mainpage/teacher/testlist');
                    }

                    else{
                        this.errorMessage = testCreate.exit;
                    }
                }
                catch (e){
                        console.log(e);
                }
            }
        },
        components:{
            questionContent
        }
    }
</script>

<style scoped>
    .deleteButton{
        margin-left: 1%;
        background-image: url(../assets/delete.png);
        background-size: cover;
        height: 20px;
        width: 20px;
        display: inline-block;
        cursor: pointer;
    }
    .allContainer{
        height: 87%;
        width: 100%;
        overflow-y: auto;
    }
    .testContainer{
        height: 90%;
        width: 80%;
        margin-left: 10%;
        position: relative;
    }
    .pageName{
        padding-top:2%;
        cursor: default;
        font-family: 'Roboto', sans-serif;
        font-size: 45px;
        color: #4B413A;
    }
    .block{
        font-family: 'Roboto', sans-serif;
        font-size: 25px;
        color: #4B413A;
        margin-bottom: 4%;
        background-color: #d5ccc2;
        border-radius: 25px;
        padding: 7px 7px 7px 7px;
    }
    .infoInput{
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
        color: #4B413A;
        width:90%;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 20px;
        resize: none;
        padding: 5px 5px 5px 5px;
    }
    .grid{
        display: grid;
        grid-template-columns: 50% 50%;
    }
    .infoDate{
        font-family: 'Roboto', sans-serif;
        font-size: 25px;
        color: #4B413A;
        background-color: #F5F3F1;
        border: 2px solid #4B413A;
        border-radius: 20px;
        resize: none;
        padding: 5px 5px 5px 5px;
    }
    .addQuestionButton{
        width:clamp(400px, 50%, 800px);
        height: clamp(40px, 10%, 60px);
        margin: auto auto 10px auto;
        background-color: #F5F3F1;
        border: 3px solid #4B413A;
        border-radius: 50px;
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
    .buttonTest{
        display: flex;
        align-items: center;
        width: 100%;
        height: clamp(40px, 10%, 60px);
        position: absolute;
        bottom: 0%;
    }
    .createTestButton{
        width:clamp(400px, 80%, 1500px);
        margin: auto auto 1% auto;
        background-color: #F5F3F1;
        border: 5px solid #4B413A;
        border-radius: 50px;
        font-size: 35px;
        color: #4B413A;
        line-height: 100%;
        cursor: pointer;
        padding: 3px 3px 3px 3px;
    }
</style>