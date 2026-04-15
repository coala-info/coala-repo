---
name: perl-test-exec
description: This tool intercepts Perl's exec calls to allow for testing process-replacement logic without terminating the test runner. Use when user asks to validate that a script calls exec, verify arguments passed to a system execution, or prevent a test script from exiting during an exec call.
homepage: https://metacpan.org/pod/Test::Exec
metadata:
  docker_image: "quay.io/biocontainers/perl-test-exec:0.04--pl526_0"
---

# perl-test-exec

## Overview
The `perl-test-exec` skill provides guidance on using the `Test::Exec` module to validate process-replacement logic. In standard Perl testing, calling `exec` terminates the test runner, making it impossible to verify that the call was reached or that the correct arguments were passed. This tool intercepts the `exec` call, allowing the test to continue and assert that the execution attempt occurred as expected.

## Usage Guidelines

### Basic Test Pattern
To test if a specific function or block calls `exec`, use the `exec_ok` function. This prevents the test script from exiting.

```perl
use Test::More tests => 1;
use Test::Exec;

# Test if the block calls exec
exec_ok {
    exec 'echo', 'hello';
} 'The code should attempt to exec echo';
```

### Verifying Arguments
You can verify that `exec` was called with specific binary paths or arguments by checking the `is_exec` status.

- **Check for any exec call**: `exec_ok { ... }`
- **Check for no exec call**: `never_exec_ok { ... }`

### Handling Failures
If the code inside the block fails to call `exec`, `exec_ok` will fail the test. This is useful for ensuring error-handling logic doesn't bypass the process replacement.

### Integration with Test::More
`Test::Exec` exports functions that are compatible with the standard `Test::Builder` framework. It should be loaded alongside `Test::More`.

## Best Practices
- **Isolation**: Only wrap the specific line or small block that is expected to trigger the `exec`.
- **Avoid Side Effects**: Since `Test::Exec` intercepts the system call, the actual program will not run. Do not use this for integration tests where you need the side effects of the executed program to occur.
- **Platform Consistency**: While the tool works on most POSIX systems, ensure your test environment has the target binaries available if your code performs checks before calling `exec`.

## Reference documentation
- [Test::Exec Documentation](./references/metacpan_org_pod_Test__Exec.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-exec_overview.md)