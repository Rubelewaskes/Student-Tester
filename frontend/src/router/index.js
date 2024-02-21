import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/login.vue'

import StudentHeader from '../components/headers/studentHeader.vue'
import TeacherHeader from '../components/headers/teacherHeader.vue'
import AdminHeader from '../components/headers/adminHeader.vue'

import StudentContent from '../components/contents/studentContent.vue'
import TeacherContent from '../components/contents/teacherContent.vue'
import AdminContent from '../components/contents/adminContent.vue'

import TestList from '../views/testList.vue'
import AdminTestList from '../views/adminTestList.vue'

import Test from '../views/test.vue'
import TestResults from '../views/testResults.vue'
import StudTestResults from '../views/testResultsStudent.vue'
import TestCreate from '../views/testCreate.vue'
import TestEdit from '../views/testEdit.vue'

const routes = [
  {
    path: '/',
    name: 'login',
    component: LoginView
  },
  {
    path: '/mainPage',
    name: 'mainPage',
    component: () => import('../views/mainPage.vue'),
    children:[
      {path:'student', components: { header: StudentHeader, content: StudentContent}, children:[
        {path: 'testlist', components: {testlist: TestList}},
        {path: 'testresults', components: {testresults: StudTestResults}, props: true},
        {path: 'test', components: {test: Test}, props: true}]
      },

      {path:'teacher', components: { header: TeacherHeader, content: TeacherContent}, children:[
        {path: 'testlist', components: {testlist: TestList}}, 
        {path: 'testresults', components: {testresults: TestResults}, props: true},
        {path:'testcreate', components: {testcreate: TestCreate}}]
      },

      {path:'admin', components: { header: AdminHeader, content: AdminContent}, children:[
        {path: 'testlist', components: {testlist: AdminTestList}},
        {path: 'testresults', components: {testresults: TestResults}, props: true},
        {path:'testedit', components: {testedit: TestEdit}, props: true}]
      }
    ]
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
