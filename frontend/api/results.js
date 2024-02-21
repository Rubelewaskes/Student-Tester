import { GetColumns } from './URLS'
import { GetTableResults } from './URLS'
import { GetTableResultsStud } from './URLS'
import { FindAnswers} from './URLS'
import { sendRequest } from '.';
import router from '../src/router';

export async function getColumns(data) {
    try {
        const res = await sendRequest('get', GetColumns, data);
        return res.data.massive;
    } catch (e) {
        return e.response;
    }
}

export async function getTableResults(data) {
    try {
        const res = await sendRequest('get', GetTableResults, data);
        return res.data.massive;
    } catch (e) {
        return e.response;
    }
}

export async function getTableResultsStud(data) {
    try {
        const res = await sendRequest('get', GetTableResultsStud, data);
        return res.data.massive;
    } catch (e) {
        return e.response;
    }
}

export async function findAnswers(data) {
    try {
        const res = await sendRequest('get', FindAnswers, data);
        if (res.data.massive == 'true' || data.time == "past"){
            router.push({ path: '/mainpage/student/testresults', query: { test_id: data.test_id} });
        }
        else{
            router.push({ path: '/mainpage/student/test', query: { test_id: data.test_id } });
        };

        return;
    } catch (e) {
        return e.response;
    }
}