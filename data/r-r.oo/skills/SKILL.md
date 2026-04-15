---
name: r-r.oo
description: This tool enables formal S3-based object-oriented programming in R with support for inheritance, encapsulation, and reference semantics. Use when user asks to define S3 classes with mutable objects, create constructors and methods using R.oo, or implement inheritance and finalizers in R.
homepage: https://cloud.r-project.org/web/packages/R.oo/index.html
---

# r-r.oo

name: r-r.oo
description: Define and use S3-based object-oriented programming classes with or without references in R. Use this skill when creating complex R data structures that require inheritance, encapsulation, or reference semantics (mutable objects) using the R.oo framework.

# r-r.oo

## Overview
R.oo provides a robust framework for formal S3-based object-oriented programming in R. It introduces the `Object` class, which enables reference semantics (mutable objects) and simplifies the definition of methods and inheritance. It is designed to feel familiar to developers coming from languages like Java or C#.

## Installation
```r
install.packages("R.oo")
library(R.oo)
```

## Core Workflow
1. **Define a Constructor**: Use `setConstructorS3` to define the class and its initial state.
2. **Define Methods**: Use `setMethodS3` to create functions associated with the class.
3. **Instantiate**: Call the constructor function to create new instances.
4. **Inheritance**: Use `extend()` within a constructor to inherit from `Object` or another R.oo class.

## Key Functions and Usage

### Defining a Class
Always use `setConstructorS3`. The constructor should handle the case where no arguments are provided to support R's internal object creation mechanisms.

```r
setConstructorS3("Shape", function(color=NULL, ...) {
  extend(Object(), "Shape",
    .color = color
  )
})
```

### Defining Methods
Use `setMethodS3`. The first argument of the implementation function must be `this`, representing the object instance.

```r
setMethodS3("getColor", "Shape", function(this, ...) {
  this$.color
})

setMethodS3("setColor", "Shape", function(this, newColor, ...) {
  this$.color <- newColor
})
```

### Inheritance
To create a subclass, call `extend()` on an instance of the parent class.

```r
setConstructorS3("Circle", function(color=NULL, radius=1, ...) {
  extend(Shape(color=color), "Circle",
    .radius = radius
  )
})
```

### Reference Semantics
Objects extending `Object` are references. Modifying a field inside a method or via `$` affects the original object without needing to re-assign the object in the caller's environment.

```r
myCircle <- Circle(color="red", radius=5)
setColor(myCircle, "blue") 
# myCircle$.color is now "blue"
```

### Finalization
Implement a `finalize` method to clean up resources (like file handles or database connections) when the object is garbage collected.

```r
setMethodS3("finalize", "Shape", function(this, ...) {
  cat("Cleaning up shape with color:", this$.color, "\n")
})
```

## Best Practices
- **Field Access**: Use the `$` operator to access fields. By convention, internal fields often start with a dot (e.g., `.name`).
- **Method Dispatch**: R.oo uses S3 dispatch. Ensure `setMethodS3` is used so that the generic function is automatically created if it doesn't exist.
- **Encapsulation**: While R.oo doesn't strictly enforce private fields, using the dot prefix and providing getter/setter methods is the standard pattern.
- **Documentation**: Use `Rdoc` comments (if applicable) or standard R documentation to describe the class hierarchy.

## Reference documentation
- [README](./references/README.md)