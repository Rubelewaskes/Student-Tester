<template>
    <div class="container">
        <router-view name="testlist"></router-view>
        <router-view name="test"></router-view>
        <router-view name="testresults"></router-view>
    </div>
</template>

<script>
  export default {
    name: 'content',
  }
</script>

<style scoped>

    .container{
        width: 60vw;
        margin-top: -3px;
        height: 90vh;
        background-color: #F8F1EA;
        position: relative;
        left: 20%;
        z-index: 0;
    }
    
</style>