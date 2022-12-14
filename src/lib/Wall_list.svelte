<script>
	import WallpaperCard from "./Wallpaper_card.svelte";

    let url = "https://raw.githubusercontent.com/msm-linux/msm-wallpaper-index-source/main/index.json"
	
    // let options = 
    let promise = fetch(url).then((res) => res.json())
</script>

<div class="w-full rounded-md mt-3 p-4">
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
			<div class="py-32">
				<h2>Oops: something went wrong...</h2>
				<h3><strong>Please Refresh</strong></h3>
				<code>{error}</code>
			</div>
		</div>
	{/await}

</div>