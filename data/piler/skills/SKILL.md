---
name: piler
description: The `piler` skill (based on pagePiling.js) enables the creation of immersive, layered scrolling experiences for web applications.
homepage: https://github.com/alvarotrigo/pagePiling.js
---

# piler

yaml
name: piler
description: Use this skill when you need to implement or configure the pagePiling.js library to create single-page scrolling websites where sections are "piled" on top of each other. This skill provides guidance on HTML structure, JavaScript initialization, and customization options for the pagePiling plugin.
```

## Overview
The `piler` skill (based on pagePiling.js) enables the creation of immersive, layered scrolling experiences for web applications. It allows developers to stack sections vertically or horizontally, providing a "piling" effect where one section slides over another. This skill is essential for building modern, high-impact landing pages that require precise control over scrolling behavior, URL anchoring, and touch-device compatibility.

## Implementation Patterns

### Core HTML Structure
The tool requires a specific wrapper and section-based hierarchy.
- Use a parent container (typically `#pagepiling`).
- Each section must have the `section` class.
- For sections with overflow content, add the `pp-scrollable` class to enable internal scrolling without breaking the pile effect.

```html
<div id="pagepiling">
    <div class="section">Section 1</div>
    <div class="section pp-scrollable">Section 2 (Long Content)</div>
    <div class="section">Section 3</div>
</div>
```

### Initialization and Configuration
Initialize the plugin within a `$(document).ready()` block. 

**Key Configuration Options:**
- `direction`: Set to `'vertical'` (default) or `'horizontal'`.
- `scrollingSpeed`: Transition duration in milliseconds (default: 700).
- `anchors`: An array of strings used for URL hash navigation (e.g., `index.html#firstPage`).
- `menu`: A jQuery selector for the menu linked to the sections.
- `navigation`: An object to configure the side bullet navigation (tooltips, position, colors).

```javascript
$('#pagepiling').pagepiling({
    menu: '#myMenu',
    anchors: ['page1', 'page2', 'page3'],
    navigation: {
        'position': 'right',
        'tooltips': ['Home', 'About', 'Contact']
    },
    sectionsColor: ['#bfda00', '#2ebe21', '#2C3E50']
});
```

## Expert Tips and Best Practices

### Navigation and Anchors
- **Unique IDs**: Ensure that `anchors` values do not match any existing `id` or `name` attributes on the page to prevent browser conflict during scroll events.
- **Menu Linking**: To link a menu, ensure the `href` of your menu links matches the strings defined in the `anchors` array.

### Event Handling
Use the built-in callbacks to trigger animations or state changes:
- `onLeave(index, nextIndex, direction)`: Triggered when leaving a section.
- `afterLoad(anchorLink, index)`: Triggered once the section has finished loading.

### Mobile and Touch Optimization
- The tool is touch-compatible by default.
- Use the `css3: true` option (default) to leverage hardware acceleration for smoother transitions on mobile browsers.
- If a section contains a map or a scrolling div that should not trigger the page pile, use the `normalScrollElements` option with the appropriate selector.

## Reference documentation
- [pagePiling.js Main Documentation](./references/github_com_alvarotrigo_pagePiling.js.md)
- [pagePiling.js Distribution Files](./references/github_com_alvarotrigo_pagePiling.js_tree_master_dist.md)