// tailwind.config.mjs — WattLogic
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx,mdx}'],
  darkMode: 'media',
  theme: {
    extend: {
      colors: {
        wl: {
          sun:      '#E8A020',
          'sun-lt': '#FDF3E0',
          'sun-dk': '#854F0B',
          teal:     '#1D9E75',
          'teal-lt':'#E1F5EE',
          'teal-dk':'#085041',
          blue:     '#185FA5',
          'blue-lt':'#E6F1FB',
          'blue-dk':'#042C53',
        },
      },
      fontFamily: {
        sans: ['DM Sans', 'system-ui', 'sans-serif'],
        mono: ['DM Mono', 'monospace'],
      },
      borderRadius: {
        sm: '6px',
        md: '10px',
        lg: '14px',
        xl: '20px',
      },
      maxWidth: {
        content: '780px',
        site:    '1100px',
      },
    },
  },
  plugins: [],
};
