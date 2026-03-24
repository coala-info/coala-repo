---
name: proteomics-peptide-and-protein-quantification-via-stable-ist
description: "This proteomics workflow processes mzML raw data and FASTA sequences to perform peptide and protein quantification using OpenMS tools such as FeatureFinderMultiplex, XTandemAdapter, and ProteinQuantifier. Use this skill when you need to analyze mass spectrometry data from stable isotope labeling experiments to accurately measure relative protein expression levels across different biological samples."
homepage: https://workflowhub.eu/workflows/1449
---

# Proteomics: Peptide and Protein Quantification via stable istobe labeling

## Overview

This Galaxy workflow provides a comprehensive pipeline for peptide and protein quantification using Stable Isotope Labeling (SIL). It processes raw mass spectrometry data in mzML format against a FASTA protein database to perform both identification and relative quantification of labeled samples.

The identification branch utilizes the [XTandemAdapter](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_xtandemadapter/XTandemAdapter/2.6+galaxy0) for database searching, followed by a rigorous validation sequence. Tools such as [PeptideIndexer](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_peptideindexer/PeptideIndexer/2.6+galaxy0), [IDPosteriorErrorProbability](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idposteriorerrorprobability/IDPosteriorErrorProbability/2.6+galaxy0), and [FalseDiscoveryRate](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.6+galaxy0) are employed to ensure high-confidence peptide-spectrum matches and control the false discovery rate at both the peptide and protein levels.

Simultaneously, the quantification branch uses [FeatureFinderMultiplex](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_featurefindermultiplex/FeatureFinderMultiplex/2.6+galaxy0) to detect and quantify isotopic patterns. These features are integrated with the identification results via [IDMapper](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idmapper/IDMapper/2.6+galaxy0). The workflow then resolves identification conflicts and multiplexing assignments to prepare the data for protein inference using the [FidoAdapter](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fidoadapter/FidoAdapter/2.6+galaxy0).

In the final stages, [ProteinQuantifier](https://toolshed.g2.bx.psu.edu/repos/galaxyp/openms_proteinquantifier/ProteinQuantifier/2.6+galaxy0) aggregates peptide-level ratios into final protein abundances. The workflow concludes by generating summary statistics, histograms for quality control, and text-based exports of the quantification results. This pipeline is aligned with [GTN](https://training.galaxyproject.org/) best practices for Proteomics data analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mzml raw file | data_input |  |
| 1 | fasta file | data_input |  |


Ensure your input mzML files are converted to centroid mode and your FASTA database contains relevant decoy sequences for accurate FDR estimation. While this workflow processes individual datasets, you can use dataset collections to scale the analysis across multiple replicates or conditions. Refer to the README.md for specific parameter configurations and isotope labeling settings required for the OpenMS tools. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution. For a comprehensive guide on data preparation and tool settings, consult the full documentation in the repository.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FeatureFinderMultiplex | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_featurefindermultiplex/FeatureFinderMultiplex/2.6+galaxy0 |  |
| 3 | XTandemAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_xtandemadapter/XTandemAdapter/2.6+galaxy0 |  |
| 4 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 5 | PeptideIndexer | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_peptideindexer/PeptideIndexer/2.6+galaxy0 |  |
| 6 | IDPosteriorErrorProbability | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idposteriorerrorprobability/IDPosteriorErrorProbability/2.6+galaxy0 |  |
| 7 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.6+galaxy0 |  |
| 8 | IDScoreSwitcher | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idscoreswitcher/IDScoreSwitcher/2.6+galaxy0 |  |
| 9 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 10 | FidoAdapter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fidoadapter/FidoAdapter/2.6+galaxy0 |  |
| 11 | FalseDiscoveryRate | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_falsediscoveryrate/FalseDiscoveryRate/2.6+galaxy0 |  |
| 12 | FileInfo | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_fileinfo/FileInfo/2.6+galaxy0 |  |
| 13 | TextExporter | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_textexporter/TextExporter/2.6+galaxy0 |  |
| 14 | IDMapper | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idmapper/IDMapper/2.6+galaxy0 |  |
| 15 | Select | Grep1 |  |
| 16 | Select | Grep1 |  |
| 17 | IDConflictResolver | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_idconflictresolver/IDConflictResolver/2.6+galaxy0 |  |
| 18 | MultiplexResolver | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_multiplexresolver/MultiplexResolver/2.5+galaxy0 |  |
| 19 | ProteinQuantifier | toolshed.g2.bx.psu.edu/repos/galaxyp/openms_proteinquantifier/ProteinQuantifier/2.6+galaxy0 |  |
| 20 | Summary Statistics | Summary_Statistics1 |  |
| 21 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/1.1.0 |  |
| 22 | Histogram | toolshed.g2.bx.psu.edu/repos/devteam/histogram/histogram_rpy/1.0.4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | out_multiplets | out_multiplets |
| 3 | out | out |
| 4 | out | out |
| 5 | out | out |
| 6 | out | out |
| 7 | out | out |
| 8 | out | out |
| 9 | out | out |
| 10 | out | out |
| 11 | out | out |
| 12 | out | out |
| 13 | out | out |
| 14 | out | out |
| 15 | out_file1 | out_file1 |
| 16 | out_file1 | out_file1 |
| 17 | out | out |
| 18 | out | out |
| 19 | out | out |
| 19 | peptide_out | peptide_out |
| 20 | out_file1 | out_file1 |
| 21 | outfile | outfile |
| 22 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
