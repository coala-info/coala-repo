---
name: diseasemodulediscovery
description: This pipeline identifies disease modules by analyzing the local neighborhood of seed genes within interactome networks using algorithms like DOMINO and DIAMOnD, producing prioritized drug targets and functional reports. Use when characterizing molecular mechanisms of diseases or generating drug repurposing hypotheses from a set of disease-associated proteins and a protein-protein interaction network.
homepage: https://github.com/nf-core/diseasemodulediscovery
---

## Overview
nf-core/diseasemodulediscovery is a bioinformatics pipeline designed for network medicine hypothesis generation. It identifies active disease modules—clusters of proteins or genes closely related to a disease—by mapping user-provided "seed" genes onto a protein-protein interaction (PPI) network. By characterizing these local neighborhoods, the pipeline helps researchers uncover molecular mechanisms and identify potential drug targets for repurposing.

The workflow integrates multiple module inference algorithms, including DOMINO, DIAMOnD, and Random Walk with Restart, alongside evaluation tools for functional coherence and network topology. Results are summarized in a MultiQC report and can be exported to the Drugst.One platform for interactive visualization and drug prioritization.

## Data preparation
The pipeline requires two primary inputs: a set of seed genes and a background molecular network. These can be provided via a samplesheet or direct command-line parameters.

*   **Seeds**: A text file containing one gene or protein identifier per line. Supported ID spaces include Entrez, Symbol, Ensembl, and UniProt (default is `entrez`).
*   **Network**: A protein-protein interaction network file. Supported formats include `.gt`, `.csv`, `.tsv`, `.graphml`, `.xml`, `.dot`, and `.gml`.
*   **Samplesheet**: A CSV file used to define multiple seed-network combinations.

Minimal samplesheet example (`samplesheet.csv`):
```csv
seeds,network
seeds_alzheimer.txt,human_interactome.gt
seeds_cancer.txt,human_interactome.gt
```

If using the network perturbation evaluation (`--run_network_perturbation`), you may also provide a path to a directory containing pre-computed perturbed networks.

## How to run
The pipeline is currently under development, so it is recommended to use the development branch with `-r dev`. Use `-profile` to specify the container engine (e.g., `docker`, `singularity`, or `conda`).

```bash
nextflow run nf-core/diseasemodulediscovery \
   -r dev \
   -profile <docker/singularity> \
   --seeds ./seeds.txt \
   --network ./interactome.gt \
   --outdir ./results
```

To run with a samplesheet:
```bash
nextflow run nf-core/diseasemodulediscovery \
   -r dev \
   -profile <docker/singularity> \
   --input ./samplesheet.csv \
   --outdir ./results
```

Key parameters include `--id_space` to match your gene identifiers and flags like `--run_seed_perturbation` or `--run_network_perturbation` to enable advanced robustness evaluations.

## Outputs
Results are saved in the directory specified by `--outdir`.

*   **MultiQC**: A summary report (`multiqc_report.html`) containing evaluation metrics, over-representation analysis (g:Profiler), and functional coherence results (DIGEST).
*   **Modules**: Identified disease modules for each algorithm, provided in network formats and as node lists.
*   **Visualizations**: Interactive network visualizations generated via `pyvis` and `graph-tool`.
*   **Drug Prioritization**: Results from Drugst.One API queries and proximity-based drug-target analysis.
*   **Annotations**: Biological data queried from NeDRexDB and module information converted to BioPAX format.

For a detailed description of all output files, refer to the official [pipeline output documentation](https://nf-co.re/diseasemodulediscovery/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/contributing.md`](references/docs/contributing.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
