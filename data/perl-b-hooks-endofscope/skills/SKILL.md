---
name: perl-b-hooks-endofscope
description: This tool executes specific code blocks immediately after the Perl compiler finishes processing a lexical scope. Use when user asks to execute code at the end of a scope, clean up temporary compilation states, or finalize lexical effects in Perl.
homepage: https://github.com/karenetheridge/B-Hooks-EndOfScope
---


# perl-b-hooks-endofscope

## Overview
B::Hooks::EndOfScope provides a reliable way to execute code at the moment the Perl compiler finishes processing the surrounding lexical scope. This is a specialized tool for Perl developers who need to perform actions that are context-sensitive to the compilation process, such as cleaning up temporary state or finalizing lexical effects. It supports both high-performance XS (C-based) and Pure-Perl implementations to ensure compatibility across different environments.

## Usage and Best Practices

### Basic Implementation
The module exports the `on_scope_end` function by default. You can pass a block or a code reference.

```perl
use B::Hooks::EndOfScope;

{
    # Some compilation-time logic here
    on_scope_end {
        # This code runs after the closing brace is compiled
        warn "Finished compiling this scope";
    };
}
```

### Implementation Selection
The module automatically chooses between an XS implementation (using `Variable::Magic`) and a Pure-Perl (PP) fallback. You can explicitly force an implementation if your environment has specific constraints:

*   **XS Implementation**: Required if you need to throw exceptions from within the callback.
*   **Pure-Perl Implementation**: Used when C-compilers or `Variable::Magic` are unavailable. Note that in PP mode, compile-time exceptions are downgraded to warnings.

**Forcing implementation via code:**
```perl
use B::Hooks::EndOfScope::XS; # Force XS
# OR
use B::Hooks::EndOfScope::PP; # Force Pure-Perl
```

**Forcing implementation via environment variable:**
Set `B_HOOKS_ENDOFSCOPE_IMPLEMENTATION` to either `XS` or `PP` before execution.

### Expert Tips
*   **Exception Handling**: If your callback might `die`, ensure the XS version is installed. The PP version cannot safely propagate exceptions during compilation and will only issue a warning.
*   **Legacy Perl Support**: 
    *   On Perl versions **5.8.0 to 5.8.3**, the module deliberately leaks a single empty hash per scope to prevent memory corruption caused by a core interpreter bug.
    *   On Perl **5.6.x**, you must use the `local` operator explicitly on `%^H` for the module to function correctly.
*   **Custom Imports**: Since the module uses `Sub::Exporter`, you can rename the exported function to avoid collisions:
    ```perl
    use B::Hooks::EndOfScope on_scope_end => { -as => 'execute_at_end' };
    ```

## Installation
To install via Bioconda:
```bash
conda install bioconda::perl-b-hooks-endofscope
```

## Reference documentation
- [B::Hooks::EndOfScope GitHub Repository](./references/github_com_karenetheridge_B-Hooks-EndOfScope.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-b-hooks-endofscope_overview.md)