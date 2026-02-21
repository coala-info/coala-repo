---
name: justbackoff
description: The `justbackoff` skill provides a streamlined way to implement retry strategies in Python applications.
homepage: https://github.com/admiralobvious/justbackoff
---

# justbackoff

## Overview
The `justbackoff` skill provides a streamlined way to implement retry strategies in Python applications. It manages a backoff counter that increases exponentially based on a configurable factor, capped by a maximum duration. This is essential for building resilient systems that gracefully handle transient failures without hammering the target service.

## Core Implementation
The library centers around the `Backoff` class. It tracks state internally, so you must call `duration()` to get the current wait time and `reset()` once an operation succeeds.

### Basic Configuration
Initialize the backoff object with specific parameters to control the progression:
- `min_ms`: The starting wait time (default: 100).
- `max_ms`: The maximum wait time limit (default: 10000).
- `factor`: The multiplier applied after each `duration()` call (default: 2).
- `jitter`: Boolean to add randomness to the duration to prevent "thundering herd" problems.

```python
from justbackoff import Backoff

# Initialize with custom settings
b = Backoff(min_ms=100, max_ms=5000, factor=2, jitter=True)

# Get current wait time (returns seconds as float)
wait_time = b.duration() 
```

## Best Practices

### The Retry Loop Pattern
Always wrap your volatile logic in a `while` loop and ensure `reset()` is called immediately upon success to return the counter to `min_ms`.

```python
import time
from justbackoff import Backoff

b = Backoff()
while True:
    try:
        # Your volatile operation here
        result = perform_task()
        b.reset() # Success! Reset the counter
        break
    except Exception as e:
        wait = b.duration()
        print(f"Task failed: {e}. Retrying in {wait}s")
        time.sleep(wait)
```

### Using Jitter
Enable `jitter=True` for distributed systems. Without jitter, multiple clients failing at the same time will retry at the exact same intervals, potentially crashing a recovering server. Jitter spreads these retries out.

### Unit Testing
When testing code that uses `justbackoff` with jitter enabled, use `random.seed()` to ensure the "random" durations are deterministic for your test assertions.

## Reference documentation
- [justbackoff GitHub Repository](./references/github_com_alexferl_justbackoff.md)