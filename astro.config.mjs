import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: 'https://weibeidong1994-max.github.io',
  base: '/self_index',
  vite: {
    plugins: [tailwindcss()],
  },
});
