---
name: ball
description: The ball skill creates accessible, CSS-only tooltips using HTML5 data attributes and CSS variables. Use when user asks to create tooltips, position tooltips, or style tooltips without using JavaScript.
homepage: https://github.com/kazzkiq/balloon.css
---


# ball

## Overview
The `ball` skill (based on balloon.css) allows for the creation of functional, accessible tooltips using only CSS. By leveraging HTML5 data attributes and CSS variables, it eliminates the need for JavaScript-heavy tooltip libraries. This skill is ideal for developers looking to improve UI/UX with minimal performance overhead, as the minified library weighs approximately 1.1kb.

## Implementation Guide

### Installation
You can integrate the library via npm or a CDN:

*   **npm**: `npm install balloon-css`
*   **CDN**: `<link rel="stylesheet" href="https://unpkg.com/balloon-css/balloon.min.css">`

### Basic Usage
To add a tooltip to an element, use the `aria-label` attribute for the text and `data-balloon-pos` for the position.

```html
<button aria-label="Tooltip text here" data-balloon-pos="up">Hover me!</button>
```

### Positioning Options
The `data-balloon-pos` attribute supports the following values:
*   **Standard**: `up`, `down`, `left`, `right`
*   **Corner**: `up-left`, `up-right`, `down-left`, `down-right`

### Advanced Control
*   **Programmatic Visibility**: To force a tooltip to stay visible (e.g., during a tutorial or via JS toggle), add the `data-balloon-visible` attribute.
*   **Disable Animation**: Use the `data-balloon-blunt` attribute to remove the default fade/slide transitions for an instant appearance.
*   **Special Characters**: You can include HTML entities (e.g., `&#9787;`) or emojis directly within the `aria-label`.

### Customization via CSS Variables
Balloon.css uses CSS variables for easy styling. You can apply these globally via `:root` or to specific classes.

**Available Variables:**
*   `--balloon-border-radius`: Adjust the roundness of the tooltip box.
*   `--balloon-color`: Change the background color.
*   `--balloon-font-size`: Adjust the text size.
*   `--balloon-move`: Control the distance the tooltip travels during the "slide" animation.

**Example Custom Class:**
```css
.tooltip-custom {
  --balloon-color: #333;
  --balloon-font-size: 14px;
  --balloon-border-radius: 4px;
}
```

## Best Practices
1.  **Accessibility**: Always use `aria-label`. Since Balloon.css relies on this attribute, it ensures that screen readers can describe the element's function.
2.  **Z-Index**: If tooltips are being cut off, check the `overflow` property of parent containers.
3.  **Icon Fonts**: When using icon fonts (like Font Awesome) inside a button with a tooltip, ensure the `aria-label` is placed on the interactive element (the button), not the icon itself.

## Reference documentation
- [balloon.css README](./references/github_com_kazzkiq_balloon.css.md)