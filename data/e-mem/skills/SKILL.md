---
name: e-mem
description: EverMemOS (e-mem) is a specialized memory operating system designed to give AI agents a persistent, evolving understanding of users and past interactions.
homepage: https://github.com/EverMind-AI/EverMemOS
---

# e-mem

## Overview
EverMemOS (e-mem) is a specialized memory operating system designed to give AI agents a persistent, evolving understanding of users and past interactions. Unlike simple vector databases, e-mem performs structured extraction and consolidation, turning raw conversation logs into organized "episodes" and "profiles." Use this skill to manage the lifecycle of agent memory—from initial encoding of messages to complex hybrid retrieval for reasoning tasks.

## Core Workflows

### Server Management
The e-mem system runs as a REST API service. Ensure the infrastructure is active before attempting memory operations.

*   **Start Services**: Use Docker to spin up the required backend (Milvus, Elasticsearch, MongoDB, Redis).
    ```bash
    docker compose up -d
    ```
*   **Launch API Server**: Run the server using the `uv` package manager.
    ```bash
    uv run python src/run.py
    ```
*   **Health Check**: Verify the service is responsive.
    ```bash
    curl http://localhost:1995/health
    ```

### Storing Memories
To build a long-term memory, send structured message data to the `/memories` endpoint.

*   **Pattern**: Always include a unique `message_id` and a valid ISO 8601 `create_time`.
*   **Example**:
    ```bash
    curl -X POST http://localhost:1995/api/v1/memories \
    -H "Content-Type: application/json" \
    -d '{
      "message_id": "msg_001",
      "create_time": "2025-02-01T10:00:00+00:00",
      "sender": "user_123",
      "content": "I prefer Python for data science but use Rust for systems."
    }'
    ```

### Retrieving Context
Use the search API to pull relevant past experiences into the agent's current context window.

*   **Hybrid Retrieval**: For the best balance of keyword matching and semantic meaning, set `retrieve_method` to `hybrid`.
*   **Memory Types**: Filter by `episodic_memory` for specific events or `user_profile` for extracted preferences.
*   **Example**:
    ```bash
    curl -X GET http://localhost:1995/api/v1/memories/search \
    -H "Content-Type: application/json" \
    -d '{
      "query": "What are the user's programming preferences?",
      "user_id": "user_123",
      "memory_types": ["episodic_memory"],
      "retrieve_method": "hybrid"
    }'
    ```

## Expert Tips & Best Practices

*   **Dependency Management**: Always use `uv sync` to ensure the environment matches the lockfile, especially when running evaluation scripts.
*   **Bootstrap Demos**: Use the bootstrap utility to run internal scripts without manual path configuration:
    ```bash
    uv run python src/bootstrap.py demo/chat_with_memory.py
    ```
*   **Benchmark Verification**: If memory performance seems degraded, run a smoke test on the LoCoMo dataset to verify reasoning accuracy:
    ```bash
    uv run python -m evaluation.cli --dataset locomo --system evermemos --smoke
    ```
*   **Environment Configuration**: Ensure `.env` is correctly populated with `LLM_API_KEY` (for memory extraction/encoding) and `VECTORIZE_API_KEY` (for embeddings) before starting the server.

## Reference documentation
- [EverMemOS Overview](./references/github_com_EverMind-AI_EverMemOS.md)
- [Security Policy](./references/github_com_EverMind-AI_EverMemOS_security.md)