<script setup>
import { reactive, ref } from 'vue';

defineProps({
    appName: {
        type: String,
        default: 'Campus Computing Apps',
    },
});

const form = reactive({
    username: '',
    password: '',
    email: '',
    remember: false,
});

const showDebrief = ref(false);
const activePanel = ref('login');
const activeAudience = ref('lecture');

function showPanel(panel) {
    activePanel.value = panel;
}

function revealDebrief() {
    form.username = '';
    form.password = '';
    form.email = '';
    form.remember = false;
    showDebrief.value = true;

    requestAnimationFrame(() => {
        document.getElementById('debrief')?.scrollIntoView({
            behavior: 'smooth',
            block: 'nearest',
        });
    });
}
</script>

<template>
    <main class="am-signin-wrapper training-auth-shell" aria-label="FILKOM Apps login training simulation">
        <section class="am-signin-box">
            <div class="row no-gutters">
                <div class="col-lg-5">
                    <div>
                        <img
                            class="img-responsive img-responsive-center wd-200 mg-b-10"
                            src="https://filkom.ub.ac.id/legacy/assets/skin/apps/img/logo1.png"
                            :alt="`${appName} logo`"
                        >
                        <hr>
                        <p>
                            Lupa password? <br>
                            <button id="btn-reset-new" class="training-link training-link-light" type="button" @click="revealDebrief">
                                Klik di sini
                            </button>
                        </p>
                        <p>
                            Belum memiliki akun? <br>
                            <button id="btn-reg" class="training-link training-link-light" type="button" @click="showPanel('register')">
                                Daftar sekarang
                            </button>
                        </p>
                    </div>
                </div>

                <div class="col-lg-7">
                    <div v-show="activePanel === 'login'" class="login">
                        <form autocomplete="off" novalidate @submit.prevent="revealDebrief">
                            <h5 class="tx-gray-800 mg-b-25">Sign In to Your Account</h5>
                            <div class="form-group">
                                <label class="form-control-label" for="training-user">Username:</label>
                                <input
                                    id="training-user"
                                    v-model="form.username"
                                    type="text"
                                    name="training_user"
                                    class="form-control"
                                    placeholder="Enter your username"
                                    data-local-only="true"
                                >
                            </div>
                            <div class="form-group">
                                <label class="form-control-label" for="training-password">Password:</label>
                                <input
                                    id="training-password"
                                    v-model="form.password"
                                    type="password"
                                    name="training_password"
                                    class="form-control"
                                    placeholder="Enter your password"
                                    data-local-only="true"
                                >
                            </div>
                            <button type="submit" class="btn btn-block">Sign In</button>
                            <hr style="border-color:#ddd">
                            <div class="sign-in-info alert alert-primary" role="alert">
                                Untuk mengakses Sistem Informasi FILKOM Apps, pergunakan akun FILKOM Apps
                                <strong>BUKAN</strong> akun Gapura/SIAM/Siado.
                            </div>
                        </form>
                    </div>

                    <div v-show="activePanel === 'register'" class="register">
                        <form autocomplete="off" novalidate @submit.prevent="revealDebrief">
                            <h5 class="tx-gray-800 mg-b-25">Sign up your account</h5>
                            <div class="form-group">
                                <ul class="nav nav-pills flex-column flex-md-row" role="tablist">
                                    <li role="presentation" class="nav-item">
                                        <a
                                            href="#lecture"
                                            role="tab"
                                            class="nav-link"
                                            :class="{ active: activeAudience === 'lecture' }"
                                            @click.prevent="activeAudience = 'lecture'"
                                        >
                                            Dosen/Tendik
                                        </a>
                                    </li>
                                    <li role="presentation" class="nav-item">
                                        <a
                                            href="#student"
                                            role="tab"
                                            class="nav-link"
                                            :class="{ active: activeAudience === 'student' }"
                                            @click.prevent="activeAudience = 'student'"
                                        >
                                            Mahasiswa
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div v-show="activeAudience === 'lecture'" role="tabpanel" class="tab-pane active" id="lecture">
                                    <div class="form-group">
                                        <label class="sr-only" for="training-email">Email</label>
                                        <input
                                            id="training-email"
                                            v-model="form.email"
                                            type="email"
                                            name="training_email"
                                            class="form-control"
                                            placeholder="Email"
                                            data-local-only="true"
                                        >
                                    </div>
                                    <button class="btn btn-default btn-block" name="b_reg" type="submit">Register</button>
                                    <div class="form-group mg-t-10">
                                        Telah memiliki akun?
                                        <button class="training-link" type="button" @click="showPanel('login')">Sign in</button>
                                    </div>
                                </div>
                                <div v-show="activeAudience === 'student'" role="tabpanel" class="tab-pane fade" id="student">
                                    <div class="alert alert-primary" role="alert">
                                        <p>Akun FILKOM Apps training akan diaktifkan oleh fasilitator lab.</p>
                                        <p>Informasi login latihan dikirimkan melalui kanal kelas.</p>
                                        <p class="mb-0">Jika belum aktif, laporkan ke fasilitator, bukan ke layanan kampus asli.</p>
                                    </div>
                                    <div class="form-group mg-t-10">
                                        Telah memiliki akun?
                                        <button class="training-link" type="button" @click="showPanel('login')">Sign in</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <p class="tx-center tx-white-5 tx-12 mg-t-15 training-footer">
                Copyright &copy; 2018 PSIK FILKOM UB. All Rights Reserved.
                <br>
                <a href="https://filkom.ub.ac.id/legacy/" rel="noreferrer">
                    <img
                        src="https://filkom.ub.ac.id/legacy/assets/skin/filkom/img/logo/white-small.png"
                        class="img-responsive img-responsive-center"
                        alt="Logo Footer"
                        style="width:160px;"
                    >
                </a>
            </p>
        </section>
    </main>

    <section v-show="showDebrief" id="debrief" class="debrief">
        <h3>Trust cues to discuss</h3>
        <ul>
            <li><strong>Legacy CSS:</strong> Bootstrap-era controls can feel normal for academic systems.</li>
            <li><strong>Browser metadata:</strong> title, favicon, and descriptions shape expectations early.</li>
            <li><strong>Support links:</strong> help, register, and password-recovery affordances create institutional completeness.</li>
        </ul>
    </section>
</template>
