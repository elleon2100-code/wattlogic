// astro.config.mjs — WattLogic Static SPA
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://wattlogic.site',
  output: 'static',
  trailingSlash: 'never',
  integrations: [
    tailwind(),
  ],
});
