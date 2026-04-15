---
name: secreted-proteins-via-go-annotation-and-wolf-psort-for-shcts
description: This proteomics workflow identifies secreted proteins from a list of UniProt accessions by integrating Gene Ontology annotations and WoLF PSORT subcellular localization predictions. Use this skill when you need to characterize the secretome of a biological sample to investigate extracellular signaling mechanisms or identify potential protein biomarkers.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# secreted-proteins-via-go-annotation-and-wolf-psort-for-shcts

## Overview

This Galaxy workflow identifies secreted proteins from a user-provided list of UniProt accessions. Developed for research involving shCTSB (Cathepsin B knockdown), it combines Gene Ontology (GO) annotations with computational localization predictions to characterize the secretome. The workflow is published and maintained on [GitHub](https://github.com/Stortebecker/secretome_prediction).

The analysis begins by retrieving protein data via the UniProt REST interface and integrating it with the UniProt GO database and Open Biomedical Ontology (OBO) files. It utilizes specialized tools to extract subontologies, isolating specific cellular component terms associated with the extracellular space and secretion pathways.

Simultaneously, the workflow employs [WoLF PSORT](https://github.com/fmaguire/WoLF-PSORT) to predict subcellular localization based on protein sequences. The final stages involve a series of text-processing steps—including joins, filters, and uniqueness checks—to cross-reference the GO-derived data with the WoLF PSORT predictions. This multi-pronged approach ensures a refined and high-confidence final list of secretome proteins.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Custom Protein list (uniprot accession) | data_input | Input: Protein ID list First column has to be uniprot accessions |
| 1 | Uniprot GO database | data_input | Input: Uniprot GO database file (choose the right organism) Example: ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/HUMAN/gene_association.goa_human.gz |
| 2 | Open Biomedical Ontology (OBO) | data_input | Input: Please downlad the Open Biomedical Ontology (OBO), i.e. "GO term tree" from http://purl.obolibrary.org/obo/go/go.obo |


Ensure your protein list is formatted as a tabular file containing UniProt accessions, and verify that the OBO file is in the standard Open Biomedical Ontology format. While these inputs are typically processed as individual datasets, ensure the UniProt GO database version aligns with your OBO file to maintain consistency across the subontology mapping steps. Refer to the README.md for comprehensive details on the specific column requirements and term IDs necessary for successful secretome prediction. You can streamline the configuration of these inputs by using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | UniProt | toolshed.g2.bx.psu.edu/repos/bgruening/uniprot_rest_interface/uniprot/0.1 | Retrieves Fasta files for all proteins in the input list. |
| 4 | Select | Grep1 | Removes comment lines at the head of the Uniprot Go database file. |
| 5 | Get subontology from a given OBO term | get_subontology_from | GO:0043230 "extracellular organelle" |
| 6 | Get subontology from a given OBO term | get_subontology_from | GO:0005576 "extracellular region" |
| 7 | Get subontology from a given OBO term | get_subontology_from | GO:0005887 "integral component of plasma membrane" |
| 8 | Get subontology from a given OBO term | get_subontology_from | GO:0009986 "cell surface" |
| 9 | Get subontology from a given OBO term | get_subontology_from | GO:0005764 "lysosome" |
| 10 | WoLF PSORT | toolshed.g2.bx.psu.edu/repos/peterjc/tmhmm_and_signalp/wolf_psort/0.0.8 | Predicts subcellular localization of all proteins in the input list. |
| 11 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Annotates input protein list with GO annotations. |
| 12 | Get all the term IDs and term names of a given OBO ontology | term_id_vs_term_name | GO:0043230 "extracellular organelle" |
| 13 | Get all the term IDs and term names of a given OBO ontology | term_id_vs_term_name | GO:0005576 "extracellular region" |
| 14 | Get all the term IDs and term names of a given OBO ontology | term_id_vs_term_name | GO:0005887 "integral component of plasma membrane" |
| 15 | Get all the term IDs and term names of a given OBO ontology | term_id_vs_term_name | GO:0009986 "cell surface" |
| 16 | Get all the term IDs and term names of a given OBO ontology | term_id_vs_term_name | GO:0005764 "lysosome" |
| 17 | Filter | Filter1 | Filters all proteins that are predicted to reside extracellularly. |
| 18 | Filter | Filter1 | Filters all proteins that are predicted to reside in lysosomes. |
| 19 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 |  |
| 20 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Combines all GO annotations for "integral to plasma membrane" and "cell surface" |
| 21 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Combines all proteins in the input list that are predicted by WolfPsort to be lysosomal and/or extracellular. |
| 22 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Combines all GO annotations for "extracellular region", "integral to plasma membrane" and "cell surface" excluding "extracellular organelle" |
| 23 | Convert | Convert characters1 | Extracts uniprot accessions from all proteins in the input list that are predicted by WolfPsort to be lysosomal and/or extracellular. |
| 24 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Combines all GO annotations for "lysosome", "extracellular region", "integral to plasma membrane" and "cell surface" excluding "extracellular organelle" |
| 25 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.0.0 | Deletes all columns but the one containing uniprot accessions of extracellular proteins as predicted by WoLF PSORT. |
| 26 | Compare two Datasets | comp1 | filters out all proteins in the input protein list of interest that are annotated as "extracellular region" and "lysosome" and "plasma membrane" excluding "extracellular organelle" and "cytoplasmic side of plasma membrane" |
| 27 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/unique/bg_uniq/0.3 | cleans up the protein list for unique entries |
| 28 | Cut | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cut_tool/1.0.0 | Deletes all columns but the one containing uniprot accessions of secreted and shed (i.e. "secretome") proteins. |
| 29 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.0.0 | Combines all proteins that are either predicted by WoLF PSORT to be shed or secreted or annotated in the GO database to be shed or secreted. |
| 30 | Unique | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sorted_uniq/1.0.0 | Final output. Unique entries of all proteins that are either predicted by WoLF PSORT to be shed or secreted or annotated in the GO database to be shed or secreted. |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 30 | Secretome proteins | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-secretomeprediction-gowolfpsort.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-secretomeprediction-gowolfpsort.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-secretomeprediction-gowolfpsort.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-secretomeprediction-gowolfpsort.ga -o job.yml`
- Lint: `planemo workflow_lint wf-secretomeprediction-gowolfpsort.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-secretomeprediction-gowolfpsort.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)