<script>
    import LiveDataSocket from './live_data/LiveDataSocket.svelte';
    import LiveData from './live_data/LiveData.svelte';

    export let dataViewUrl;
</script>

<main>
	<LiveDataSocket url={dataViewUrl}>
		<LiveData path="/hello_world" let:data={data} let:pushEvent={pushEvent}>
			{#each data.categories as category}
				<h1>Category</h1>
				{#each category.posts as post}
					<h2>{post.title}</h2>
				{/each}
			{/each}

			<button on:click={() => pushEvent({e: "add_post"})}>Add Post</button>
		</LiveData>
	</LiveDataSocket>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>
