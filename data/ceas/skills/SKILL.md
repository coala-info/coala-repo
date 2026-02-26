---
name: ceas
description: Ceaser Easing is a Compass extension that provides Penner easing equations for CSS3 transitions and animations. Use when user asks to apply sophisticated easing functions, generate cubic-bezier values, or use the ceaser-transition mixin in SCSS.
homepage: https://github.com/jhardy/compass-ceaser-easing
---


# ceas

## Overview
Ceaser Easing is a Compass extension that brings classic Penner easing equations to CSS3. It simplifies the creation of sophisticated animations by providing pre-defined variables and mixins that generate the appropriate `cubic-bezier` values for transitions and animations, moving beyond standard CSS keywords like `ease-in` or `linear`.

## Installation and Setup
To add Ceaser Easing to a project:

1. **Install the gem**:
   `gem install ceaser-easing`

2. **Configure Compass**:
   Add `require 'ceaser-easing'` to your `config.rb` file.

3. **Import in SCSS/Sass**:
   `@import "ceaser-easing";`

For new projects, use the Compass CLI:
`compass create <project_name> -r ceaser-easing -u ceaser-easing`

## Core Usage Patterns

### The `ceaser()` Function
Use this function as a value for `transition-timing-function` or `animation-timing-function`. It returns the specific `cubic-bezier` coordinates.

```scss
.element {
  transition: all 1.2s ceaser($easeInQuad);
}

.animated-box {
  animation: slide 10s ceaser($easeOutExpo) infinite;
}
```

### The `ceaser-transition` Mixin
A shorthand mixin to define the property, duration, ease type, and delay in one line.
**Signature**: `@include ceaser-transition($property, $duration, $ease-type, $delay)`

```scss
#box {
  @include ceaser-transition(width, 500ms, $easeInOutQuint, 1s);
}
```

## Available Easing Variables
The tool provides variables for standard and Penner equations. Common types include:

*   **Standard**: `$linear`, `$ease`, `$ease-in`, `$ease-out`, `$ease-in-out`
*   **Penner Equations**:
    *   **Quad**: `$easeInQuad`, `$easeOutQuad`, `$easeInOutQuad`
    *   **Cubic**: `$easeInCubic`, `$easeOutCubic`, `$easeInOutCubic`
    *   **Quart/Quint**: `$easeInQuart`, `$easeInQuint`, etc.
    *   **Sine/Expo/Circ**: `$easeInSine`, `$easeOutExpo`, `$easeInOutCirc`, etc.
    *   **Back**: `$easeInBack`, `$easeOutBack`, `$easeInOutBack`

## Expert Tips
*   **Variable vs. String**: Modern versions use Sass variables (e.g., `$ease-in`). If you must use the old string syntax (e.g., `ceaser("ease-in")`), you must set `$ceaser-legacy: true;` before the import.
*   **Default Duration**: The `ceaser-transition` mixin defaults to a duration of `500ms` and a delay of `0` if not specified.
*   **Property Default**: The mixin defaults to `all` if the property argument is omitted.

## Reference documentation
- [Compass Ceaser CSS Easing Transitions](./references/github_com_jhardy_compass-ceaser-easing.md)