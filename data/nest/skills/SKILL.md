---
name: nest
description: NEST is a specialized simulation environment designed for spiking neural network models of varying complexity, from simple integrate-and-fire neurons to detailed biophysical models.
homepage: http://www.nest-simulator.org/
---

# nest

## Overview
NEST is a specialized simulation environment designed for spiking neural network models of varying complexity, from simple integrate-and-fire neurons to detailed biophysical models. It is optimized for large-scale networks where the focus is on the dynamics and structure of the system rather than the detailed morphology of individual cells. The tool operates on a "virtual experiment" logic: you define the neural system, establish connections, attach measurement devices (like multimeters or spike detectors), and then simulate the time-evolution of the network.

## Installation
Install the NEST simulator via Bioconda:
```bash
conda install bioconda::nest
```

## Core Workflow (PyNEST)
The most common way to use NEST is through its Python interface, PyNEST.

### 1. Initialization and Node Creation
Nodes in NEST are either neurons, devices, or sub-networks.
```python
import nest

# Create neurons (e.g., 100 integrate-and-fire neurons)
neurons = nest.Create("iaf_psc_alpha", 100)

# Create a stimulation device
generator = nest.Create("poisson_generator", params={"rate": 50000.0})

# Create a recording device
multimeter = nest.Create("multimeter", params={"record_from": ["V_m"]})
```

### 2. Connecting Nodes
Connections define the flow of spikes. You can specify weights, delays, and specific synapse models.
```python
# Connect generator to neurons
nest.Connect(generator, neurons)

# Connect multimeter to neurons to record membrane potential
nest.Connect(multimeter, neurons)

# Connect neurons to each other with specific weights
nest.Connect(neurons, neurons, conn_spec="all_to_all", syn_spec={"weight": 20.0, "delay": 1.0})
```

### 3. Simulation and Data Retrieval
```python
# Run simulation for 1000ms
nest.Simulate(1000.0)

# Extract recorded data
events = nest.GetStatus(multimeter, "events")[0]
times = events["times"]
voltages = events["V_m"]
```

## Expert Tips and Best Practices
- **Model Selection**: Use `nest.Models()` to list all available neuron and synapse models. Common models include `iaf_psc_alpha` (standard IAF), `izhikevich` (phenomenological), and `aeif_cond_exp` (AdEx).
- **Status Manipulation**: Use `nest.GetStatus(nodes)` and `nest.SetStatus(nodes, params)` to inspect or modify parameters (e.g., threshold, capacity, or refractory period) at any point in the simulation.
- **Device Placement**: Always connect `multimeter` devices to the nodes you want to observe *before* running the simulation. For spike data, use the `spike_detector`.
- **Efficiency**: For large-scale simulations, NEST handles multi-threading and MPI communication internally. Ensure your script remains agnostic to the number of cores by using NEST's high-level connection routines.
- **Standalone Usage**: While PyNEST is preferred for scripting, the `nest` command-line tool can be used to execute SLI (Simulation Language Interpreter) scripts directly for legacy workflows.

## Reference documentation
- [NEST Overview](./references/anaconda_org_channels_bioconda_packages_nest_overview.md)
- [NEST Simulator Homepage](./references/www_nest-simulator_org_index.md)