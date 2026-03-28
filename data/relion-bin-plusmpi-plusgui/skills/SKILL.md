---
name: relion-bin-plusmpi-plusgui
description: RELION is a software suite for cryo-electron microscopy structure determination that uses Bayesian optimization for 2D and 3D image processing. Use when user asks to perform movie alignment, estimate CTF, pick particles, perform 2D or 3D classification, or execute high-resolution 3D refinement.
homepage: https://github.com/3dem/relion
---


# relion-bin-plusmpi-plusgui

## Overview

RELION (REgularised LIkelihood OptimisatioN) is a specialized software suite for cryo-electron microscopy (cryo-EM) structure determination. It utilizes a Bayesian approach to refine 3D reconstructions and 2D class averages. This skill enables the execution of the full RELION pipeline—from initial movie alignment and CTF estimation to particle picking, classification, and high-resolution 3D refinement. It is optimized for environments requiring distributed-memory parallelization (MPI) and provides the necessary binaries for both command-line automation and GUI-based interaction.

## Common CLI Patterns

RELION commands typically follow the pattern `relion_<module> [options]`. For parallel execution, use the `_mpi` version of the binary.

### Parallel Execution with MPI
To run a refinement or classification job across multiple CPU cores or nodes:
```bash
mpirun -np 5 relion_run_refine_mpi --i particles.star --ref reference.mrc --o output_dir --gpu "" --j 4
```
*   `-np`: Total number of MPI ranks.
*   `--j`: Number of threads per MPI rank (useful for memory-intensive steps).

### 2D Classification
To perform 2D class averaging on a set of extracted particles:
```bash
relion_run_2d_class --i particles.star --o class2d/run1 --iter 25 --nr_classes 50 --tau2_fudge 2 --particle_diameter 250 --gpu
```

### 3D Auto-Refinement
For high-resolution 3D reconstruction:
```bash
mpirun -np 3 relion_run_refine_mpi --i particles.star --ref initial_model.mrc --o refine3d/run1 --auto_refine --split_random_halves --gpu
```

### CTF Estimation
To estimate the Contrast Transfer Function using CTFFIND4:
```bash
relion_run_ctffind --i micrographs.star --o ctf_estimation/ --ctffind_exe /path/to/ctffind4 --box 512 --min_res 30 --max_res 5
```

## Expert Tips and Best Practices

*   **Project Structure**: Always run RELION commands from the root of your project directory. RELION uses relative paths in `.star` files; moving the project root will break these links.
*   **STAR Files**: These are the primary metadata files. Use `relion_star_printtable` or `relion_star_handler` to inspect or manipulate them via the command line.
*   **Memory Management**: If you encounter "Out of Memory" (OOM) errors, decrease the number of MPI ranks (`-np`) and increase the number of threads per rank (`--j`).
*   **GPU Acceleration**: Use the `--gpu` flag to specify which devices to use (e.g., `--gpu 0:1:2:3`). If no ID is provided, RELION will attempt to auto-allocate.
*   **Symmetry**: When performing 3D refinement, always specify the point-group symmetry (e.g., `--sym C1`, `--sym D7`, or `--sym I`) to improve resolution and signal-to-noise ratio if the specimen's symmetry is known.
*   **Fudge Factors**: In 2D and 3D classification, the `--tau2_fudge` parameter (default 1) can be increased (e.g., to 2 or 4) to drive the classification toward higher-resolution features, though this increases the risk of over-fitting.



## Subcommands

| Command | Description |
|---------|-------------|
| relion_preprocess | Provide either --o or --operate_on |
| relion_refine_mpi | RELION MPI setup |

## Reference documentation

- [RELION 5.0 README](./references/github_com_3dem_relion_blob_master_README.md)
- [RELION Documentation Home](./references/relion_readthedocs_io_en_latest.md)
- [RELION Installation Guide](./references/relion_readthedocs_io_en_latest_Installation.html.md)