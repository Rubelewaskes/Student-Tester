import { sendRequest } from '.';
import { GetGroups } from './URLS'

export async function getGroups() {
    try {
        const res = await sendRequest('get', GetGroups);
        return res.data.groups;
    } catch (e) {
        return e.response;
    }
  }