import '../css/app.css';
import { createApp } from 'vue';
import TrainingLogin from './components/TrainingLogin.vue';

const appRoot = document.getElementById('training-auth-app');

if (appRoot) {
    createApp(TrainingLogin, {
        appName: appRoot.dataset.appName,
        labName: appRoot.dataset.labName,
    }).mount(appRoot);
}
