---
name: gene-cluster-product-similarity-search
description: "This Galaxy workflow identifies biosynthetic gene clusters from genomic sequences using antiSMASH and performs chemical similarity searches between predicted products and target molecule libraries using fingerprinting and drug-likeness tools. Use this skill when you need to prioritize genomic regions for natural product discovery by matching the predicted metabolic output of uncharacterized gene clusters against known bioactive compounds or chemical libraries."
homepage: https://workflowhub.eu/workflows/1558
---

# Gene Cluster Product Similarity Search

## Overview

This workflow facilitates the identification of biosynthetic gene clusters (BGCs) and evaluates the chemical similarity between their predicted products and known natural compound libraries. It begins by retrieving genomic data via [NCBI Accession Download](https://toolshed.g2.bx.psu.edu/repos/iuc/ncbi_acc_download/ncbi_acc_download/0.2.8+galaxy0) and processing these sequences through [antiSMASH](https://toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/6.1.1+galaxy1) to identify and annotate secondary metabolite BGCs.

The pipeline integrates chemical informatics to bridge the gap between genomic data and molecular structures. Target molecules from a natural compound library are processed to remove duplicates and filtered for drug-likeness and natural product scores. Both the predicted BGC products and the target library are converted into chemical fingerprints using [chemfp](https://toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_mol2fps/1.5).

Finally, a [Similarity Search](https://toolshed.g2.bx.psu.edu/repos/bgruening/simsearch/ctb_simsearch/0.2) is performed to compare the fingerprints, while an interactive Jupyter Notebook environment allows for custom feature extraction and data exploration. The workflow outputs comprehensive reports, including antiSMASH HTML visualizations, GenBank files, and tabular summaries of gene clusters.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Query Genomes | parameter_input |  |
| 1 | Jupyter Notebook Genbank2Features | data_input |  |
| 2 | Target Molecules (Natural Compound Library) | data_input |  |


Ensure your query genomes are provided as a list of NCBI accessions or GenBank files, while target molecules should be in SMILES or SDF format for fingerprinting. Using a dataset collection for multiple genomes is recommended to streamline the antiSMASH and downstream processing steps. For automated testing and job configuration, you can initialize a `job.yml` file using `planemo workflow_job_init`. Refer to the `README.md` for comprehensive details on configuring the Jupyter Notebook and specific tool parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | NCBI Accession Download | toolshed.g2.bx.psu.edu/repos/iuc/ncbi_acc_download/ncbi_acc_download/0.2.8+galaxy0 |  |
| 4 | Molecule to fingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_mol2fps/1.5 |  |
| 5 | Antismash | toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/6.1.1+galaxy1 |  |
| 6 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 7 | Interactive JupyTool and notebook | interactive_tool_jupyter_notebook |  |
| 8 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 9 | Remove beginning | Remove beginning1 |  |
| 10 | Remove duplicated molecules | toolshed.g2.bx.psu.edu/repos/bgruening/openbabel_remduplicates/openbabel_remDuplicates/3.1.1+galaxy0 |  |
| 11 | Molecule to fingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/chemfp/ctb_chemfp_mol2fps/1.5 |  |
| 12 | Natural Product | toolshed.g2.bx.psu.edu/repos/bgruening/natural_product_likeness/ctb_np-likeness-calculator/2.1 |  |
| 13 | Drug-likeness | toolshed.g2.bx.psu.edu/repos/bgruening/qed/ctb_silicos_qed/2021.03.4+galaxy0 |  |
| 14 | Similarity Search | toolshed.g2.bx.psu.edu/repos/bgruening/simsearch/ctb_simsearch/0.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | NCBI Accession Download on input dataset(s): Log | error_log |
| 3 | NCBI Accession Download on input dataset(s): Downloaded Files | output |
| 5 | log | log |
| 5 | genbank | genbank |
| 5 | Antismash on input dataset(s): HTML report | html |
| 5 | archive | archive |
| 5 | embl | embl |
| 5 | genecluster_tabular | genecluster_tabular |
| 6 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
