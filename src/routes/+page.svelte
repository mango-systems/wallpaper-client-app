<script>
	import Greet from '$lib/Greet.svelte';
	import WallList from '$lib/Wall_list.svelte';
	import OpenButton from '$lib/Open_button.svelte';

	// disable context menu
	document.addEventListener('contextmenu', (event) => event.preventDefault());
</script>

<div class="main-container h-full pt-7">
	<div class="flex flex-col gap-5">
		<Greet />

		<OpenButton />

		<WallList />
		<div class="h-48 w-full">
			<p class="text-center pb-10">Made with ☕ by MSM</p>
		</div>
	</div>
</div>
