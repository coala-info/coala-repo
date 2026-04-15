---
name: multiprocess
description: The multiprocess messaging tool transforms Nginx into a scalable pub/sub server for distributing live data between publishers and subscribers. Use when user asks to build chat applications, implement live notifications, configure real-time dashboards, or scale message brokering with Redis.
homepage: https://github.com/slact/nchan
metadata:
  docker_image: "quay.io/biocontainers/multiprocess:0.70.4--py35_0"
---

# multiprocess

## Overview
The multiprocess messaging tool (Nchan) is a scalable pub/sub server integrated directly into Nginx. It allows you to transform Nginx into a powerful message broker that distributes live data from publishers to subscribers across multiple worker processes. It is ideal for building chat applications, live notifications, or real-time dashboards where high concurrency and low latency are required. It supports various storage backends, including local shared memory for speed and Redis for horizontal scaling and persistence.

## Core Configuration Patterns

To implement a basic pub/sub setup, define publisher and subscriber locations within your Nginx server block.

### Basic Pub/Sub Setup
```nginx
http {
    server {
        listen 80;

        # Publisher endpoint: Send messages here
        location = /pub {
            nchan_publisher;
            nchan_channel_id $arg_id; # Uses ?id=channel_name from URL
        }

        # Subscriber endpoint: Receive messages here
        location = /sub {
            nchan_subscriber;
            nchan_channel_id $arg_id;
        }
    }
}
```

### Using Redis for Scaling
For horizontal scaling across multiple Nginx instances, configure a Redis upstream.
```nginx
http {
    nchan_redis_server redis://127.0.0.1:6379;

    server {
        location = /sub {
            nchan_subscriber;
            nchan_channel_id $arg_id;
            nchan_use_redis on;
        }
    }
}
```

## Command Line Usage & API

### Publishing Messages
Messages are typically published via HTTP POST requests. You can use `curl` to send data to a specific channel.

```bash
# Publish a simple text message
curl -X POST -d "Hello World" "http://localhost/pub?id=my_channel"

# Publish JSON data
curl -X POST -H "Content-Type: application/json" -d '{"status": "ok"}' "http://localhost/pub?id=my_channel"
```

### Subscribing via CLI
You can test subscriptions using command-line tools that support long-polling or WebSockets.

```bash
# Subscribe via Long-Polling
curl "http://localhost/sub?id=my_channel"

# Subscribe via EventSource (SSE)
curl -N -H "Accept: text/event-stream" "http://localhost/sub?id=my_channel"
```

## Expert Tips & Best Practices

- **Channel Security**: Do not expose your `/pub` location to the public internet without authentication (e.g., `allow/deny` rules or `auth_request`).
- **Message Buffering**: Use `nchan_message_buffer_length` and `nchan_message_timeout` to control how many messages are stored for subscribers who connect late.
- **Shared Memory**: Ensure your `nchan_shared_memory_size` is large enough to hold your message buffers, especially if not using Redis.
- **Subscriber Limits**: Use `nchan_group_max_subscribers` to prevent a single channel group from consuming all server resources.
- **Monitoring**: Use the `nchan_stub_status` directive in a protected location to get real-time statistics on channels, messages, and subscribers.

## Reference documentation
- [Nchan GitHub Repository](./references/github_com_slact_nchan.md)