---
name: garli-mpi
description: This tool manages and executes the GARLI-MPI phylogenetic inference tool. Use when user asks to run GARLI-MPI for phylogenetic tree inference, configure GARLI-MPI parameters, interpret GARLI-MPI output, or troubleshoot GARLI-MPI execution.
homepage: https://anaconda.org/channels/bioconda/packages/garli-mpi/overview
---


# garli-mpi

yaml
name: garli-mpi
description: |
  Manages and executes the GARLI (Genetic Algorithm for Rooted Local Interleaving)
  phylogenetic inference tool, specifically its MPI-parallelized version.
  Use when Claude needs to perform phylogenetic analyses using GARLI-MPI for
  large datasets or complex evolutionary models where parallel processing is
  beneficial for speed and efficiency. This includes tasks such as:
  - Running GARLI-MPI for phylogenetic tree inference.
  - Configuring GARLI-MPI parameters for specific analyses.
  - Interpreting GARLI-MPI output files.
  - Troubleshooting common GARLI-MPI execution issues.
```
## Overview
This skill provides guidance for using GARLI-MPI, a powerful tool for phylogenetic inference that leverages the Message Passing Interface (MPI) for parallel execution. It is designed for users who need to construct evolutionary trees from molecular sequence data, especially when dealing with large datasets or computationally intensive analyses that benefit from parallel processing.

## Usage Instructions

### 1. Installation and Environment Setup

Ensure GARLI-MPI is correctly installed and configured in your environment. This typically involves having an MPI implementation (e.g., OpenMPI, MPICH) and the GARLI-MPI executables available in your system's PATH.

### 2. Basic Execution

The fundamental command structure for running GARLI-MPI involves specifying the input data file and the configuration file.

```bash
mpirun -np <number_of_processes> garli_mpi -p <configuration_file> -i <input_data_file>
```

- `-np <number_of_processes>`: Specifies the number of MPI processes to use. Adjust this based on your available cores and the dataset size.
- `garli_mpi`: The executable for the MPI-parallelized GARLI.
- `-p <configuration_file>`: Path to the GARLI configuration file (`.conf`). This file contains all the parameters for the phylogenetic analysis.
- `-i <input_data_file>`: Path to your sequence alignment data file (e.g., FASTA format).

### 3. Configuration File (`.conf`)

The configuration file is crucial for defining the analysis parameters. Key parameters include:

- **Model of Evolution**: Specify the substitution model (e.g., GTR, HKY, JC).
- **Rate Heterogeneity**: Options for gamma distribution (`rate_gamma_categories`, `rate_gamma_shape`).
- **Data Type**: Binary, DNA, RNA, protein.
- **Search Options**: Search algorithm, number of iterations, convergence criteria.
- **Output Options**: File names for trees, log files, etc.

**Example Configuration Snippet:**

```ini
# Model of Evolution
model = GTR
rate_gamma_categories = 4
rate_gamma_shape = 1.0

# Search Parameters
search_iterations = 100000
topology_search_type = NNIDown
branch_search_type = NNI

# Output Files
output_tree_file = my_tree.tre
output_log_file = garli.log
```

### 4. Input Data File Formats

GARLI-MPI typically accepts sequence data in FASTA format. Ensure your input file is correctly formatted with sequence headers starting with `>`.

### 5. Common CLI Patterns and Tips

- **Running with default parameters**: If you have a standard configuration file, you can often run GARLI-MPI with minimal arguments.
- **Monitoring progress**: Check the `output_log_file` for progress updates, convergence status, and potential errors.
- **Adjusting MPI processes**: Experiment with different `-np` values to find the optimal performance for your system and dataset. Too few processes may not utilize your hardware effectively, while too many can introduce communication overhead.
- **Parameter tuning**: For complex analyses, carefully tune model parameters, search iterations, and convergence criteria in the `.conf` file. Refer to the GARLI documentation for a comprehensive list of parameters.
- **Troubleshooting**: Common issues include incorrect file paths, malformed input data, incompatible configuration parameters, or insufficient MPI setup. The `garli.log` file is your primary resource for diagnosing problems.

### 6. Output Files

GARLI-MPI generates several output files, including:

- **Phylogenetic Tree File (`.tre`)**: Contains the inferred phylogenetic tree(s) in Newick format.
- **Log File (`.log`)**: Detailed information about the analysis, including parameters used, progress, and convergence statistics.
- **Best Likelihood Tree**: Often saved as `best_tree.tre` or similar, representing the tree with the highest likelihood found.

## Reference documentation
- [GARLI-MPI Overview](./references/anaconda_org_channels_bioconda_packages_garli-mpi_overview.md)