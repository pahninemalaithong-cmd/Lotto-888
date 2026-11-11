/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        lotto: {
          red: '#c92a2a',
          'red-dark': '#b02525',
          'red-light': '#fdf2f2',
          navy: '#1e293b',
          green: '#16a34a',
          'green-light': '#e8f7ee',
          amber: '#d97706',
          yellow: '#f59e0b',
        }
      },
      fontFamily: {
        sans: ['Noto Sans Lao', 'Noto Sans Thai', 'system-ui', '-apple-system', 'sans-serif'],
        mono: ['Courier New', 'monospace'],
      }
    },
  },
  plugins: [],
}
