---
name: stress-ng
description: `stress-ng` is a comprehensive tool designed to exercise a computer system's various physical subsystems and OS kernel interfaces.
homepage: https://github.com/ColinIanKing/stress-ng
---

# stress-ng

## Overview

`stress-ng` is a comprehensive tool designed to exercise a computer system's various physical subsystems and OS kernel interfaces. It features over 370 specialized stress tests, including 100+ CPU-specific tests and dozens of virtual memory and filesystem stressors. While it can measure throughput (bogo-ops), its primary purpose is to force a system to work hard to uncover hardware flaws, thermal overruns, or race conditions that only appear under heavy contention.

## Common CLI Patterns

### CPU Stressing
Exercise processors using various methods (integer, floating point, bit manipulation).
- **Basic CPU load**: `stress-ng --cpu 4 --timeout 60s` (Stresses 4 CPUs for 60 seconds)
- **Specific CPU method**: `stress-ng --cpu 2 --cpu-method matrixprod`
- **Load all online CPUs**: `stress-ng --cpu 0`

### Memory and Cache Stressing
Test virtual memory stability and cache coherency.
- **Virtual Memory (VM)**: `stress-ng --vm 2 --vm-bytes 1G` (Starts 2 workers spinning on 1GB of RAM each)
- **Aggressive VM testing**: `stress-ng --vm 2 --vm-keep` (Prevents unmapping/remapping to maintain constant pressure)
- **Cache stressing**: `stress-ng --cache 1`

### I/O and Filesystem Stressing
Thrash disk I/O and filesystem metadata operations.
- **Generic I/O**: `stress-ng --io 4`
- **Aggressive Drive Stress**: `stress-ng --hdd 2 --hdd-opts direct`
- **Filesystem operations**: `stress-ng --vfork 10` (Rapidly creates/destroys processes)

### System-Wide Stress
- **Run all stressors**: `stress-ng --all 1` (Runs one instance of every available stressor)
- **Sequential testing**: `stress-ng --seq 0 -t 10m` (Runs every stressor one by one for 10 minutes total)

## Expert Tips

- **Root Privileges**: Running as root allows `stress-ng` to adjust Out-Of-Memory (OOM) settings on Linux, making stressors "unkillable" during extreme memory pressure. It also enables `ionice` class adjustments.
- **Thermal Caution**: This tool is designed to generate significant heat. On systems with poor cooling, it can trigger thermal throttling or emergency shutdowns. Always monitor system temperatures when running long-duration tests.
- **Performance Metrics**: Use `--metrics-brief` to output "bogo-ops" (fake operations per second). This is useful for comparing performance across different kernel versions or hardware configurations, though it is not a precise benchmark.
- **Verification**: Use the `--verify` flag to ensure that the data being processed (in memory or on disk) is not being corrupted during the stress test.
- **Excluding Stressors**: If a specific test causes an immediate crash or is irrelevant, exclude it using `-x`: `stress-ng --all 1 -x numa,hdd`.

## Reference documentation

- [stress-ng README](./references/github_com_ColinIanKing_stress-ng.md)