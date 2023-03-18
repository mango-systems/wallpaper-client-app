<script>
	import { onMount } from 'svelte';
	import { appWindow } from '@tauri-apps/api/window';
	// import Datepicker from 'flowbite-datepicker/Datepicker';
	import '../app.css';
  import Overlay from '$lib/Overlay.svelte';

	// const datepickerEl = document.getElementById('datepickerId');
	// new Datepicker(datepickerEl, {
	// 	// options
	// });

	let title = 'Wallpaper repo GUI';

	let isOverlayEnabled = false;

	// https://developer.gnome.org/hig/patterns/containers.html
	// const maximized = appWindow.isMaximized();
	// console.log(maximized)

	let isMaximized = false;
	// ERROR-CORRECTION, it is turned to true, but its not working as expected

	// console.log(`${isMaximized}: Default value of isMaximised`);

	async function checkWindowMaximizedStatus() {
		isMaximized = await appWindow.isMaximized();
		// console.log(isMaximized);
	}

	onMount(() => {
		checkWindowMaximizedStatus();
	});

	// $: windowSize = [window.innerWidth, window.innerHeight];

	// function handleWindowResize() {
	// 	const [width, height] = [window.innerWidth, window.innerHeight];
	// 	if (width !== windowSize[0] || height !== windowSize[1]) {
	// 		checkWindowMaximizedStatus();
	// 		windowSize = [width, height];
	// 	}
	// }

	// window icons
	import minimize from '$lib/window-decorations/window-minimize-symbolic.svg';
	import maximise from '$lib/window-decorations/window-maximize-symbolic.svg';
	import close from '$lib/window-decorations/application-exit-symbolic.svg';
	import restore from '$lib/window-decorations/window-restore-symbolic.svg';
	import add from '$lib/window-decorations/list-add-symbolic.svg';

	// function create_new_window() {
	// 	const webview = new WebviewWindow('my-label', {
	// 		url: '/add_countdown',
	// 		title: "Tauri webview",
	// 		height: 400,
	// 		width:300,
	// 		center: true,
	// 		transparent: true,
	// 		decorations: false,
	// 		alwaysOnTop: true,
	// 		focus: true,
	// 		// resizable: false,
	// 	});

	// 	webview.once('tauri://created', function () {
	// 		// webview window successfully created
	// 	});
	// 	webview.once('tauri://error', function (e) {
	// 		// an error happened creating the webview window
	// 	});
	// await webview.emit("some event", "data");
	// unlisten()
	// }

	// console.log(window.isMaximized())
</script>

<div class="flex flex-col w-screen  h-screen bg-transparent overflow-y-clip select-none">
	<div id="title-bar" class="bg-titlebar h-12  rounded-t-xl border-border_color border-[1px] select-none hover:cursor-default relative z-50 text-window_fg">
		<div class="w-full h-full absolute top-0 flex align-middle flex-row justify-center" id="layer-1">
			<p class="text-center m-auto font-semibold text-sm">{title}</p>
		</div>
		<div class="w-full h-full absolute top-0 flex flex-row" id="layer-2">
			<div id="settings-area" class=" flex align-middle items-center h-full p-[5px]">
				<button
					class="h-full aspect-square rounded-md duration-200 transition hover:bg-buttonbg flex items-center justify-center"
					on:click={() => {
						isOverlayEnabled = true;
					}}
				>
					<div>
						<img class="stroke-window_fg" src={add} alt="new-alarm" />
					</div>
				</button>
			</div>
			<div id="title-area " class="flex-grow flex items-center justify-center pl-[7%]" data-tauri-drag-region>
				<!-- <p class="text">Test title bar</p> -->
			</div>
			<div id="titlebar-button-area" class="flex items-center gap-3 pr-3 z-50">
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<div
					id="minimise"
					class="w-6 bg-buttonbg aspect-square rounded-full duration-150 hover:bg-buttonbghover flex align-middle justify-center"
					on:click={() => {
						appWindow.minimize();
					}}
				>
					<img class="stroke-window_fg" src={minimize} alt="" />
				</div>
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<div
					id="maximise"
					class="w-6 bg-buttonbg aspect-square rounded-full duration-150 hover:bg-buttonbghover  flex align-middle justify-center"
					on:click={() => {
						appWindow.toggleMaximize();
						checkWindowMaximizedStatus();
					}}
				>
					{#if isMaximized}
						<img class="stroke-window_fg" src={maximise} alt="" />
					{:else}
						<img class="stroke-window_fg" src={restore} alt="" />
					{/if}
				</div>
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<div
					id="close"
					class="w-6 bg-buttonbg aspect-square rounded-full duration-150 hover:bg-buttonbghover  flex align-middle justify-center"
					on:click={() => {
						appWindow.close();
					}}
				>
					<img class="stroke-window_fg" src={close} alt="" />
				</div>
			</div>
		</div>
	</div>
	<div class="bg-background text-primaryfont h-full rounded-b-xl border-t-0 border-border_color border-[1px] overflow-y-scroll">
		<div class="px-[10vw] md:px-[13vw]  transition duration-200">
			<slot />
		</div>
	</div>

	{#if isOverlayEnabled}
		<!-- svelte-ignore a11y-click-events-have-key-events -->
		<form action="">
			<div id="overlay-date-picker" class="absolute top-0 w-screen h-screen bg-[#0c0c0c80] z-[100]  flex justify-center items-center" data-tauri-drag-region>
				<div class=" h-[70vh] w-[60vw]  rounded-lg flex flex-col shadow-2xl">
					<div class="h-[56px] bg-titlebar rounded-t-lg  border-border_color border-[1px] relative">
						<div class="absolute top-0 flex w-full justify-center h-full align-middle">
							<p class="text-center font-semibold text-sm m-auto text-primaryfont">Add new wallpapers</p>
						</div>
						<div class="absolute top-0 w-full h-full">
							<div class="flex flex-row align-middle h-full p-[6px]  justify-between w-full">
								<button
									class="w-[5.5rem] font-semibold  text-primaryfont  transition duration-150 bg-view_bg_color_hover hover:bg-view_bg_color rounded-md"
									on:click={() => {
										isOverlayEnabled = false;
									}}>Cancel</button
								>
								<!-- <input type="submit"> -->
								
              <a class="h-full" target="_blank" rel="noreferrer" href="https://github.com/msm-linux/msm-wallpaper-index-source">
                <button type="submit"
								class="h-full px-4 font-semibold  text-accent_fg_color transition duration-150 hover:bg-accent_color_hover bg-accent_color rounded-md"
								on:click={() => {
									isOverlayEnabled = false;
								}}>Open repo</button
							>
              </a>
							</div>
						</div>
					</div>
					<div class="h-full rounded-b-lg  border-border_color border-t-0 border-[1px] bg-background px-[8vw] py-4 text-primaryfont">
						<div class="w-full">
							<!-- OVERLAY ELEMENTS -->
              <Overlay />
						</div>
					</div>
				</div>
			</div>
		</form>
	{/if}
</div>

<!-- <script use:window="{resize: handleWindowResize}" /> -->
<!-- <style>
	* {
		outline: 3px solid #ffffff50;
	}
</style> -->
