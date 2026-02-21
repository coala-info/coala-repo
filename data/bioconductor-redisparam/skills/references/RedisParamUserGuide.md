# Using RedisParam

Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*Martin.Morgan@RoswellPark.org

#### 25 December 2025

#### Abstract

RedisParam provides a BiocParallel ‘back-end’ for parallel
computation. RedisParam uses a Redis server to manage
communication between manager and workers. This offers a number
possibilities not available to other back-ends. For instance,
workers can be launched independently of the manager, including
part way through a parallel evaluation job. RedisParam is well-suited to
kubernetes and other cloud-based scenarios, in part because no special
network configuration is required for manager and worker communication.
RedisParam supports all BiocParallel features, including `bplapply()`,
`bpiterate()`, reproducible random number streams, and flexible job
scheduling.

#### Package

RedisParam 1.12.1

# Contents

* [1 Getting started](#getting-started)
* [2 Use](#use)
  + [2.1 Manager and workers from a single *R* session](#manager-and-workers-from-a-single-r-session)
  + [2.2 Independently-managed workers](#independently-managed-workers)
* [Session info](#session-info)

# 1 Getting started

RedisParam implements a [BiocParallel](https://bioconductor.org/packages/BiocParallel) backend using redis, rather
than sockets, for communication. It requires a redis server; see
`?RedisParam` for host and port specification. redis is a good
solution for cloud-based environments using a standard docker image. A
particular feature is that the number of workers can be scaled during
computation, for instance in response to kubernetes auto-scaling.

# 2 Use

Ensure that a redis server is running, e.g., from the command line

```
$ redis-server
```

## 2.1 Manager and workers from a single *R* session

On a single computer, in *R*, load and use the RedisParam package in
the same way as other BiocParallel backends, e.g.,

```
library(RedisParam)
p <- RedisParam(workers = 5)
result <- bplapply(1:7, function(i) Sys.getpid(), BPPARAM = p)
table(unlist(result))
```

## 2.2 Independently-managed workers

For independently managed workers, start workers in separate processes, e.g.,

```
Sys.getpid()
library(RedisParam)
p <- RedisParam(jobname = "demo", is.worker = TRUE)
bpstart(p)
```

Start and use the manager in a separate process. Be sure to use the
same `jobname =`.

```
Sys.getpid()            # e.g., 8563
library(RedisParam)
p <- RedisParam(jobname = 'demo', is.worker = FALSE)
result <- bplapply(1:7, function(i) Sys.getpid(), BPPARAM = p)
unique(unlist(result)) # e.g., 9677
```

Independently started workers can be terminated from the manager

```
rpstopall(p)
```

# Session info

This version of the vignette was built on 2025-12-25 with the
following software package versions: