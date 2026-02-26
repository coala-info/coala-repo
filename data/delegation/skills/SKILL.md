---
name: delegation
description: The delegation library provides a lightweight mechanism for implementing object delegation and proxy patterns in Python. Use when user asks to wrap existing objects, delegate method calls dynamically, implement the Decorator pattern, or broadcast calls to multiple objects.
homepage: https://github.com/symonsoft/delegation
---


# delegation

## Overview
The `delegation` library provides a simple, lightweight mechanism for object delegation in Python. Instead of using complex inheritance hierarchies, this tool allows you to wrap existing objects and delegate method calls to them dynamically. It is particularly useful for implementing the Decorator pattern, creating proxy objects, or broadcasting method calls to a collection of objects (multi-delegation). Use this skill to correctly implement `SingleDelegated` and `MultiDelegated` patterns in Python code.

## Installation
The package can be installed via pip or conda:
```bash
pip install delegation
# OR
conda install bioconda::delegation
```

## Core Usage Patterns

### Single Delegation
Use `SingleDelegated` when you want to wrap a single object. The wrapper will prioritize its own methods; if a method or attribute is not found on the wrapper, it is forwarded to the delegated object.

```python
from delegation import SingleDelegated

class MyWrapper(SingleDelegated):
    def local_method(self):
        return "Handled by wrapper"

# Usage
wrapped_obj = SomeExistingClass()
proxy = MyWrapper(wrapped_obj)

# Calls local_method on MyWrapper
proxy.local_method() 
# Calls original_method on wrapped_obj via delegation
proxy.original_method() 
```

### Multi-Delegation
Use `MultiDelegated` to forward calls to multiple objects simultaneously. This is effective for event broadcasting or aggregate processing.

*   **Behavior**: Calling a method on a `MultiDelegated` instance invokes that method on every delegate in the order they were provided.
*   **Return Values**: The result of a delegated call is a `list` containing the return values from each delegate.

```python
from delegation import MultiDelegated

class Broadcast(MultiDelegated):
    pass

# Usage
group = Broadcast(obj_a, obj_b, obj_c)
# Returns [result_from_a, result_from_b, result_from_c]
results = group.perform_action() 
```

## Expert Tips and Best Practices

1.  **Method Overriding**: To intercept a delegated call, simply define the method in your subclass. The delegation logic only triggers if `getattr` fails to find the attribute on your class instance.
2.  **Property Support**: As of version 1.1, the library supports property delegation. Accessing a property on the wrapper will correctly retrieve the property value from the delegate.
3.  **Constructor Handling**: When inheriting from `SingleDelegated` or `MultiDelegated`, ensure you pass the delegate objects to the superclass constructor.
4.  **Type Checking**: Be aware that while the wrapper behaves like the delegate, `isinstance(wrapper, DelegateClass)` will return `False` unless you explicitly handle it or use interfaces/ABCs.
5.  **State Management**: Avoid storing state in the wrapper that conflicts with the delegate's attributes, as this can lead to confusing behavior during attribute resolution.

## Reference documentation
- [GitHub Repository and Examples](./references/github_com_symonsoft_delegation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_delegation_overview.md)