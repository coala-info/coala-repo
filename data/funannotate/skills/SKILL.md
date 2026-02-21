---
name: funannotate
description: `funannotate` is a specialized pipeline designed to automate the structural and functional annotation of eukaryotic genomes.
homepage: https://github.com/nextgenusfs/funannotate
---

# funannotate

## Overview
`funannotate` is a specialized pipeline designed to automate the structural and functional annotation of eukaryotic genomes. While originally built for fungi, its modular architecture is effective for a wide range of eukaryotes. The tool integrates various gene prediction algorithms, evidence-based training (using RNA-seq or proteins), and functional assignment into a cohesive workflow. It handles the transition from a raw assembly to a fully annotated genome, including the generation of NCBI-compliant submission files.

## Installation and Setup
The most reliable way to manage the complex dependency tree of `funannotate` is via Conda or Docker.

*   **Conda Installation:**
    ```bash
    conda create -n funannotate "python>=3.6,<3.9" funannotate
    ```
    *Note: Use `mamba` instead of `conda` for significantly faster environment resolution.*

*   **Database Initialization:**
    Before running predictions, you must download and format the required databases.
    ```bash
    funannotate setup -i
    ```

*   **Docker Usage:**
    If using Docker, use the provided wrapper script to handle volume bindings and user permissions automatically.
    ```bash
    wget -O funannotate-docker https://raw.githubusercontent.com/nextgenusfs/funannotate/master/funannotate-docker
    chmod +x funannotate-docker
    ./funannotate-docker test -t predict --cpus 12
    ```

## Common CLI Patterns

### 1. Testing the Installation
Always verify the environment before starting a long-running annotation.
```bash
funannotate test -t predict --cpus 8
```

### 2. Gene Prediction
The `predict` command is the core of the structural annotation. It requires a masked genome and species information.
```bash
funannotate predict -i genome_masked.fasta -o output_dir -s "Genus species" --cpus 16
```

### 3. Functional Annotation
After gene models are generated, use `annotate` to assign functions based on InterProScan, EggNog, and other databases.
```bash
funannotate annotate -i output_dir --cpus 12
```

## Expert Tips and Best Practices

*   **GeneMark Licensing:** GeneMark-ES/ET cannot be distributed via Conda/Docker due to licensing. You must install it manually and set the environment variable:
    ```bash
    export GENEMARK_PATH=/path/to/gmes_petap/
    ```
    Ensure all Perl scripts in the GeneMark directory use `#!/usr/bin/env perl` in their shebang lines.

*   **NCBI Compliance:** Use the `funannotate clean` and `funannotate sort` commands on your raw assembly before prediction. This removes small contigs and renames headers to meet NCBI's strict requirements (e.g., no headers longer than 31 characters).

*   **PASA and MySQL:** If using PASA for transcript alignment, ensure your MySQL/MariaDB service is running and accessible. Connection issues are a common cause of failure in the `train` and `update` steps.

*   **Memory Management:** Annotation is resource-intensive. For large genomes, ensure you provide sufficient threads via `--cpus` and monitor RAM usage, especially during the `diamond` and `blast` stages of functional annotation.

*   **Handling SSL Errors:** If `setupDB.py` fails to download databases (like dbCAN), it may be due to SSL certificate issues on the source server. Check for updated URLs in the latest GitHub commits if downloads consistently fail.

## Reference documentation
- [funannotate GitHub Repository](./references/github_com_nextgenusfs_funannotate.md)
- [Bioconda funannotate Overview](./references/anaconda_org_channels_bioconda_packages_funannotate_overview.md)