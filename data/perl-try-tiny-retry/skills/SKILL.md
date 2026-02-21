---
name: perl-try-tiny-retry
description: The `perl-try-tiny-retry` module is a specialized extension of the popular `Try::Tiny` library.
homepage: https://github.com/dagolden/Try-Tiny-Retry
---

# perl-try-tiny-retry

## Overview
The `perl-try-tiny-retry` module is a specialized extension of the popular `Try::Tiny` library. While standard `Try::Tiny` provides `try`, `catch`, and `finally` blocks for exception handling, this module introduces a `retry` keyword. It is designed for scenarios where an operation (like a network call or a database query) might fail temporarily but succeed on a subsequent attempt. It allows you to define how many times to retry, how long to wait between attempts, and under what specific conditions a retry should occur.

## Usage Instructions

### Basic Retry Logic
Replace the standard `try` block with `retry` to enable multiple attempts. By default, it will attempt the block and, if it fails, move to the `catch` block unless retry conditions are met.

```perl
use Try::Tiny::Retry;

retry {
    # Code that might fail
    $client->get_data();
}
catch {
    warn "Operation failed after all retries: $_";
};
```

### Controlling Retries with `retry_if`
Use `retry_if` to inspect the error (stored in `$_`) and determine if a retry is appropriate. This is critical for avoiding infinite loops on permanent failures.

*   The block receives the current attempt count as an argument.
*   Return a true value to trigger a retry.

```perl
retry {
    die "Temporary Network Error" if $fail;
}
retry_if {
    my $attempt = shift;
    return ($attempt < 5 && $_ =~ /Temporary/);
};
```

### Implementing Delays
To prevent overwhelming a service, use `delay` or `delay_exp` to pause between attempts.

*   `delay { ... }`: Returns a fixed number of seconds to wait.
*   `delay_exp { ... }`: Often used for exponential backoff patterns.

```perl
retry {
    do_something();
}
delay {
    return 2; # Wait 2 seconds between every retry
};
```

### Execution Hooks with `on_retry`
Use `on_retry` to perform actions between attempts, such as logging the failure or resetting a state. The error is available in `$_` and the attempt count is passed as an argument.

```perl
retry {
    connect_to_db();
}
on_retry {
    my $attempt = shift;
    warn "Attempt $attempt failed: $_. Retrying...";
};
```

## Best Practices
*   **Always limit retries**: Never use `retry_if` without checking the attempt count to prevent infinite loops.
*   **Specific Error Matching**: Only retry on errors you know are transient (e.g., timeouts, 503 Service Unavailable). Do not retry on logic errors or 404s.
*   **Context Awareness**: Like `Try::Tiny`, `retry` preserves context (scalar, list, or void). Ensure your return values inside the `retry` block match your expectations outside of it.
*   **Avoid Multiple Delays**: Only one delay block should be used per retry statement; providing multiple delay blocks will result in a fatal error.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_dagolden_Try-Tiny-Retry.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-try-tiny-retry_overview.md)
- [Commit History and Feature Implementation](./references/github_com_dagolden_Try-Tiny-Retry_commits_master.md)