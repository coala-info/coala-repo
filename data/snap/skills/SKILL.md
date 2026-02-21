---
name: snap
description: SnapKit is a Domain Specific Language (DSL) designed to make Auto Layout management intuitive on Apple platforms.
homepage: https://github.com/SnapKit/SnapKit
---

# snap

## Overview

SnapKit is a Domain Specific Language (DSL) designed to make Auto Layout management intuitive on Apple platforms. It wraps the standard Auto Layout engine, allowing you to define relationships between UI components using a concise syntax. Use this skill to generate layout code, troubleshoot constraint conflicts, or migrate from manual constraint anchors to a more maintainable declarative style.

## Usage Patterns

### Basic Constraint Creation
Use `snp.makeConstraints` to define the initial layout for a view. Ensure the view has been added to a superview before calling this.

```swift
view.addSubview(childView)
childView.snp.makeConstraints { make in
    make.top.equalTo(otherView.snp.bottom).offset(20)
    make.left.right.equalToSuperview().inset(16)
    make.height.equalTo(50)
}
```

### Constraint Relationships
- **equalTo**: Matches an attribute exactly.
- **lessThanOrEqualTo**: Sets a maximum limit.
- **greaterThanOrEqualTo**: Sets a minimum limit.
- **equalToSuperview()**: Convenience for pinning to the parent view.

### Offsets and Insets
- **.offset(x)**: Used for spacing between elements (e.g., moving a view down or to the right).
- **.inset(x)**: Used for padding within a container (e.g., pushing edges inward). Note: SnapKit 3.0+ does not require inverting bottom/right values; positive values move the edge inward.

### Updating and Remaking
- **snp.updateConstraints**: Use this to modify existing constants (offsets/insets) for performance. It will throw a fatal error if you attempt to create a new constraint that didn't exist.
- **snp.remakeConstraints**: Use this to completely clear previous SnapKit constraints on a view and define a new set. This is useful for state-based layout changes.

### Priorities
Set priorities to resolve conflicts or define optional behaviors:
- `.priority(.high)` or `.priority(750)`
- `.priority(.low)` or `.priority(250)`
- `.priority(.required)` or `.priority(1000)`

### Safe Area and Margins
Always prefer `safeAreaLayoutGuide` for modern iOS layouts to handle notches and home indicators:
```swift
make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
```

## Expert Tips

- **Debugging**: Use `.labeled("uniqueName")` on a constraint chain to make console logs easier to read when Auto Layout fails.
- **Chaining**: You can chain attributes if they share the same target: `make.width.height.equalTo(100)` creates a square.
- **References**: If you need to toggle a specific constraint later, store a reference to it:
  ```swift
  var topConstraint: Constraint?
  childView.snp.makeConstraints { make in
      self.topConstraint = make.top.equalToSuperview().constraint
  }
  // Later
  self.topConstraint?.update(offset: 50)
  ```
- **Avoid fatal errors**: Never use `updateConstraints` if the logic might introduce a new attribute (e.g., switching from pinning to the top to pinning to the bottom). Use `remakeConstraints` instead.

## Reference documentation
- [SnapKit README](./references/github_com_SnapKit_SnapKit.md)
- [SnapKit Issues & Common Errors](./references/github_com_SnapKit_SnapKit_issues.md)