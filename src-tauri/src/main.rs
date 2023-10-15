#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use wallpaper;


#[tauri::command]
fn set_wallpaper(wallpaperPath: String) {
  // println!("I was invoked from JS! SET WALLPAPER");
  // println!("{:?}", wallpaper::get());
  // println!("I was invoked from JS, with this message: {}", wallpaperPath);
  wallpaper::set_from_path(&wallpaperPath).unwrap();
  wallpaper::set_mode(wallpaper::Mode::Crop).unwrap();
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![set_wallpaper])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
