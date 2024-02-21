<template>
  <div class="main">
    <router-view/>
  </div>
</template>

<style>
#app {
  margin: 0, 0, 0, 0;
}

* {
  margin: 0;
}

.main{
  width: 100vw;
  height: 100vh;
  background: url(assets/background.jpg);
  background-color: rgba(248,241,234,0.9);
  background-blend-mode: lighten;
}


</style>
