<script>
	import WallpaperCard from "./Wallpaper_card.svelte";

    let url = "https://raw.githubusercontent.com/msm-linux/msm-wallpaper-index-source/main/index.json"
	
    // let options = s
    let promise = fetch(url).then((res) => res.json())

	// function handleReload(){
	// 	let reload = fetch(url).then((res) => res.json())
	// 	promise = reload
	// }
</script>
<!-- <button class="bg-slate-500 rounded px-3 py-5" on:click={() => {handleReload}}>Reload</button> -->
<div class="w-full rounded-md p-4">
    {#await promise}
		<script
			async
			src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
		<div class="flex justify-center w-full">
			<lottie-player
				src="https://assets6.lottiefiles.com/packages/lf20_dkz94xcg.json"
				background="transparent"
				speed="1"
				style="width: 200px; height: 200px;"
				loop
				autoplay
			/>
		</div>
	{:then data}
	<div class="card-grid">
	{#each Object.values(data) as item}

		<WallpaperCard thumbnail={item.thumbnail_file_link} name={item.filename} full_res={item.highres_link} />
		
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