# pyroe CWL Generation Report

## pyroe_valid

### Tool Description
pyroe: error: argument command: invalid choice: 'valid' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Total Downloads**: 36.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/pyroe
- **Stars**: N/A
### Original Help Text
```text
usage: pyroe [-h] [-v]
             {make-spliced+intronic,make-splici,make-spliced+unspliced,make-spliceu,fetch-quant,id-to-name,convert}
             ...
pyroe: error: argument command: invalid choice: 'valid' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')
```


## pyroe_additional

### Tool Description
pyroe: error: argument command: invalid choice: 'additional' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyroe [-h] [-v]
             {make-spliced+intronic,make-splici,make-spliced+unspliced,make-spliceu,fetch-quant,id-to-name,convert}
             ...
pyroe: error: argument command: invalid choice: 'additional' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')
```


## pyroe_Make

### Tool Description
pyroe: error: argument command: invalid choice: 'Make' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyroe [-h] [-v]
             {make-spliced+intronic,make-splici,make-spliced+unspliced,make-spliceu,fetch-quant,id-to-name,convert}
             ...
pyroe: error: argument command: invalid choice: 'Make' (choose from 'make-spliced+intronic', 'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name', 'convert')
```


## pyroe_fetch-quant

### Tool Description
The ids of the datasets to fetch

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyroe fetch-quant [-h] [--fetch-dir FETCH_DIR] [--force] [--delete-tar]
                         [--quiet]
                         dataset-ids [dataset-ids ...]

positional arguments:
  dataset-ids           The ids of the datasets to fetch

options:
  -h, --help            show this help message and exit
  --fetch-dir FETCH_DIR
                        The path to a directory for storing fetched datasets.
  --force               A flag indicates whether existing datasets will be redownloaded by force.
  --delete-tar          A flag indicates whether fetched tar files stored in the quant_tar directory under the provided fetch_dir should be deleted.
  --quiet               A flag indicates whether help messaged should not be printed.

Index of the available datasets:
1. 500 Human PBMCs, 3' LT v3.1, Chromium Controller
2. 500 Human PBMCs, 3' LT v3.1, Chromium X
3. 1k PBMCs from a Healthy Donor (v3 chemistry)
4. 10k PBMCs from a Healthy Donor (v3 chemistry)
5. 10k Human PBMCs, 3' v3.1, Chromium X
6. 10k Human PBMCs, 3' v3.1, Chromium Controller
7. 10k Peripheral blood mononuclear cells (PBMCs) from a healthy donor, Single Indexed
8. 10k Peripheral blood mononuclear cells (PBMCs) from a healthy donor, Dual Indexed
9. 20k Human PBMCs, 3' HT v3.1, Chromium X
10. PBMCs from EDTA-Treated Blood Collection Tubes Isolated via SepMate-Ficoll Gradient (3' v3.1 Chemistry)
11. PBMCs from Heparin-Treated Blood Collection Tubes Isolated via SepMate-Ficoll Gradient (3' v3.1 Chemistry)
12. PBMCs from ACD-A Treated Blood Collection Tubes Isolated via SepMate-Ficoll Gradient (3' v3.1 Chemistry)
13. PBMCs from Citrate-Treated Blood Collection Tubes Isolated via SepMate-Ficoll Gradient (3' v3.1 Chemistry)
14. PBMCs from Citrate-Treated Cell Preparation Tubes (3' v3.1 Chemistry)
15. PBMCs from a Healthy Donor: Whole Transcriptome Analysis
16. Whole Blood RBC Lysis for PBMCs and Neutrophils, Granulocytes, 3'
17. Peripheral blood mononuclear cells (PBMCs) from a healthy donor - Manual (channel 5)
18. Peripheral blood mononuclear cells (PBMCs) from a healthy donor - Manual (channel 1)
19. Peripheral blood mononuclear cells (PBMCs) from a healthy donor - Chromium Connect (channel 5)
20. Peripheral blood mononuclear cells (PBMCs) from a healthy donor - Chromium Connect (channel 1)
21. Hodgkin's Lymphoma, Dissociated Tumor: Whole Transcriptome Analysis
22. 200 Sorted Cells from Human Glioblastoma Multiforme, 3' LT v3.1
23. 750 Sorted Cells from Human Invasive Ductal Carcinoma, 3' LT v3.1
24. 2k Sorted Cells from Human Glioblastoma Multiforme, 3' v3.1
25. 7.5k Sorted Cells from Human Invasive Ductal Carcinoma, 3' v3.1
26. Human Glioblastoma Multiforme: 3'v3 Whole Transcriptome Analysis
27. 1k Brain Cells from an E18 Mouse (v3 chemistry)
28. 10k Brain Cells from an E18 Mouse (v3 chemistry)
29. 1k Heart Cells from an E18 mouse (v3 chemistry)
30. 10k Heart Cells from an E18 mouse (v3 chemistry)
31. 10k Mouse E18 Combined Cortex, Hippocampus and Subventricular Zone Cells, Single Indexed
32. 10k Mouse E18 Combined Cortex, Hippocampus and Subventricular Zone Cells, Dual Indexed
33. V2 1k PBMCs from a Healthy Donor (v2 chemistry)
34. V2 1k Brain Cells from an E18 Mouse (v2 chemistry)
35. V2 1k Heart Cells from an E18 mouse (v2 chemistry)
```


## pyroe_id-to-name

### Tool Description
Converts gene/transcript IDs to names from a GTF/GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyroe id-to-name [-h] [--format FORMAT] gtf_file output

positional arguments:
  gtf_file         The GTF input file.
  output           The path to where the output tsv file will be written.

options:
  -h, --help       show this help message and exit
  --format FORMAT  The input format of the file (must be either GTF or GFF3).
                   This will be inferred from the filename, but if that fails
                   it can be provided explicitly.
```


## pyroe_convert

### Tool Description
Convert quantification data to various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
- **Homepage**: https://github.com/COMBINE-lab/pyroe
- **Package**: https://anaconda.org/channels/bioconda/packages/pyroe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyroe convert [-h] [--output-structure OUTPUT_STRUCTURE]
                     [--output-format OUTPUT_FORMAT]
                     [--geneid-to-name GENEID_TO_NAME]
                     quant_dir output

positional arguments:
  quant_dir             The input quantification directory containing the
                        matrix to be converted.
  output                The output name where the quantification matrix should
                        be written. For `csvs` output format, this will be a
                        directory. For all others, it will be a file.

options:
  -h, --help            show this help message and exit
  --output-structure OUTPUT_STRUCTURE
                        The structure that U,S and A counts should occupy in
                        the output matrix.
  --output-format OUTPUT_FORMAT
                        The format in which the output should be written, one
                        of {'h5ad', 'csvs', 'loom', 'zarr'}.
  --geneid-to-name GENEID_TO_NAME
                        A 2 column tab-separated list of gene ID to gene name
                        mappings. Providing this file will project gene IDs to
                        gene names in the output.
```


## Metadata
- **Skill**: not generated
