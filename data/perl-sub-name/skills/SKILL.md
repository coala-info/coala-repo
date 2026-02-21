---
name: perl-sub-name
description: The `perl-sub-name` skill focuses on the application of the `Sub::Name` module to enhance the introspective capabilities of Perl code.
homepage: https://github.com/gfx/Perl-Sub-Name
---

# perl-sub-name

## Overview
The `perl-sub-name` skill focuses on the application of the `Sub::Name` module to enhance the introspective capabilities of Perl code. By default, anonymous subroutines lack a name in the symbol table, which complicates debugging and performance analysis. This tool allows you to programmatically assign a name to a code reference. This is essential for dynamic code generation, factory patterns, and complex functional programming where identifying the origin of a specific closure is critical for maintenance.

## Usage Instructions

### Basic Syntax
The module exports one function by default: `subname`.

```perl
use Sub::Name;

# Assign a name to an existing sub reference
subname 'My::Package::assigned_name', $coderef;

# Assign a name during sub creation (returns the coderef)
my $sub = subname 'dynamic_callback' => sub { 
    print "Hello World\n"; 
};
```

### Naming Conventions
- **Fully Qualified Names**: If you provide a name without a package (e.g., `'my_func'`), it defaults to the current package. For clarity in large projects, use fully qualified names: `'Project::Module::function_name'`.
- **Anonymous Closures**: You can name different instances of the same closure differently. This is highly effective for debugging generators.

### Making Subs Callable by Name
`subname` only affects the internal name used by `caller` and `Carp`. It does **not** install the subroutine into the package's symbol table. To make the sub callable via the assigned name, you must perform a glob assignment:

```perl
use Sub::Name;

my $name = 'Generated::Sub';
my $code = sub { print "Executed\n" };

# Name it for stack traces AND install it to the symbol table
no strict 'refs';
*{$name} = subname $name, $code;

# Now it can be called normally
Generated::Sub();
```

## Best Practices and Expert Tips
- **Debugging Closures**: When creating subs in a loop or factory, include an identifier in the name (e.g., `subname "task_id_$id" => sub { ... }`). This makes `Carp::confess` output significantly more useful.
- **Performance Profiling**: Use `Sub::Name` when using `Devel::NYTProf`. Without it, all time spent in anonymous subs is aggregated under `__ANON__`, making it impossible to see which specific dynamic sub is a bottleneck.
- **Memory Efficiency**: The name is stored internally in the CV (code value) structure. While the overhead is small, avoid generating millions of unique names in long-running processes if they are not strictly necessary for diagnostics.
- **Lexical Scope**: Remember that naming a sub does not change its lexical scope or access to `my` variables; it only changes its metadata for introspection.

## Reference documentation
- [Perl-Sub-Name README](./references/github_com_gfx_Perl-Sub-Name.md)