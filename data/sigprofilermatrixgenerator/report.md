# sigprofilermatrixgenerator CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sigprofilermatrixgenerator_cnv_matrix_generator | PASS |  |
| sigprofilermatrixgenerator_install | PASS |  |
| sigprofilermatrixgenerator_matrix_generator | PASS |  |
| sigprofilermatrixgenerator_sv_matrix_generator | Failed | image problem: SV matrix step aborts with free(): invalid pointer (segfault) on the tool's own example bedpe files |

## sigprofilermatrixgenerator_install

### Tool Description
Install reference genome files (required to generate matrices).

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
- **Homepage**: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilermatrixgenerator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerMatrixGenerator [-h] [-l LOCAL_GENOME] [-v VOLUME] genome

Install reference genome files.

positional arguments:
  genome                The reference genome to install. Supported genomes
                        include {c_elegans, dog, ebv, GRCh37, GRCh38, mm9,
                        mm10, mm39, rn6, rn7, yeast}.

options:
  -h, --help            show this help message and exit
  -l, --local_genome LOCAL_GENOME
                        Install an offline reference genome downloaded from
                        the Alexandrov Lab's FTP server. Provide the absolute
                        path to the locally-stored genome file. For downloads,
                        visit AlexandrovLab's ftp server: ftp://alexandrovlab-
                        ftp.ucsd.edu/pub/tools/SigProfilerMatrixGenerator/
  -v, --volume VOLUME   Specify a destination for the downloaded genomes
                        (default: None, used for Docker)
```

## sigprofilermatrixgenerator_matrix_generator

### Tool Description
Create mutational matrices for SBSs, DBSs, and INDELs.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
- **Homepage**: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilermatrixgenerator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerMatrixGenerator [-h] [--exome] [--bed_file BED_FILE]
                                  [--chrom_based] [--plot [PLOT]]
                                  [--tsb_stat [TSB_STAT]]
                                  [--seqInfo [SEQINFO]] [--cushion CUSHION]
                                  [-v VOLUME]
                                  project reference_genome path_to_input_files

Create mutational matrices for all types of somatic mutations

positional arguments:
  project               The name of the project.
  reference_genome      The name of the reference genome. Supported values
                        {c_elegans, dog, ebv, GRCh37, GRCh38, mm9, mm10, mm39,
                        rn6, rn7, yeast}.
  path_to_input_files   The path to the input files.

options:
  -h, --help            show this help message and exit
  --exome               Downsamples mutational matrices to the exome regions
                        of the genome. Default is False.
  --bed_file BED_FILE   Downsamples mutational matrices to custom regions of
                        the genome. Provide full path to BED file. Note: BED
                        file header is required. Default is None.
  --chrom_based         Outputs chromosome-based matrices. Default is False.
  --plot [PLOT]         Integrates with SigProfilerPlotting to output
                        visualizations for each matrix. Default is False.
  --tsb_stat [TSB_STAT]
                        Outputs the results of a transcriptional strand bias
                        test for the respective matrices. Default is False.
  --seqInfo [SEQINFO]   Outputs original mutations into a text file with the
                        SigProfilerMatrixGenerator classification for each
                        mutation. Default is True.
  --cushion CUSHION     Adds an Xbp cushion to the exome/bed_file ranges for
                        downsampling mutations. Default is 100.
  -v, --volume VOLUME   Specify a destination for the downloaded genomes
                        (default: None, used for Docker)
```

## sigprofilermatrixgenerator_sv_matrix_generator

### Tool Description
Create mutational matrices for structural variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
- **Homepage**: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilermatrixgenerator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerMatrixGenerator [-h] input_dir project output_dir

Generate a structural variant (SV) matrix from input data.

positional arguments:
  input_dir   The directory containing the input files.
  project     The name of the project.
  output_dir  The directory where the output matrix will be stored.

options:
  -h, --help  show this help message and exit
```

## sigprofilermatrixgenerator_cnv_matrix_generator

### Tool Description
Create mutational matrices for copy number variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilermatrixgenerator:1.3.3--pyhdfd78af_1
- **Homepage**: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilermatrixgenerator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerMatrixGenerator [-h]
                                  {ASCAT,ASCAT_NGS,SEQUENZA,ABSOLUTE,BATTENBERG,FACETS,PURPLE,TCGA}
                                  input_file project output_path

Generate a Copy Number Variation (CNV) matrix.

positional arguments:
  {ASCAT,ASCAT_NGS,SEQUENZA,ABSOLUTE,BATTENBERG,FACETS,PURPLE,TCGA}
                        The type of the input file based on the CNV calling
                        tool used (e.g., 'ASCAT').
  input_file            The absolute path to the multi-sample segmentation
                        file.
  project               The name of the project.
  output_path           The path where the output CNV matrix will be stored.

options:
  -h, --help            show this help message and exit
```

