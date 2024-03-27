/** @type {import('tailwindcss').Config} */
/* To compile:
    - for dev: npx tailwindcss -i ./app/assets/css/src/style.css -o ./app/assets/css/dist/style.css --watch
    - for build: npx tailwindcss -i ./app/assets/css/src/style.css -o ./app/assets/css/dist/style.css --minify
*/
module.exports = {
    content: ["./app/*.html"],
    /* chemins à surveiller */
    plugins: [ /* module indispensable */
      require('@tailwindcss/typography'), /* permet l'utilisation la classe prose, re-stylant les contenus utiisateurs */
      require('@tailwindcss/forms'), /* uniformise les formulaires */
    ],
  }