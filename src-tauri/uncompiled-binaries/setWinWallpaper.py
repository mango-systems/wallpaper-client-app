import sys
import ctypes

SPI_SETDESKWALLPAPER = 20

def set_wallpaper(path):
    ctypes.windll.user32.SystemParametersInfoW(SPI_SETDESKWALLPAPER, 0, path, 0)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python set_wallpaper.py <wallpaper_path>")
        sys.exit(1)

    wallpaper_path = sys.argv[1]

    set_wallpaper(wallpaper_path)

# python set_wallpaper.py path\to\image.jpg
# compile into binary using pyinstaller