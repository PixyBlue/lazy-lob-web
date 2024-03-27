/** @type {import('tailwindcss').Config} */
/* To compile:
    - for dev: npx tailwindcss -i ./app/assets/css/src/style.css -o ./app/assets/css/dist/style.css --watch
    - for build: npx tailwindcss -i ./app/assets/css/src/style.css -o ./app/assets/css/dist/style.css --minify
*/
module.exports = {
    content: ["./app/*.html"],
    darkMode: 'selector',
    plugins: [
      require('@tailwindcss/typography'),
      require('@tailwindcss/forms'),
    ],
  }