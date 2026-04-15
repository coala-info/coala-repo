---
name: stamp
description: Stampit is a JavaScript utility used to create composable factory functions for object-oriented programming without class-based inheritance. Use when user asks to create stamps, compose objects from multiple behaviors, manage private state through closures, or define shared methods and properties.
homepage: https://github.com/stampit-org/stampit
metadata:
  docker_image: "quay.io/biocontainers/stamp:2.1.3--py27_0"
---

# stamp

## Overview
Stampit is a lightweight JavaScript utility used to create "stamps," which are standardized, composable factory functions. Instead of relying on rigid class-based inheritance, Stampit allows you to build objects by composing different behaviors, properties, and initialization logic. Use this skill to manage object state, define shared methods, and create privileged functions with private data through closures.

## Core Composition Components
Stamps are built using three primary descriptors:

*   **props**: Defines the state or data properties that will be shallow-copied onto every new object instance.
*   **methods**: Defines functions that will be placed on the object's prototype (delegation).
*   **init**: A function (or array of functions) called when an object is instantiated. This is used for constructor logic and creating private variables via closures.

## Usage Patterns and Best Practices

### Creating and Composing Stamps
Use `stampit()` to define a base behavior and `.compose()` to extend it. You can also pass multiple stamps into the `stampit()` function to merge them.

```javascript
import stampit from "stampit";

// Define a base stamp
const HasName = stampit({
  props: { name: 'Unnamed' }
});

// Define a behavior stamp
const CanSpeak = stampit({
  methods: {
    speak() { console.log(`${this.name} says hello!`); }
  }
});

// Compose them into a new stamp
const Person = stampit(HasName, CanSpeak);
const user = Person({ name: 'Alice' });
```

### Managing Private Data
To create private state that is only accessible to specific "privileged" methods, define variables inside the `init` function and attach methods to `this` within that same scope.

```javascript
const Secretive = stampit({
  init() {
    let secret = "shhh!"; // Private variable
    this.getSecret = () => secret; // Privileged method
  }
});
```

### Initialization Logic
The `init` function receives an object containing the arguments passed to the factory, as well as a reference to the instance (`instance` or `this`).

```javascript
const Character = stampit({
  props: { health: 100 },
  init({ name = 'Hero' }) {
    this.name = name;
  }
});
```

## Expert Tips
*   **Avoid Hierarchy**: Instead of `class A extends B extends C`, create small, focused stamps (e.g., `CanFly`, `HasHealth`, `Positionable`) and compose them as needed.
*   **Immutability**: Stamps are immutable. Calling `.compose()` on a stamp returns a *new* stamp rather than modifying the existing one.
*   **Property Overlays**: When composing stamps, properties in later stamps will overwrite properties with the same name from earlier stamps (concatenative inheritance).

## Reference documentation
- [Stampit Main Repository](./references/github_com_stampit-org_stampit.md)