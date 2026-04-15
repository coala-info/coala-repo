---
name: treeview
description: The treeview tool transforms nested JavaScript objects into interactive, accessible tree structures for displaying complex data hierarchies in web applications. Use when user asks to display hierarchical data, navigate tree structures, select nodes, search tree nodes, expand or collapse tree nodes, customize tree appearance, or manage node states.
homepage: https://github.com/jonmiles/bootstrap-treeview
metadata:
  docker_image: "biocontainers/treeview:v1.1.6.4dfsg1-4-deb_cv1"
---

# treeview

## Overview
The treeview skill provides a specialized workflow for implementing the Bootstrap Tree View plugin. This tool transforms nested JavaScript objects into interactive, accessible tree structures that integrate natively with Bootstrap's CSS. It is best used for displaying complex data hierarchies where users need to navigate, select, or search through parent-child relationships in a web application.

## Implementation Guide

### Installation and Setup
Install the package via npm or bower to manage dependencies:

```bash
npm install bootstrap-treeview
# OR
bower install bootstrap-treeview
```

Include the required dependencies in your HTML head and before the closing body tag:
1. Bootstrap CSS (v3.0.0+)
2. jQuery (v1.9.0+)
3. bootstrap-treeview.js

### Basic Initialization
Define a placeholder element in your HTML:
```html
<div id="tree-container"></div>
```

Initialize the tree with a JavaScript object array. Each node must at least contain a `text` property:

```javascript
var treeData = [
  {
    text: "Parent Node",
    nodes: [
      { text: "Child Node 1" },
      { text: "Child Node 2" }
    ]
  }
];

$('#tree-container').treeview({ data: treeData });
```

### Node Configuration
Customize individual nodes using the following properties:
- **icon / selectedIcon**: Specify Glyphicon classes (e.g., "glyphicon glyphicon-folder-open").
- **color / backColor**: Override global colors for specific nodes.
- **selectable**: Set to `false` to make a node act as a non-clickable header.
- **state**: An object to set `checked`, `disabled`, `expanded`, or `selected` status on load.
- **tags**: An array of strings displayed as Bootstrap badges on the right.

### Global Options and Styling
Pass an options object during initialization to control behavior:
- **levels**: Integer (default: 2). Controls the depth of nodes expanded by default.
- **showCheckbox**: Boolean. Enables multi-selection via checkboxes.
- **highlightSearchResults**: Boolean. Works with the `.search()` method to visually flag matches.
- **enableLinks**: Boolean. If true, uses the `href` property in node data to create anchors.

### Programmatic Interaction
Use the plugin's methods to control the tree after initialization:

```javascript
// Search the tree
$('#tree-container').treeview('search', [ 'QueryString', { ignoreCase: true, exactMatch: false } ]);

// Expand all nodes
$('#tree-container').treeview('expandAll', { levels: 2, silent: true });

// Get selected nodes
var selected = $('#tree-container').treeview('getSelected');
```

## Expert Tips
- **Performance**: For very large datasets, set `levels: 1` during initialization to prevent the browser from rendering thousands of hidden DOM elements at once.
- **Event Handling**: Always use the provided event hooks (e.g., `nodeSelected`, `nodeChecked`, `nodeExpanded`) rather than standard jQuery click handlers to ensure you receive the node data object in the callback.
- **Deep Linking**: Use the `revealNode` method to programmatically expand the path to a specific node if you are navigating via URL parameters or external search results.

## Reference documentation
- [Bootstrap Tree View Main Documentation](./references/github_com_jonmiles_bootstrap-treeview.md)
- [Method and Event Implementation History](./references/github_com_jonmiles_bootstrap-treeview_commits_master.md)