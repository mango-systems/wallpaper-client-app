<script>
	// ### TASK ####
	//  using path api get the path of the download location and then write those wallpaper to there
	import { BaseDirectory, writeBinaryFile, exists, createDir } from '@tauri-apps/api/fs';
	import { appDataDir, downloadDir } from '@tauri-apps/api/path';
	import { Command } from '@tauri-apps/api/shell';
	import { isPermissionGranted, requestPermission, sendNotification } from '@tauri-apps/api/notification';

	export let thumbnail = '';
	export let name = '';
	export let full_res = '';

	const downloadFolderName = 'wallpapers-msm-app-test';

	const appDirectory = async () => {
		const appDir = await appDataDir();
		console.log(appDir);
	};

	/**
	 * @param {string} link
	 */
	function extractFilenameFromLink(link) {
		const path = link.split('/').pop(); // Extract the last part of the URL
		// @ts-ignore
		const filename = path.split('?')[0]; // Remove any query parameters
		return filename;
	}

	const filename = extractFilenameFromLink(full_res);

	async function downloadImage() {
		let permissionGranted = await isPermissionGranted();
		if (!permissionGranted) {
			const permission = await requestPermission();
			permissionGranted = permission === 'granted';
		}
		if (permissionGranted) {
			// sendNotification('Tauri is awesome!');
			sendNotification({ title: 'MSM Wallpaper Client', body: `Downloading wallpaper: ${name}` });
		}

		console.log('Download Image function RAN');
		const response = await fetch(full_res);
		const blob = await response.blob();

		// const binaryBlob = new Blob(binaryData, { type: 'application/octet-stream' });
		const arrayBuffer = await blob.arrayBuffer();

		// await createDir("wallpapers", {
		// dir: BaseDirectory.AppData,
		// recursive: true,
		// });
		// const downloadDirPath = await downloadDir();

		let doesDownloadFolderExists = await exists(downloadFolderName, { dir: BaseDirectory.Download });
		const WriteFolder = `${BaseDirectory.Download}/downloadFolderName`;

		let doesFileExists = await exists(`${downloadFolderName}/${filename}`, { dir: BaseDirectory.Download });

		async function downloadFile() {
			if (doesFileExists) {
				console.log('image exists, thus not downloading');
			} else {
				await writeBinaryFile({ path: `${downloadFolderName}/${filename}`, contents: new Uint8Array(arrayBuffer) }, { dir: BaseDirectory.Download }).then(() => {
					sendNotification({ title: 'MSM Wallpaper Client', body: `Download Complete Wallpaper: ${filename}` });
				});
			}
		}

		if (doesDownloadFolderExists) {
			console.log('folder exists, writing to folder');
			downloadFile();
		} else {
			console.log('folder Does not exist, creating folder');
			await createDir(downloadFolderName, { dir: BaseDirectory.Download, recursive: true });
			downloadFile();
		}

		// await writeBinaryFile(
		//   { path: filename, contents: new Uint8Array(arrayBuffer) },{ dir: BaseDirectory.AppData }
		// ).then(() => {
		//   sendNotification({  title: "MSM Wallpaper Client",  body: `Download Complete Wallpaper: ${filename}`});
		// });
		// hence the first url is the path where it will write, next is the binary
	}

	async function setGNOMEwallpaper() {
		const downloadDirPath = await downloadDir();
		const wallpaper_file_path = `file://${downloadDirPath}/${downloadFolderName}/${filename}`;

		async function setWallpaper() {
			const wallpaperCommand = new Command('gnome-wallpaper-dark', ['set', 'org.gnome.desktop.background', 'picture-uri', wallpaper_file_path]);
			const wallpaperCommandDark = new Command('gnome-wallpaper-dark', ['set', 'org.gnome.desktop.background', 'picture-uri-dark', wallpaper_file_path]);
			const child = await wallpaperCommand.spawn();
			const childDark = await wallpaperCommandDark.spawn();
		}

		let doesFileExists = await exists(`${downloadFolderName}/${filename}`, { dir: BaseDirectory.Download });
		if (doesFileExists) {
			setWallpaper();
		} else {
			console.log('file not found, downloading, then setting as wallpaper');
			await downloadImage();
			setWallpaper();
		}
	}

	// async function setKDEwallpaper() {
	//   // WILL NOT WORK!

	// 	const downloadDirPath = await downloadDir();
	// 	const wallpaper_file_path = `${downloadDirPath}/${downloadFolderName}/${filename}`;

	// 	async function setWallpaper() {
	//     // UNTESTED
	// 		console.log(`kde wallpaper path : ${wallpaper_file_path}`)
	// 		const wallpaperCommand = new Command('kde-set', [`${wallpaper_file_path}`]);
	//     // d.writeConfig("Image", "file:///path/to/image.jpg")}'
	//     // qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file:///path/to/image.jpg")}'

	// 		const child = await wallpaperCommand.spawn();
	// 		console.log('pid:', child.pid);
	// 	}

	// 	let doesFileExists = await exists(`${downloadFolderName}/${filename}`, { dir: BaseDirectory.Download });
	// 	if (doesFileExists) {
	// 		setWallpaper();
	// 	} else {
	// 		console.log('file not found, downloading, then setting as wallpaper');
	// 		await downloadImage();
	// 		setWallpaper();
	// 	}
	// }

	async function setKDEwallpaper() {
		// '${wallpaper_file_path}'`
		// UNTESTED
		const downloadDirPath = await downloadDir();
		const wallpaper_file_path = `${downloadDirPath}${downloadFolderName}/${filename}`;
		console.log(wallpaper_file_path)
		async function setWallpaper() {
			// UNTESTED
			const wallpaperCommandKDE = new Command('kde-set', [`${wallpaper_file_path}`]);
			// d.writeConfig("Image", "file:///path/to/image.jpg")}'
			// qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file:///path/to/image.jpg")}'

			const child = await wallpaperCommandKDE.spawn();
			console.log('pid:', child.pid);
		}

		let doesFileExists = await exists(`${downloadFolderName}/${filename}`, { dir: BaseDirectory.Download });
		if (doesFileExists) {
			setWallpaper();
		} else {
			console.log('file not found, downloading, then setting as wallpaper');
			await downloadImage();
			setWallpaper();
		}
	}

	async function setWinwallpaper() {
		// '${wallpaper_file_path}'`
		// UNTESTED
		const downloadDirPath = await downloadDir();
		const wallpaper_file_path = `${downloadDirPath}${downloadFolderName}\\${filename}`;
		console.log(wallpaper_file_path)
		async function setWallpaper() {
			// UNTESTED
			const wallpaperCommand = Command.sidecar('binaries/setWinWallpaper', [`${wallpaper_file_path}`]);
			// d.writeConfig("Image", "file:///path/to/image.jpg")}'
			// qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file:///path/to/image.jpg")}'

			const child = await wallpaperCommand.spawn();
			console.log('pid:', child.pid);
		}

		let doesFileExists = await exists(`${downloadFolderName}/${filename}`, { dir: BaseDirectory.Download });
		if (doesFileExists) {
			setWallpaper();
		} else {
			console.log('file not found, downloading, then setting as wallpaper');
			await downloadImage();
			setWallpaper();
		}
	}


</script>

<div class="relative">
	<div class="w-full rounded bg-[#272727] hover:ring hovercard">
		<div class="w-full">
			<img draggable="false" class="w-full rounded-t" src={thumbnail} alt={name} />
		</div>
		<div class="w-full p-2">
			<h3 class="truncate mr-5 text-white mb-2 cardtitle">{name}</h3>
			<div class="buttongroup">
				<!-- <a href={full_res} download="image.png" target="_blank">
            <button>Download Test</button>
        </a> -->
				<button class="card-button" on:click={setGNOMEwallpaper}>Set wallpaper GNOME</button>
				<button class="card-button" on:click={setKDEwallpaper}>Set wallpaper KDE</button>	
				<button class="card-button" on:click={setWinwallpaper}>Set wallpaper Windows</button>
				<!-- <button class="card-button" on:click={currentDir}>test dir</button> -->
				<button class="card-button" on:click={downloadImage}>Just Download</button>
			</div>
		</div>
	</div>
</div>
