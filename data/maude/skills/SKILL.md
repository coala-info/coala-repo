---
name: maude
description: Maude is a high-performance reflective language and system for equational and rewriting logic specification and programming. Use when user asks to specify formal systems, program in rewriting logic, or model concurrent systems.
homepage: https://github.com/maude-lang/Maude
---


# maude

yaml
name: maude
description: A high-performance reflective language and system for equational and rewriting logic specification and programming. Use when dealing with formal methods, logic programming, concurrent systems, or executable semantics for languages and models of concurrency.
```
## Overview
Maude is a powerful language and system designed for specifying and programming in equational and rewriting logic. It excels at modeling concurrent systems, defining executable semantics for various languages, and exploring formal methods. Its reflective capabilities make it highly extensible and suitable for advanced metaprogramming tasks.

## Usage Instructions

Maude is primarily used through its interpreter, which can be invoked with various commands and options. The core functionality revolves around defining theories, modules, and executing rewrite rules.

### Basic Invocation

To start the Maude interpreter, simply type `maude` in your terminal.

```bash
maude
```

This will launch the interactive Maude environment.

### Loading Modules and Theories

You can load Maude files (containing module definitions, theories, etc.) using the `load` command.

```maude
load my_module.maude
```

### Executing Rewrites

The primary operation in Maude is rewriting. You can apply rewrite rules to terms.

```maude
[mod-name]: term => pattern .
```

For example, to rewrite a term `t` using rules from a module `M`:

```maude
[M]: t => .
```

To rewrite a term `t` until it can no longer be rewritten:

```maude
[M]: t ! => .
```

To rewrite a term `t` a specific number of times (e.g., 5 times):

```maude
[M]: t =>! 5 .
```

### Defining Modules and Theories

Maude code is organized into modules and theories. Here's a basic structure:

```maude
mod MY-MODULE is
  sort MySort .
  op myOp : MySort -> MySort .
  eq myOp(x) = x .
endm

th MY-THEORY is
  sort MySort .
  op myOp : MySort -> MySort .
  eq myOp(x) = x .
endth
```

### Key Concepts and Commands

*   **`mod`**: Defines a module.
*   **`th`**: Defines a theory.
*   **`sort`**: Declares a sort (type).
*   **`op`**: Declares an operator (function symbol).
*   **`eq`**: Declares an equational axiom.
*   **`load`**: Loads a Maude file.
*   **`quit`**: Exits the Maude interpreter.
*   **`help`**: Displays help information.

### Expert Tips

*   **Module Composition**: Maude supports powerful module composition operations, allowing you to build complex systems from smaller, reusable parts. Familiarize yourself with `protecting`, `extending`, and `using` keywords.
*   **Reflection**: Maude's reflective capabilities allow you to inspect and manipulate Maude programs and data from within Maude itself. This is crucial for advanced metaprogramming and building custom tools.
*   **Performance**: For performance-critical applications, pay close attention to the efficiency of your rewrite rules and data structures. Use built-in efficient data types and consider the order of rules.
*   **Documentation**: The official Maude manual is an invaluable resource for understanding its advanced features and syntax.

## Reference documentation
- [Maude Overview](./references/github_com_maude-lang_Maude.md)
- [Maude Manual (PDF/HTML)](./references/github_com_maude-lang_Maude_tree_master_doc.md)