---
name: amr-detection
description: This Galaxy workflow performs antimicrobial resistance detection by assembling raw sequencing reads with Shovill and analyzing the resulting contigs using ABRicate, staramr, and hamronize. Use this skill when you need to identify resistance genes, point mutations, and plasmid markers in bacterial genomes to characterize the resistome of clinical or environmental isolates.
homepage: https://erasmusmc-bioinformatics.github.io/benchAMRking/
metadata:
  docker_image: "N/A"
---

# amr-detection

## Overview

This Galaxy workflow provides a comprehensive pipeline for Antimicrobial Resistance (AMR) detection from genomic data. It begins by performing de novo assembly of raw reads using [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1), which generates the contigs and assembly graphs necessary for downstream resistance gene identification.

The assembled contigs are processed through multiple AMR detection engines, including [ABRicate](https://toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1) and [staramr](https://toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.8.0+galaxy0). These tools scan for resistance genes, point mutations, and plasmid markers using databases such as ResFinder, PointFinder, and PlasmidFinder. The workflow also integrates MLST (Multi-Locus Sequence Typing) for pathogen characterization.

To unify the disparate outputs from different detection tools, the workflow utilizes [hamronize](https://toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1). This utility converts various tool-specific formats into a standardized schema, which is then aggregated and summarized into final HTML, JSON, and TSV reports. This standardization facilitates comparative analysis and data interoperability as described in [10.3390/microorganisms10020292](https://doi.org/10.3390/microorganisms10020292).

## Inputs and data preparation

_None listed._


For this workflow, ensure your input sequencing data is provided as a paired-end list collection of fastq.gz files to allow Shovill to process multiple samples efficiently. The pipeline expects high-quality genomic reads to generate the contigs required by ABRicate and staramr for accurate resistance gene identification. Refer to the README.md for specific parameter configurations and database versioning details. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible metadata mapping. Always verify that your input collection tags match the expected forward and reverse naming conventions to prevent assembly errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy1 |  |
| 1 | ABRicate | toolshed.g2.bx.psu.edu/repos/iuc/abricate/abricate/1.0.1 |  |
| 2 | staramr | toolshed.g2.bx.psu.edu/repos/nml/staramr/staramr_search/0.8.0+galaxy0 |  |
| 3 | hamronize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1 |  |
| 4 | hamronize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_tool/hamronize_tool/1.0.3+galaxy1 |  |
| 5 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 6 | Replace | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_find_and_replace/1.1.4 |  |
| 7 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |
| 8 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |
| 9 | hamronize: summarize | toolshed.g2.bx.psu.edu/repos/iuc/hamronize_summarize/hamronize_summarize/1.0.3+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | contigs | contigs |
| 0 | shovill_std_log | shovill_std_log |
| 0 | contigs_graph | contigs_graph |
| 1 | report | report |
| 2 | excel | excel |
| 2 | resfinder | resfinder |
| 2 | blast_hits | blast_hits |
| 2 | mlst | mlst |
| 2 | settings | settings |
| 2 | summary | summary |
| 2 | plasmidfinder | plasmidfinder |
| 2 | pointfinder | pointfinder |
| 2 | detailed_summary | detailed_summary |
| 3 | output_tsv | output_tsv |
| 4 | output_tsv | output_tsv |
| 5 | output | output |
| 6 | outfile | outfile |
| 7 | output_html | output_html |
| 8 | output_json | output_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-AMR_detection.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-AMR_detection.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-AMR_detection.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-AMR_detection.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-AMR_detection.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-AMR_detection.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)