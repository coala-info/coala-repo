---
name: coreprofiler
description: "CoreProfiler generates core genome multilocus sequence types (cgMLSTs) for bacterial isolates. Use when user asks to perform cgMLST analysis, generate cgMLST profiles, compare bacterial strains, or analyze population structures."
homepage: https://gitlab.com/ifb-elixirfr/abromics
---


# coreprofiler

yaml
name: coreprofiler
description: CoreProfiler, a robust and integrable cgMLST software for microbial typing. Use when Claude needs to perform cgMLST analysis, including generating core genome multilocus sequence types (cgMLSTs) for bacterial isolates, comparing strains, and analyzing population structures. This skill is particularly useful for researchers in microbial genomics, epidemiology, and public health.
---
## Overview

CoreProfiler is a powerful command-line tool designed for robust and integrable cgMLST (core genome multilocus sequence typing) analysis. It enables the determination of cgMLST profiles for bacterial isolates, facilitating strain comparison, population structure analysis, and epidemiological investigations. This skill provides guidance on using CoreProfiler's command-line interface for these tasks.

## Usage Instructions

CoreProfiler is typically installed via Conda. Once installed, it can be invoked from the command line.

### Basic Workflow: Generating cgMLST Profiles

The primary function of CoreProfiler is to generate cgMLST profiles from input sequence data.

**1. Prepare Input Data:**
   - Ensure your input data consists of assembled genomes or contigs for each isolate.
   - The tool expects input in FASTA format.

**2. Run CoreProfiler:**
   The general command structure involves specifying the input directory and the output directory.

   ```bash
   coreprofiler --input <input_directory> --output <output_directory>
   ```

   - `<input_directory>`: Path to the directory containing your FASTA files (one per isolate).
   - `<output_directory>`: Path to the directory where CoreProfiler will save its results.

**3. Interpreting Output:**
   CoreProfiler will generate several output files within the specified output directory. Key files include:
   - `cgmlst.tsv`: A tab-separated file containing the cgMLST profiles for each isolate. This is the primary file for downstream analysis.
   - `summary.txt`: A summary of the analysis, including the number of isolates processed and potential issues encountered.

### Advanced Usage and Options

CoreProfiler offers various options to customize the analysis. Consult the official documentation for a comprehensive list. Some common parameters include:

- `--scheme <scheme_file>`: Specify a custom cgMLST scheme file. This is crucial if you are not using a default scheme.
- `--threads <num_threads>`: Set the number of CPU threads to use for the analysis, which can significantly speed up processing for large datasets.
- `--min_coverage <coverage>`: Define the minimum coverage required for a locus to be considered present.
- `--min_identity <identity>`: Set the minimum identity threshold for allele calling.

**Example with custom scheme and threads:**

```bash
coreprofiler --input ./genomes --output ./results --scheme ./my_custom_scheme.txt --threads 8
```

### Best Practices and Tips

- **Organize your input data:** Place all FASTA files for the isolates you want to analyze into a single, dedicated input directory.
- **Use a custom scheme when necessary:** If your research involves specific bacterial species or requires a particular set of cgMLST loci, ensure you have a correctly formatted scheme file and specify it using the `--scheme` option.
- **Monitor output:** Always check the `summary.txt` file for any warnings or errors that might indicate issues with your input data or the analysis process.
- **Leverage multi-threading:** For large-scale analyses, utilize the `--threads` option to reduce computation time.
- **Understand allele calling:** Be aware of the `--min_coverage` and `--min_identity` parameters, as they directly influence how alleles are called and can impact the accuracy of your typing results.

## Reference documentation

- [CoreProfiler Documentation](https://gitlab.com/ifb-elixirfr/abromics/coreprofiler/-/blob/main/docs/build/html/index.html)