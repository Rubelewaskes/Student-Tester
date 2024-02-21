import { Login } from './URLS';
import { sendRequest } from '.';
import router from '../src/router';

export async function toLogin(data) {
    try {
        const res = await sendRequest('post', Login, data);

        localStorage.setItem('login', res.data.login);
        localStorage.setItem('role', res.data.role);
        localStorage.setItem('token', res.data.token);
        localStorage.setItem('role_sys', res.data.role_sys);
        localStorage.setItem('first_name', res.data.first_name);
        localStorage.setItem('second_name', res.data.second_name);
        localStorage.setItem('third_name', res.data.third_name);

        if(res.data.role_sys == 'admin')
            router.push('/mainpage/admin/testlist');
        else if(res.data.role_sys == 'teacher')
            router.push('/mainpage/teacher/testlist');
        else if(res.data.role_sys == 'student'){
            localStorage.setItem('group_id', res.data.group_id);
            router.push('/mainpage/student/testlist');
        }

        return res.data;

    } catch (e) {
        return e.response.status;
    }
  }
  
  export default {};