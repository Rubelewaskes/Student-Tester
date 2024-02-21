<template>
    <div class="resultContainer">
        <p class="pageName">Результаты теста {{ this.testName }}</p>
        <DataTable :value="results" paginator :rows="20" scrollable tableStyle="min-width: 50rem">
            <Column sortable v-for="col of columns" :key="col.field" :field="col.field" :header="col.header"></Column>
        </DataTable>
    </div>
</template>

<script>
    import { Bar } from 'vue-chartjs'
    import {getColumns} from '../../api/results'
    import {getTableResults} from '../../api/results'
    import {getTestName} from '../../api/tests'

    export default {
        name: 'BarChart',
        components: { Bar },
        data(){
            return{
                test_id: this.$route.query.test_id,
                results: [],
                columns:[],
                testName: ''
            };
        },
        async beforeMount(){
            try{
                this.columns = await getColumns({test_id: this.test_id});
                this.results = await getTableResults({test_id: this.test_id});
                this.testName = await getTestName({test_id: this.test_id, login: localStorage.getItem('login')});
            }
            catch(e){
                console.log(e)
            }
        }
    }
</script>

<style>
    .resultContainer{
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