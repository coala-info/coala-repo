---
name: axiome
description: Axiomeer acts as a universal marketplace for AI agents, providing a production-ready infrastructure to discover and execute specialized tools.
homepage: https://github.com/ujjwalredd/Axiomeer
---

# axiome

## Overview
Axiomeer acts as a universal marketplace for AI agents, providing a production-ready infrastructure to discover and execute specialized tools. Instead of hardcoding integrations, agents can use this skill to semantically search for the best-fit RAG systems, datasets, or APIs based on a specific task description. It streamlines the transition from a general-purpose agent to a specialized one by providing on-demand access to processed knowledge bases and external service integrations.

## Core Workflows

### Authentication and Setup
Before interacting with the marketplace, you must establish a secure session and generate an agent-specific API key.

1.  **Sign Up**: Register a new agent account.
    `curl -X POST http://localhost:8000/auth/signup -H "Content-Type: application/json" -d '{"email": "agent@example.com", "username": "agent_01", "password": "password"}'`
2.  **Login**: Obtain a JWT access token.
    `curl -X POST http://localhost:8000/auth/login -H "Content-Type: application/json" -d '{"email": "agent@example.com", "password": "password"}'`
3.  **Generate API Key**: Use the JWT to create a persistent `axm_` key for the agent.
    `curl -X POST http://localhost:8000/auth/api-keys -H "Authorization: Bearer <token>" -d '{"name": "Production Key"}'`

### Intelligent Product Discovery
Use the `/shop` endpoint to find tools matching a natural language requirement. Axiomeer uses FAISS semantic search and LLM-based capability extraction to rank results.

*   **Pattern**: Send a task description to receive ranked recommendations.
*   **Command**:
    `curl -X POST http://localhost:8000/shop -H "X-API-Key: <axm_key>" -H "Content-Type: application/json" -d '{"task": "I need to analyze customer sentiment from social media", "auto_extract_capabilities": true, "max_results": 3}'`

### Executing Marketplace Products
Once a product (`app_id`) is discovered, execute it directly through the marketplace gateway.

*   **Pattern**: Provide the `app_id` and the specific task parameters.
*   **Command**:
    `curl -X POST http://localhost:8000/execute -H "X-API-Key: <axm_key>" -H "Content-Type: application/json" -d '{"app_id": "wikipedia_search", "task": "Find information about artificial intelligence", "inputs": {}, "require_citations": true}'`

## Expert Tips
*   **Health Checks**: Always verify the marketplace status before initiating discovery: `curl http://localhost:8000/health`.
*   **Semantic Precision**: When using the `/shop` endpoint, be specific about the *output* you need (e.g., "JSON formatted financial data") to improve the FAISS embedding match.
*   **Capability Extraction**: Set `auto_extract_capabilities: true` to allow the internal LLM (phi3.5) to parse complex requests into discrete technical requirements.
*   **Result Limits**: Use `max_results` to limit context window bloat when the agent is processing multiple potential tool matches.

## Reference documentation
- [Axiomeer Main Repository](./references/github_com_ujjwalredd_Axiomeer.md)