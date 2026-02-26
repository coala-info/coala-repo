---
name: kid
description: Kids is a high-performance log aggregation system that uses a pub/sub pattern to collect and distribute real-time message streams. Use when user asks to start the kids daemon, subscribe to log topics, publish messages to a stream, or monitor system performance using the Redis protocol.
homepage: https://github.com/zhihu/kids
---


# kid

## Overview
"Kids Is Data Stream" (kids) is a high-performance log aggregation system designed for real-time message distribution. It adopts a pub/sub pattern modeled after Redis, allowing it to function as a bridge for log data across distributed systems. It is primarily used to collect, persist, and broadcast log messages to multiple subscribers simultaneously using a multithreaded architecture.

## Native Command Line Usage

### Starting the Service
The primary way to run the kids daemon is by specifying a configuration file.
```bash
kids -c /path/to/kids.conf
```

### Interaction via Redis Protocol
Since kids uses the Redis protocol, the standard `redis-cli` is the preferred tool for interacting with the stream. The default port used in many configurations is `3388`.

**Subscribing to Streams:**
Use `PSUBSCRIBE` to listen to specific topics or use wildcards for all topics.
```bash
redis-cli -p 3388 PSUBSCRIBE *
redis-cli -p 3388 PSUBSCRIBE logs.error.*
```

**Publishing Messages:**
Send log data to a specific topic using `PUBLISH`.
```bash
redis-cli -p 3388 PUBLISH kids.test.topic "Your log message here"
```

**Unsubscribing:**
Stop listening to patterns using `PUNSUBSCRIBE`.
```bash
redis-cli -p 3388 PUNSUBSCRIBE *
```

### Monitoring and Maintenance
Use the `info` command to check the health and performance of the kids instance.
```bash
redis-cli -p 3388 info
```
This provides critical metrics including:
- Traffic data (input/output rates)
- Memory usage of the internal queues
- Connected clients

### Configuration Management
- **Reloading:** You can reload the store configuration without restarting the service by sending a `SIGHUP` signal to the process.
  ```bash
  kill -SIGHUP <kids_pid>
  ```
- **Testing:** Use `make test` after building from source to ensure the environment is compatible.

## Expert Tips
- **Client Compatibility:** Because it follows the Redis protocol, you can use any standard Redis client library (Node.js, Python, Go) to build custom producers or consumers for the log stream.
- **Docker Deployment:** When running in Docker, ensure you map the port (usually `3388`) and volume-mount your custom configuration to `/etc/kids.conf`.
- **Build Requirements:** If compiling from source, ensure the environment has a C++11 compliant compiler (GCC 4.7+ or Clang).

## Reference documentation
- [Kids Main Repository](./references/github_com_zhihu_kids.md)
- [Commit History (SIGHUP and Feature Details)](./references/github_com_zhihu_kids_commits_master.md)