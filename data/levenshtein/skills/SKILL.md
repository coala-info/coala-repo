---
name: levenshtein
description: This tool calculates the edit distance between strings and identifies the closest match from a list of candidates. Use when user asks to calculate string similarity, find the closest matching word, or implement fuzzy search suggestions.
homepage: https://github.com/ka-weihe/fastest-levenshtein
metadata:
  docker_image: "quay.io/biocontainers/levenshtein:0.20.1"
---

# levenshtein

## Overview
The `levenshtein` skill leverages the `fastest-levenshtein` library to provide high-performance string comparison. It allows you to quantify the difference between two sequences (the number of single-character edits required to change one word into another) and efficiently identify the best match from a collection of candidate strings. Use this skill when performance is a priority, as this implementation is optimized to be significantly faster than alternatives like `js-levenshtein` or `leven`.

## Installation
To use this tool in a Node.js project:
```bash
npm i fastest-levenshtein
```

## Core Usage Patterns

### Calculating Edit Distance
Use the `distance` function to get the integer edit distance between two strings.
- **Node.js**: `const { distance } = require('fastest-levenshtein');`
- **Deno**: `import { distance } from 'https://deno.land/x/fastest_levenshtein/mod.ts';`

```javascript
// Returns 2 (one insertion, one substitution)
console.log(distance('fast', 'faster')); 
```

### Finding the Closest Match
Use the `closest` function to find the string within an array that has the lowest edit distance to your target string.
- **Node.js**: `const { closest } = require('fastest-levenshtein');`
- **Deno**: `import { closest } from 'https://deno.land/x/fastest_levenshtein/mod.ts';`

```javascript
const target = 'fast';
const candidates = ['slow', 'faster', 'fastest'];

// Returns 'faster'
console.log(closest(target, candidates));
```

## Expert Tips and Best Practices
- **Performance Scaling**: The library maintains high performance across various string lengths. For very short strings (N=4), it can handle over 40,000 ops/sec, and remains efficient even for longer strings (N=1024).
- **Fuzzy Search**: When implementing a search bar, use `closest` to provide "did you mean?" suggestions by comparing user input against a dictionary of valid terms.
- **TypeScript Support**: The library is written in TypeScript. When using `closest` in TS, the input array is marked as `readonly`, ensuring your candidate list is not mutated during the comparison process.
- **Deno Integration**: For Deno projects, always use the specific versioned URL or the `mod.ts` entry point from the Deno land repository to ensure stability.

## Reference documentation
- [fastest-levenshtein README](./references/github_com_ka-weihe_fastest-levenshtein.md)