---
name: pytest-xdist
description: pytest-xdist parallelizes test execution across multiple CPU cores or worker processes to speed up slow test suites. Use when user asks to run tests in parallel, distribute tests across multiple CPUs, or use a file-watching mode to re-run failing tests.
homepage: https://github.com/pytest-dev/pytest-xdist
metadata:
  docker_image: "quay.io/biocontainers/pytest-xdist:1.14--py36_0"
---

# pytest-xdist

## Overview

pytest-xdist is a core plugin for the pytest ecosystem designed to solve the bottleneck of slow test suites. It transforms a sequential test run into a parallelized operation by spawning multiple worker processes. Beyond simple CPU distribution, it provides sophisticated scheduling mechanisms to ensure that tests sharing expensive resources or fixtures are grouped together, preventing race conditions while maximizing throughput.

## Common CLI Patterns

### Basic Parallelization
The most frequent use case is distributing tests across local CPU cores.
- `pytest -n auto`: Automatically detects the number of available CPUs and spawns a corresponding number of workers.
- `pytest -n 4`: Spawns exactly 4 worker processes.
- `pytest -n 0`: Disables xdist (useful for debugging without changing configuration files).

### Distribution Algorithms (`--dist`)
Control how tests are assigned to workers:
- `--dist load`: (Default) Sends individual tests to the next available worker. Best for independent tests.
- `--dist loadscope`: Groups tests by module (for functions) or by class (for methods). Use this when tests within a module share expensive setup that shouldn't be repeated across workers.
- `--dist loadgroup`: Groups tests marked with `@pytest.mark.xdist_group(name="group_name")`. All tests in the same group will run sequentially on a single worker.
- `--dist loadfile`: Ensures all tests within a single file are executed by the same worker.

### Continuous Testing
- `pytest --looponfail`: Enters a file-watching mode. It runs the suite, then waits for file changes to re-run only the failing tests, providing a rapid feedback loop.

## Expert Tips and Best Practices

### Handling Shared Resources
Since each worker is a separate process, they do not share memory.
- **Database Isolation**: Use the `PYTEST_XDIST_WORKER` environment variable (which contains values like `gw0`, `gw1`) to create unique database names or port offsets for each worker.
- **Session Fixtures**: Be aware that `session`-scoped fixtures are executed once *per worker process*. To perform a true one-time setup across the entire distributed run, use a file-based lock or the `tmp_path_factory` to coordinate between workers.

### Logging and Output
- **Worker IDs**: If you need to debug which worker ran a specific test, access the `worker_id` fixture or check the `PYTEST_XDIST_WORKER` environment variable.
- **CLI Progress**: Use `--log-cli-level` to control the verbosity of logs coming from worker processes to the main controller.

### Performance Tuning
- **Overhead**: Parallelization has a startup cost. For suites that run in under 5-10 seconds, xdist might actually increase total runtime.
- **Memory Constraints**: Spawning "auto" workers on a machine with many cores but low RAM can lead to OOM (Out of Memory) errors. In memory-intensive suites, prefer a fixed number of workers (e.g., `-n 2`).

## Reference documentation
- [Main README and Usage](./references/github_com_pytest-dev_pytest-xdist.md)
- [Community Discussions on Scheduling and Logging](./references/github_com_pytest-dev_pytest-xdist_discussions.md)
- [Issue Tracker for CPU Count Handling](./references/github_com_pytest-dev_pytest-xdist_issues.md)