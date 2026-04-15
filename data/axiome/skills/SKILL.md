---
name: axiome
description: Axiome provides a unified API gateway and marketplace that translates natural language requests into executable calls across various services. Use when user asks to search for specific API capabilities, execute tasks through integrated agents, export tool schemas for LLMs, or run multi-step workflows.
homepage: https://github.com/ujjwalredd/Axiomeer
metadata:
  docker_image: "quay.io/biocontainers/axiome:2.0.4--py27_0"
---

# axiome

## Overview
Axiomeer serves as a universal marketplace and unified API gateway for over 91 different services, including weather, finance, search, and translation. It leverages semantic search (FAISS) to translate plain-English requests into executable API calls. The system handles the complexity of provider ranking, retry logic, and cost tracking, allowing agents to perform complex tasks with minimal code.

## Core Usage Patterns

### Semantic Discovery
To find the right API for a specific task, use the semantic search endpoint. This returns ranked recommendations based on capability, relevance, trust, and latency.

```bash
# Search for an API using natural language
curl -X POST http://localhost:8000/v1/shop \
  -H "Content-Type: application/json" \
  -d '{"task": "translate text to Spanish"}'
```

### Executing Tasks
Once an API is identified (e.g., `realtime_weather_agent`), execute it by providing the task and necessary input parameters.

```bash
# Execute a specific agent capability
curl -X POST http://localhost:8000/execute \
  -H "Content-Type: application/json" \
  -d '{
    "app_id": "realtime_weather_agent",
    "task": "weather in NYC",
    "inputs": {"lat": 40.7, "lon": -74.0}
  }'
```

### LLM Integration (Function Calling)
Axiomeer can export its entire catalog of 91+ APIs as structured tool schemas compatible with major LLM providers.

```bash
# Export schemas for OpenAI function calling
curl "http://localhost:8000/v1/tools/schemas?format=openai"

# Export schemas for Anthropic tool use
curl "http://localhost:8000/v1/tools/schemas?format=anthropic"
```

### Workflow Chaining
For complex operations requiring multiple steps, use the workflow endpoint to pass data between sequential API calls.

```bash
# Execute a multi-step workflow
curl -X POST http://localhost:8000/execute/workflow \
  -H "Content-Type: application/json" \
  -d '{
    "steps": [
      {"app_id": "search_agent", "task": "find latest news on AI"},
      {"app_id": "translate_agent", "task": "translate results to French"}
    ]
  }'
```

## Best Practices
- **Health Checks**: Always verify the service status at `GET /health` before initiating heavy workflows, as the semantic search model may take time to load on initial startup.
- **Provider Fallback**: Axiomeer automatically handles provider failures. If a primary provider fails, the system retries with the next-ranked provider in the marketplace.
- **Streaming**: For long-running tasks or multi-step chains, use `POST /execute/stream` to receive real-time progress events via Server-Sent Events (SSE).
- **Cost Management**: Monitor the `cost_est_usd` field in execution logs to track real-time API expenditure across different providers.



## Subcommands

| Command | Description |
|---------|-------------|
| axiome process | Axiome process command for data processing |
| axiome utility | Generates a file mapping template or copies AXIOME sample data into the current directory |

## Reference documentation
- [Axiomeer README](./references/github_com_ujjwalredd_Axiomeer_blob_main_README.md)
- [Environment Configuration](./references/github_com_ujjwalredd_Axiomeer_blob_main_.env.example.md)
- [Docker Deployment](./references/github_com_ujjwalredd_Axiomeer_blob_main_Dockerfile.md)