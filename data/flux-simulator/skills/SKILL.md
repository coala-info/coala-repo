---
name: flux-simulator
description: FluxSim is a Docker-based simulation environment for experimenting with DNS and HTTP traffic patterns across various network topologies. Use when user asks to create fast-flux networks, deploy load balancers or CDNs, tune DNS rotation settings, and monitor network behavior through real-time dashboards.
homepage: https://github.com/logstr/Fluxsim
metadata:
  docker_image: "quay.io/biocontainers/flux-simulator:1.2.1--1"
---

# flux-simulator

## Overview
FluxSim is a Docker-based simulation environment designed for security researchers and network engineers to experiment with DNS and HTTP traffic patterns. It allows for the rapid deployment of various network topologies—such as fast-flux networks, Layer-7 load balancers, and Content Delivery Networks (CDNs)—and provides a comprehensive monitoring pipeline (Prometheus, Grafana, Redpanda) to observe network behavior in real-time.

## Core CLI Workflow
The simulator operates through a specialized REPL. Start the environment by running `fluxsim` in your terminal.

### Network Management
- **Create Topologies**: Use `add_flux_network <name>`, `add_lb_network <name>`, or `add_cdn_network <name>` to initialize a specific architecture.
- **Deployment**: Run `deploy` to spin up the Docker Compose stack.
- **Teardown**: Use `stop` to halt services or `remove_network <name>` to delete a configuration.
- **Inspection**: Use `status` to view the current state of all managed networks and subnets.

### Tuning and Scaling
- **Fast-Flux Tuning**: 
    - `set_flux_n <name> <count>`: Set the number of proxy agents.
    - `set_flux_interval <name> <seconds>`: Define the DNS rotation frequency.
    - `set_ttl <name> <seconds>`: Set the DNS Time-to-Live.
- **Load Balancer Tuning**:
    - `set_worker_n <name> <count>`: Scale the backend worker pool.
    - `set_lb_algo <name> <algorithm>`: Change the balancing logic (e.g., round-robin).
- **Live Operations**: You can scale networks without a full restart using commands like `lb_add_worker <name>`, `flux_add_agent <name>`, or `cdn_add_edge <name>`.

## Client Access and Testing
- **Headless Testing**: Use `client_browse <hostname>` to perform a text-based HTTP request from within the test client container.
- **GUI Access**: Run `desktop_start` to launch a noVNC-based desktop environment at http://localhost:8081 (Credentials: abc/abc).
- **Host-Side Queries**: Every BIND server maps to the host starting at port 5300. Test lookups directly from your host machine:
    - `dig @127.0.0.1 -p 5300 <your-sim-domain>`

## Monitoring and Data
- **Dashboards**: Access Grafana at http://localhost:3000 (admin/fluxlab) to view DNS query logs and agent health.
- **Database**: Use Adminer at http://localhost:8080 to browse the Postgres tables (`probe_events` and `signal_events`) populated by the ingestor.
- **Metrics**: The `fluxlab_exporter` combines runtime health with ingested events for Prometheus scraping.

## Expert Tips
- **Subnet Management**: FluxSim automatically allocates subnets starting at 172.60.0.0/24. Ensure these do not conflict with existing local Docker networks.
- **Registry Sync**: All CLI commands mutate `monitoring/registry.json`. If the exporter seems out of sync, verify this file's contents.
- **Customization**: To change core behavior, modify the BIND templates in `dns_config/` or the Nginx templates in `nginx_configs/` before running `deploy`.

## Reference documentation
- [FluxSim Main Documentation](./references/github_com_logstr_Fluxsim.md)