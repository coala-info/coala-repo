---
name: pyiron
description: pyiron is an integrated development environment (IDE) designed to simplify the complexity of computational materials science.
homepage: https://github.com/pyiron/pyiron
---

# pyiron

## Overview

pyiron is an integrated development environment (IDE) designed to simplify the complexity of computational materials science. It provides a unified Python interface to manage the entire simulation life cycle—from structure generation and job submission to data storage and analysis. Use this skill to automate repetitive simulation tasks, ensure reproducibility through its project-based management system, and scale calculations from single-job tests to massive high-throughput screenings.

## Core Workflow Patterns

### 1. Project Initialization and Configuration
Every pyiron task begins with a `Project` object, which handles the directory structure and data management.

```python
from pyiron import Project

# Initialize a project (creates a directory named 'my_simulation')
pr = Project('my_simulation')

# First-time configuration (run once in a new environment)
# pyiron.install() 
```

### 2. Atomic Structure Creation
pyiron integrates with the Atomic Simulation Environment (ASE) but provides its own factory methods for common lattices.

```python
# Create a BCC Iron structure
structure = pr.create_structure('Fe', 'bcc', 2.86)

# Visualize the structure (requires NGLview in Jupyter)
# structure.plot3d()
```

### 3. Job Management (LAMMPS Example)
Jobs are created through the project object. This ensures they are tracked in the project's database.

```python
# Create a LAMMPS job
job = pr.create_job(job_type=pr.job_type.Lammps, job_name='iron_relaxation')

# Assign the structure
job.structure = structure

# Select a potential (list available ones first)
# print(job.list_potentials())
job.potential = job.list_potentials()[0]

# Run the simulation
job.run()
```

### 4. Data Retrieval and Analysis
pyiron stores results in HDF5 files. You can access them directly through the job object after completion.

```python
# Access output data
energy = job['output/generic/energy_tot']
forces = job['output/generic/forces']

# View a summary of the job
job.status
```

## Best Practices

- **Project Hierarchy**: Use sub-projects to organize complex workflows (e.g., `pr_parent = Project('study'); pr_child = pr_parent.create_group('temp_300K')`).
- **Job Uniqueness**: Always provide unique `job_name` strings within a project to avoid overwriting data.
- **Potential Selection**: Use `job.list_potentials()` to verify the exact string required for the interatomic potential before assignment.
- **Interactive Protocols**: For complex feedback loops (like nudged elastic band or molecular dynamics), use pyiron's interactive wrappers to avoid the overhead of restarting the simulation engine for every step.

## Reference documentation
- [pyiron Repository Overview](./references/github_com_pyiron_pyiron.md)