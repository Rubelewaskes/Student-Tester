import { TestTeacher } from './URLS';
import { TestStudent } from './URLS';
import { TestAdmin } from './URLS';
import { GetTest } from './URLS';
import { GetFullTest } from './URLS';
import { GetNameTest } from './URLS';
import { PostAnswers } from './URLS';
import { PostTest } from './URLS'
import { DeleteTest } from './URLS'
import { UpdateTest } from './URLS'
import { sendRequest } from '.';

export async function getTests(data) {
    try {
        const role = data.role;
        if (role == 'student'){
            const res = await sendRequest('get', TestStudent, data);
            return res.data;
        }
        else if (role == 'teacher'){
            const res = await sendRequest('get', TestTeacher, data);
            return res.data;
        }
        else if (role == 'admin'){
            const res = await sendRequest('get', TestAdmin, data);
            return res.data;
        }
    } catch (e) {
        return e.response;
    }
}

export async function getTestInfo(data) {
    try {
        const res = await sendRequest('get', GetTest, data);
        return res.data;
    } catch (e) {
        return e.response;
    }
}

export async function getFullTestInfo(data){
    try {
        const res = await sendRequest('get', GetFullTest, data);
        return res.data;
    } catch (e) {
        return e.response;
    }
}

export async function getTestName(data) {
    try {
        const res = await sendRequest('get', GetNameTest, data);
        return res.data;
    } catch (e) {
        return e.response;
    }
}

export async function postAnswers(data) {
    try {
        const res = await sendRequest('post', PostAnswers, data);
        return res.data;
    } catch (e) {
        return e.response;
    }
  }

export async function postTest(data) {
    try {
        const res = await sendRequest('post', PostTest, data);
        return res.data;
        
    } catch (e) {
        return e.response;
    }
}

export async function updateTest(data) {
    try {
        const res = await sendRequest('post', UpdateTest, data);
        return res.data;
        
    } catch (e) {
        return e.response;
    }
}

export async function deleteTest(data) {
    try {
        const res = await sendRequest('post', DeleteTest, data);
        return res.data;
        
    } catch (e) {
        return e.response;
    }
}

  export default {};