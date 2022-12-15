<script>
    export let thumbnail = "";
    export let name = "";
    export let full_res = ""
</script>

<div class="relative">
    <div
    class="w-full rounded bg-[#272727] hover:ring hovercard"
>
    <div class="w-full">
        <img draggable="false" class="w-full rounded-t" src={thumbnail} alt={name} />
    </div>
    <div class="w-full p-2">
        <h3 class="truncate mr-5 text-white mb-2 cardtitle">{name}</h3>
        <div class="buttongroup">
            <button class="card-button">Download wallpaper GNOME</button>
            <button class="card-button">Set wallpaper GNOME</button>
            <button class="card-button">Set wallpaper KDE</button>
            <button class="card-button">Set wallpaper Windows</button>
        </div>
    </div>
</div>
</div>
