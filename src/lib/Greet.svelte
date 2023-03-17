<script>
	import { getVersion } from '@tauri-apps/api/app';

	// const tauriVersion = async () => {await getTauriVersion();}

	// export let data
	// const { appVersion } = data;
	async function appVersion() {
		return await getVersion()
	}
</script>

<div>
	<div class="banner w-full flex flex-col rounded-md py-11 px-5 text-white bg-[#382353]">
		<img draggable="false" class="w-24" src="https://cdn-icons-png.flaticon.com/512/2659/2659360.png" alt="logo" />
		<h1>MSM wallpaper Client</h1>
		{#await appVersion() then data}
			<h2>Version: {data}</h2>
		{/await}
		<a target="_blank" rel="noreferrer" href="https://github.com/msm-linux/msm-wallpaper-index-source"><p><u>Open wallpaper repo</u></p></a>
	</div>
</div>
