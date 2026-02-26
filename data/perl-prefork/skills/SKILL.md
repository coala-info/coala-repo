---
name: perl-prefork
description: The perl-prefork tool provides a unified way to handle module loading by delaying it for procedural scripts or pre-loading it for forking environments to optimize memory sharing. Use when user asks to optimize Perl module loading, manage memory sharing via copy-on-write in forking environments, or implement the prefork pragma in modules and scripts.
homepage: https://github.com/karenetheridge/prefork
---


# perl-prefork

## Overview
The `prefork` pragma provides a unified way to handle module loading across different execution profiles. In procedural scripts (CGI), it delays loading to save time and memory. In forking environments (web servers, daemons), it ensures modules are loaded before the process forks to maximize memory sharing via copy-on-write (CoW). This skill guides the implementation of `prefork` in both "Loader" modules and "Forker" scripts.

## Implementation Patterns

### 1. Loader Implementation (Module Side)
Use `prefork` in modules that normally use `require` to delay loading. This allows the module to remain lightweight for standard scripts while being fully pre-loaded in forking environments.

**Standard Usage:**
```perl
use prefork 'Module::Name';
```

**Optional Support (No Dependency):**
If you want your module to benefit from `prefork` without making it a hard requirement for users:
```perl
eval "use prefork 'Module::Name';";
```

### 2. Forker Implementation (Script/App Side)
The "Forker" is the component that initiates the `fork()`. It must signal `prefork` to flush the queue and load all registered modules.

**Direct Enablement:**
```perl
use prefork ':enable';
```

**Manual/Conditional Enablement:**
Call this immediately before the `fork()` call in your main loop or startup routine:
```perl
prefork::enable() if $INC{'prefork.pm'};
```

### 3. Integration with Runtime Loaders
If using third-party loaders like `Class::Autouse`, register a callback to ensure they initialize when the environment switches to forking mode.

```perl
prefork::notify( \&my_load_routine );
```

## Expert Tips & Best Practices
- **Environment Auto-Detection**: `prefork` automatically detects `$ENV{MOD_PERL}`. If your application runs under mod_perl, it will default to forking mode without manual configuration.
- **Memory Optimization**: Always use `prefork` for large, dependency-heavy modules. Loading these before a fork ensures the underlying C structures and Perl opcodes stay in shared memory.
- **Single Argument Limit**: When using the pragma, only pass one module name per `use prefork` statement. Additional arguments are currently ignored.
- **State Checking**: You can check if the application is currently in forking mode by inspecting `$prefork::FORKING`.

## Reference documentation
- [Optimized module loading for forking or non-forking processes](./references/github_com_karenetheridge_prefork.md)
- [perl-prefork - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-prefork_overview.md)