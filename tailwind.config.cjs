/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js,svelte,ts}"],
  theme: {
    extend: {
      colors: {
        background: "var(--background)",
        titlebar: "var(--titlebar)",
        primaryfont: "var(--primaryfont)",
        buttonbg: "var(--buttonbg)",
        buttonbghover: "var(--buttonbghover)",
        border_color: "var(--border_color)",
        view_bg_color: "var(--view_bg_color)",
        view_bg_color_hover: "var(--view_bg_color_hover)",
        accent_color: "var(--accent_color)",
        accent_fg_color: "var(--accent_fg_color)",
        accent_color_hover: "var(--accent_color_hover)",
        banner_bg: "var(--banner_bg)",
        window_fg: "var(--window_fg)"
      }
    },
  },
  plugins: [],
};
