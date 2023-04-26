<script>
	import WallpaperCard from './Wallpaper_card.svelte';

	const subreddit = "r/wallpaper"
	const sort = "hot"
	let url = `https://www.reddit.com/${subreddit}.json?sort=${sort}`;

	// let options = s
	let promise = fetch(url).then((res) => res.json());

	// function handleReload(){
	// 	let reload = fetch(url).then((res) => res.json())
	// 	promise = reload
	// }
</script>

<!-- <button class="bg-slate-500 rounded px-3 py-5" on:click={() => {handleReload}}>Reload</button> -->
<div class="w-full rounded-md p-4">
	{#await promise}
		<script async src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
		<div class="flex justify-center w-full">
			<lottie-player src="https://assets6.lottiefiles.com/packages/lf20_dkz94xcg.json" background="transparent" speed="1" style="width: 200px; height: 200px;" loop autoplay />
		</div>
		<div class="text-center animate-pulse">
			<h1>Loading...</h1>
		</div>
	{:then data}
		<!-- {console.log(data)} -->
		<div class="card-grid">
			<!-- {#each Object.values(data) as item} -->
			{#each data.data.children as item}
				<!-- {console.log(item.data.is_gallery)} -->
				{#if !item.data.is_gallery && !item.data.url_overridden_by_dest.includes("gallery")}
				<!-- {#if !item.data.is_gallery && !item.data.url_overridden_by_dest.includes("gallery") && item.data.thumbnail} -->

					<!-- {item.data.thumbnail} -->
					<WallpaperCard thumbnail={item.data.thumbnail} name={item.data.title} full_res={item.data.url_overridden_by_dest} />
				{/if}
			{/each}
		</div>
	{:catch error}
		<div class="text-center w-full justify-center flex">
			<div class="p-32 w-full rounded ring-2 ring-red-500 font-mono text-red-500">
				<h2>Oops: something went wrong...</h2>
				<h3><strong>Please Refresh</strong></h3>
				<code>{error}</code>
			</div>
		</div>
	{/await}
</div>
