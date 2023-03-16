<script>
	import { open } from '@tauri-apps/api/shell';
	import { downloadDir } from '@tauri-apps/api/path';

	import Greet from '$lib/Greet.svelte';
	import WallList from '$lib/Wall_list.svelte';

	import rightIcon from '$lib/assets/icons/right-symbolic.svg';
	import folderIcon from '$lib/assets/icons/folder-visiting-symbolic.svg';

	// disable context menu
	document.addEventListener('contextmenu', (event) => event.preventDefault());

	async function openDownloadFolder() {
		console.log('openFolder Command');
		const downloadDirPath = await downloadDir();
		const downloadFolderName = `${downloadDirPath}/wallpapers-msm-app-test`;
		await open(downloadFolderName);
	}
</script>

<div class="main-container w-screen h-screen px-[13%] pt-7">
	<div class="flex flex-col gap-5">
		<Greet />

		<button class="hover:ring-2  rounded-md" on:click={openDownloadFolder}>
			<div class="w-full h-12 bg-[#3a3a3a] flex flex-row justify-between align-middle  p-3 shadow-md">
				<!-- svelte-ignore a11y-missing-attribute -->
				<img class="stroke-white stroke-2" src={folderIcon} />
				<h2 class="text-white font-medium text-md m-auto">Open Saved Wallpapers folder</h2>
				<!-- svelte-ignore a11y-missing-attribute -->
				<img class="stroke-white stroke-2" src={rightIcon} />
			</div>
		</button>

		<WallList />
		<div class="h-48 w-full" />
		<p class="text-center pb-10">Made with ☕ by MSM</p>
	</div>
</div>

<style>
	/* *{
    outline: solid 2px #00000050;
  } */
</style>
