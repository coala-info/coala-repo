---
name: wordcloud
description: wordcloud2.js is a specialized library designed to create "Wordle" style tag clouds on 2D canvases or via HTML elements.
homepage: https://github.com/timdream/wordcloud2.js
---

# wordcloud

## Overview
wordcloud2.js is a specialized library designed to create "Wordle" style tag clouds on 2D canvases or via HTML elements. It utilizes a pixel-based algorithm to detect occupied space, allowing for tight packing of words. This skill should be used when you need to visualize datasets where word frequency or specific weighting needs to be represented through font size and orientation. It is particularly effective for web-based dashboards, data reports, and infographic generation.

## Installation and Setup
To use the library in a Node.js environment or via a build system:

```javascript
npm install wordcloud
```

For browser-based usage, include the `wordcloud2.js` script from the source.

## Core Usage Pattern
The primary interface is the `WordCloud` function, which requires a target element and a configuration object.

### Data Format
The `list` property is the most critical part of the options object. It must be an array of arrays:
```javascript
var list = [['keyword', 12], ['secondary', 6], ['minor', 2]];
WordCloud(document.getElementById('my_canvas'), { list: list });
```

## Key Configuration Options
*   **list**: An array of `[word, size]` pairs.
*   **gridSize**: Size of the grid in pixels. Larger values increase performance but decrease the "tightness" of the word fit.
*   **weightFactor**: A multiplier applied to all sizes in the list (e.g., `size * weightFactor`).
*   **fontFamily**: The font to use for the words.
*   **color**: Can be a specific color string, or a function `callback(word, weight, fontSize, distance, theta)` for dynamic coloring.
*   **rotateRatio**: Probability of a word rotating (0 to 1).
*   **shape**: The shape of the cloud (e.g., 'circle', 'cardioid', 'diamond', 'square').

## Expert Tips and Best Practices
*   **Performance Tuning**: If the cloud takes too long to render, increase the `gridSize`. A `gridSize` of 8 or 16 is significantly faster than 1 or 2.
*   **Scaling**: Use the `weightFactor` to ensure the largest words fit within the canvas. If words are disappearing, your `weightFactor` is likely too high for the canvas dimensions.
*   **Canvas vs. HTML**: Use the canvas renderer for better performance and easy "Save as Image" functionality. Use the HTML renderer if you need the words to be selectable or require CSS-based styling/hover effects.
*   **Clearance**: If words are overlapping, ensure the `gridSize` is not set too low relative to the font sizes being used.
*   **Handling Negative Values**: Ensure all weights are positive; the library is designed to map font size to weight, and negative values may cause rendering errors or unexpected behavior.

## Reference documentation
- [wordcloud2.js README](./references/github_com_timdream_wordcloud2.js.md)