// astro.config.mjs — WattLogic Static SPA
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://wattlogic.io',
  output: 'static',
  trailingSlash: 'never',
  integrations: [
    tailwind(),
  ],
});
