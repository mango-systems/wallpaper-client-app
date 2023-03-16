<script>
  import {
    createDir,
    BaseDirectory,
    writeBinaryFile,
  } from "@tauri-apps/api/fs";
  import { appDataDir } from "@tauri-apps/api/path";
  import {
    isPermissionGranted,
    requestPermission,
    sendNotification,
  } from "@tauri-apps/api/notification";

  export let thumbnail = "";
  export let name = "";
  export let full_res = "";

  const appDirectory = async () => {
    const appDir = await appDataDir();
    console.log(appDir);
  };

  async function downloadImage() {
    let permissionGranted = await isPermissionGranted();
    if (!permissionGranted) {
      const permission = await requestPermission();
      permissionGranted = permission === "granted";
    }
    if (permissionGranted) {
      // sendNotification('Tauri is awesome!');
      sendNotification({
        title: "MSM Wallpaper Client",
        body: `Downloading wallpaper: ${name}`,
      });
    }

    appDirectory();

    console.log("Download Image function RAN");
    const response = await fetch(full_res);
    const blob = await response.blob();
    const url = URL.createObjectURL(blob);
    console.log(blob);
    console.log(url);

    const binaryData = [];
    binaryData.push(blob);

    // const binaryBlob = new Blob(binaryData, { type: 'application/octet-stream' });

    console.log(binaryData);
    const arrayBuffer = await blob.arrayBuffer();

    await createDir("wallpapers", {
      dir: BaseDirectory.AppData,
      recursive: true,
    });

    function extractFilenameFromLink(link) {
      const path = link.split("/").pop(); // Extract the last part of the URL
      const filename = path.split("?")[0]; // Remove any query parameters
      return filename;
    }

    const filename = extractFilenameFromLink(full_res)

    await writeBinaryFile(
      { path: filename, contents: new Uint8Array(arrayBuffer) },
      { dir: BaseDirectory.AppData }
    ).then(
        () => {
            sendNotification({
        title: "MSM Wallpaper Client",
        body: `Download Complete Wallpaper: ${filename}`,
      });
        }
    )
    ;
    // hence the first url is the path where it will write, next is the binary
  }
</script>

<div class="relative">
  <div class="w-full rounded bg-[#272727] hover:ring hovercard">
    <div class="w-full">
      <img
        draggable="false"
        class="w-full rounded-t"
        src={thumbnail}
        alt={name}
      />
    </div>
    <div class="w-full p-2">
      <h3 class="truncate mr-5 text-white mb-2 cardtitle">{name}</h3>
      <div class="buttongroup">
        <!-- <a href={full_res} download="image.png" target="_blank">
            <button>Download Test</button>
        </a> -->
        <button class="card-button" on:click={downloadImage}
          >Download wallpaper GNOME</button
        >
        <button class="card-button">Set wallpaper GNOME</button>
        <button class="card-button">Set wallpaper KDE</button>
        <button class="card-button">Set wallpaper Windows</button>
      </div>
    </div>
  </div>
</div>
