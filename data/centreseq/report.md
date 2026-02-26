# centreseq CWL Generation Report

## centreseq_core

### Tool Description
Given an input directory containing any number of assemblies (.fasta), centreseq core will 1) annotate the genomes with Prokka, 2) perform self- clustering on each genome with MMSeqs2 linclust, 3) concatenate the self- clustered genomes into a single pan-genome, 4) cluster the pan-genome with MMSeqs2 linclust, establishing a core genome, 5) generate helpful reports to interrogate your dataset Note that if specified output directory already exists, centreseq will search for an existing Prokka directory and skip this step if possible.

### Metadata
- **Docker Image**: quay.io/biocontainers/centreseq:0.3.8--py_0
- **Homepage**: https://github.com/bfssi-forest-dussault/centreseq
- **Package**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bfssi-forest-dussault/centreseq
- **Stars**: N/A
### Original Help Text
```text
Usage: centreseq core [OPTIONS]

  Given an input directory containing any number of assemblies (.fasta),
  centreseq core will 1) annotate the genomes with Prokka, 2) perform self-
  clustering on each genome with MMSeqs2 linclust, 3) concatenate the self-
  clustered genomes into a single pan-genome, 4) cluster the pan-genome with
  MMSeqs2 linclust, establishing a core genome, 5) generate helpful reports
  to interrogate your dataset Note that if specified output directory
  already exists, centreseq will search for an existing Prokka directory and
  skip this step if possible.

Options:
  -f, --fasta-dir PATH         Path to directory containing *.fasta files for
                               input to the core pipeline  [required]
  -o, --outdir PATH            Root directory to store all output files. If
                               this directory already exists, the pipeline
                               will attempt to skip the Prokka step by reading
                               in the existing Prokka output directory, but
                               will overwrite all other existing result files.
                               [required]
  -n, --n-cpu INTEGER          Number of CPUs to dedicate to parallelizable
                               steps of the pipeline. Will take all available
                               CPUs - 1 by default.
  --n-cpu-medoid INTEGER       Number of CPUs for the representative medoid
                               picking step (if enabled). You will need
                               substantial RAM per CPU.
  -m, --min-seq-id FLOAT       Sets the mmseqs cluster parameter "--min-seq-
                               id". Defaults to 0.95.
  -c, --coverage-length FLOAT  Sets the mmseqs cluster coverage parameter "-c"
                               directly. Defaults to 0.95, which is the
                               recommended setting.
  --medoid-repseqs             This setting will identify the representative
                               medoid nucleotide sequence for each core
                               cluster. Enabling this will increase
                               computation time considerably. Note that this
                               parameter has no effect on the number of core
                               clusters detected.
  --pairwise                   Generate pairwise comparisons of all core
                               genomes. This setting allows for viewing an
                               interactive network chart which visualizes core
                               genome relatedness.
  -v, --verbose                Set this flag to enable more verbose logging.
  --version                    Use this flag to print the version and exit.
  --help                       Show this message and exit.
```


## centreseq_genome

### Tool Description
CentreSeq is a tool for analyzing sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/centreseq:0.3.8--py_0
- **Homepage**: https://github.com/bfssi-forest-dussault/centreseq
- **Package**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: centreseq [OPTIONS] COMMAND [ARGS]...
Try "centreseq --help" for help.

Error: No such command "genome".
```


## centreseq_extract

### Tool Description
Given the path to the centreseq core directory and the ID of a cluster representative, will create a multi-FASTA containing the sequences for all members of that cluster. Generates both an .ffn and .faa file.

### Metadata
- **Docker Image**: quay.io/biocontainers/centreseq:0.3.8--py_0
- **Homepage**: https://github.com/bfssi-forest-dussault/centreseq
- **Package**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: centreseq extract [OPTIONS]

  Given the path to the centreseq core directory and the ID of a cluster
  representative, will create a multi-FASTA containing the sequences for all
  members of that cluster. Generates both an .ffn and .faa file.

Options:
  -i, --indir PATH                Path to your centreseq output directory
                                  [required]
  -o, --outdir PATH               Root directory to store all output files
                                  [required]
  -c, --cluster_representative TEXT
                                  Name of the target cluster representative
                                  e.g. "Typhi.2299.BMH_00195"  [required]
  --version                       Use this flag to print the version and exit.
  --help                          Show this message and exit.
```


## centreseq_subset

### Tool Description
Given an input text file of Sample IDs and a summary report, will return a filtered version of the summary report for clusters that belong exclusively in the input sample ID list

### Metadata
- **Docker Image**: quay.io/biocontainers/centreseq:0.3.8--py_0
- **Homepage**: https://github.com/bfssi-forest-dussault/centreseq
- **Package**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: centreseq subset [OPTIONS]

  Given an input text file of Sample IDs and a summary report, will return a
  filtered version of the summary report for clusters that belong
  exclusively in the input sample ID list

Options:
  -i, --input-samples PATH   Path to a new line separated text file containing
                             each Sample ID to target  [required]
  -s, --summary-report PATH  Path to summary report generated by the centreseq
                             core command, i.e. summary_report.tsv  [required]
  -o, --outpath PATH         Path to desired output file. If no value is
                             provided, will create a new report in the same
                             directory as the input summary report.
  --help                     Show this message and exit.
```


## centreseq_tree

### Tool Description
Processes centreseq core output files to produce files that can be fed into phylogenetic tree building software.

### Metadata
- **Docker Image**: quay.io/biocontainers/centreseq:0.3.8--py_0
- **Homepage**: https://github.com/bfssi-forest-dussault/centreseq
- **Package**: https://anaconda.org/channels/bioconda/packages/centreseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: centreseq tree [OPTIONS]

  Processes centreseq core output files to produce files that can be fed
  into phylogenetic tree building software.

Options:
  -s, --summary-report PATH  Path to summary_report.csv file produced by the
                             core pipeline  [required]
  -p, --prokka-dir PATH      Path to the Prokka output directory generated by
                             the core pipeline  [required]
  -o, --outdir PATH          Root directory to store all output files
                             [required]
  -pct, --percentile FLOAT   Filter summary report by n_members to the top nth
                             percentile. Defaults to 99.0.
  -n, --n-cpu INTEGER        Number of CPUs to dedicate to parallelizable
                             steps of the pipeline.Will take all available
                             CPUs - 1 if not specified.
  -v, --verbose              Set this flag to enable more verbose logging.
  --version                  Use this flag to print the version and exit.
  --help                     Show this message and exit.
```


## Metadata
- **Skill**: generated
