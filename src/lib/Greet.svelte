<script>
	import { getVersion } from '@tauri-apps/api/app';
	import msmIcon from '$lib/assets/images/msm-icon.png';
	// const tauriVersion = async () => {await getTauriVersion();}

	// export let data
	// const { appVersion } = data;
	async function appVersion() {
		return await getVersion();
	}
</script>

<div>
	<div class="banner w-full flex flex-row rounded-md py-11 px-5 text-white bg-[conic-gradient(at_top_right,_var(--tw-gradient-stops))] from-purple-800 via-violet-900 to-purple-800">
		<div class="flex flex-row gap-6">
			<div>
				<img draggable="false" class="w-24" src={msmIcon} alt="logo" />
			</div>
			<div class="m-auto">
				<h1 class="text-lg font-semibold">MSM wallpaper Client</h1>
				{#await appVersion() then data}
					<h2 class="font-mono text-sm">Version: {data}</h2>
				{/await}
				<a  target="_blank" rel="noreferrer" href="https://github.com/msm-linux/msm-wallpaper-index-source">
					<p class="mt-1 text-gray-300 hover:underline underline-offset-4">Open wallpaper repo ↗</p>
				</a>
			</div>
		</div>
	</div>
</div>

