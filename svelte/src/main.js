import App from './App.svelte';

const app = new App({
	target: document.body,
	props: {
        dataViewUrl: "ws://localhost:4000/data",
    }
});

export default app;
