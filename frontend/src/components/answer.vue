<template>
    <p class="answer">{{index+1}}. {{ answer }}</p>
</template>

<script>
     export default {
        props: {
            answer: String,
            index: Number
        }
    }
</script>

<style scoped>
    .answer{
        margin-left: 2%;
    }
</style>