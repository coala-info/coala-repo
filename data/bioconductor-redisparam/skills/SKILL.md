---
name: bioconductor-redisparam
description: RedisParam is a BiocParallel back-end that uses a Redis database to manage asynchronous communication between a manager and distributed workers. Use when user asks to perform parallel computing with resilient worker management, scale R tasks across independent containers or sessions, or manage job queues via a Redis server.
homepage: https://bioconductor.org/packages/release/bioc/html/RedisParam.html
---


# bioconductor-redisparam

## Overview

`RedisParam` is a `BiocParallel` back-end that uses a Redis database to manage communication between a manager (the main R session) and workers. Unlike standard socket or fork-based back-ends, `RedisParam` allows for asynchronous worker management, meaning workers can join or leave a job queue at any time. It is highly resilient to worker loss and data resets on the Redis server.

## Basic Usage

To use `RedisParam`, you must have a Redis server running. By default, it connects to `127.0.0.1:6379`.

### Single Session Workflow
In a single R session, you can initialize and use `RedisParam` just like `MulticoreParam` or `SnowParam`.

```r
library(RedisParam)
library(BiocParallel)

# Define the param with a specific number of workers
p <- RedisParam(workers = 5, jobname = "my_job")

# Use with standard BiocParallel functions
result <- bplapply(1:10, function(i) {
    Sys.sleep(1)
    i^2
}, BPPARAM = p)
```

### Independent Worker Workflow
This is the preferred method for cloud/container orchestration.

**1. Start the Worker(s):**
In one or more separate R sessions (or containers):
```r
library(RedisParam)
# is.worker = TRUE tells this session to listen for tasks
p <- RedisParam(jobname = "cloud_compute", is.worker = TRUE)
bpstart(p) 
```

**2. Start the Manager:**
In your main analysis session:
```r
library(RedisParam)
p <- RedisParam(jobname = "cloud_compute", is.worker = FALSE)

# Tasks are sent to the Redis queue and picked up by available workers
result <- bplapply(1:100, function(x) heavy_calc(x), BPPARAM = p)

# Optional: Stop all workers remotely when finished
rpstopall(p)
```

## Key Functions

- `RedisParam()`: Constructor for the parameter object. Key arguments:
    - `jobname`: Unique identifier for the job queue.
    - `is.worker`: Logical; TRUE for worker sessions, FALSE for the manager.
    - `hostname` / `port`: Connection details for the Redis server.
    - `password`: If the Redis server requires authentication.
- `bpstart()`: Starts the worker listener or initializes the manager connection.
- `rpstopall()`: Sends a termination signal to all workers attached to the specific `jobname`.
- `rpworkers()`: Returns the number of workers currently registered in the Redis queue.

## Best Practices and Tips

- **Job Names:** Always use a unique `jobname` if multiple users or processes are sharing the same Redis server to avoid task collisions.
- **Resilience:** If a worker dies, the manager can detect the missing task and resubmit it. If the Redis server loses data, the manager will fail the current job but the queue remains functional for new tasks.
- **Serialization:** Large objects used across all tasks should be handled carefully. `RedisParam` uses a "constant queue" to store data that does not vary across tasks to minimize network overhead.
- **Scaling:** You can add more workers (by starting new R sessions with `is.worker = TRUE`) even while a `bplapply` call is currently running.

## Reference documentation

- [RedisParam Developer Guide](./references/RedisParamDeveloperGuide.md)
- [RedisParam User Guide](./references/RedisParamUserGuide.md)