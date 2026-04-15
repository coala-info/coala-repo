---
name: murasaki
description: Murasaki is a minimalist and lightweight theme for the Hexo static site generator designed for content clarity and responsive design. Use when user asks to install a Hexo theme, configure dark mode for a blog, or integrate analytics and comments into a static site.
homepage: https://github.com/prinsss/hexo-theme-murasaki
---

# murasaki

## Overview
Murasaki is a minimalist, lightweight theme for the Hexo static site generator, inspired by the default Typecho theme and NexT. It is designed for bloggers who prioritize content clarity and a clean aesthetic. The theme is currently in an early development stage and features a responsive design, dark mode support, and various modular integrations for analytics and comments.

## Installation and Activation
To integrate Murasaki into a Hexo project, follow these command-line steps:

1. **Clone the Repository**: Navigate to your Hexo root directory and clone the theme into the specific themes folder:
   `git clone https://github.com/printempw/hexo-theme-murasaki themes/murasaki`

2. **Enable the Theme**: Open your site's primary configuration file in the root directory and locate the `theme` setting. Change its value to `murasaki`.

3. **Verify Installation**: Run the Hexo local server to ensure the theme loads correctly:
   `hexo clean && hexo server`

## Configuration Best Practices
To ensure the theme remains easy to update, avoid modifying the files inside the `themes/murasaki` folder directly. Instead, use the following patterns:

- **Theme Configuration Overrides**: Define all theme-specific settings within a `theme_config` section in your site's main configuration file. This allows you to pull updates from the Murasaki repository without overwriting your personal settings.
- **Asset Management**: Place custom favicons or images in your site's `source/images` folder and reference them in the configuration.

## Feature Integration and Customization
Murasaki supports several advanced features that can be toggled via configuration keys:

- **Analytics**: Supports Umami analytics, server-side Google Analytics, and pageview counters.
- **Comments**: Integrated support for the Giscus comment system.
- **Visual Enhancements**: 
    - **Dark Mode**: Built-in support for dark themes.
    - **Lazy Loading**: Images are processed for lazy loading to improve page performance.
    - **Typography**: Uses PingFang SC and Fira Mono as default fonts for a clean technical look.
- **Styling**: The theme is built using Stylus. If deep CSS customization is required, look for modular `.styl` files in the `layout` and `source` directories.

## Expert Tips
- **Accessibility**: The theme includes specific accessibility features, such as underlines for links, which can be further customized in the style sheets.
- **Performance**: Leverage the built-in image lazy loading to maintain high Lighthouse scores, especially for image-heavy posts.
- **Sidebar**: The sidebar is customizable; check the latest commits for updates on sidebar layout options.

## Reference documentation
- [Murasaki Main README](./references/github_com_prinsss_hexo-theme-murasaki.md)
- [Murasaki Commit History](./references/github_com_prinsss_hexo-theme-murasaki_commits_master.md)