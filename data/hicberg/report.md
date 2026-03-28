# hicberg CWL Generation Report

## hicberg_alignment

### Tool Description
Perform alignment of Hi-C reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Total Downloads**: 222
- **Last updated**: 2025-06-05
- **GitHub**: https://github.com/sebgra/hicberg
- **Stars**: N/A
### Original Help Text
```text
Usage: hicberg alignment <options> <genome> <input1> <input2>

  Perform alignment of Hi-C reads.

Options:
  -i, --index <str>          Index of the genome (path). If not set, the index
                             is built.
  -o, --output <str>         Output folder to save results. If not set, the
                             current directory is used.
  -s, --sensitivity <str>    Set sensitivity level for Bowtie2.  [default:
                             very-sensitive]
  -k, --max-alignment <int>  Set the number of alignments to report in
                             ambiguous reads case. If set to -1, all
                             alignments are reported.
  -t, --cpus <int>           Threads to use for analysis.  [default: 1]
  -v, --verbose              Set verbosity level.
  -h, --help                 Show this message and exit.

  For more information about Bowtie2, please visit : http://bowtie-
  bio.sourceforge.net/bowtie2/index.shtml For more information about Samtools,
  please visit : http://www.htslib.org/doc/samtools.html
```


## hicberg_benchmark

### Tool Description
Perform benchmarking of the statistical model (this can be time consuming).

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg benchmark <options> <genome>

  Perform benchmarking of the statistical model (this can be time consuming).

Options:
  -o, --output <str>            Output folder to save results.
  -c, --chromosome <str>        Chromosome to get as source for duplication.
  -p, --position <int>          Position to get as source for duplication.
  -C, --trans-chromosome <str>  Chromosome to get as target for duplication.
  -P, --trans-position <int>    Position to get as target for duplication.
  -b, --bins <int>              Number of bins to select from a genomic
                                coordinates.  [default: 1]
  -s, --strides <int>           Strides to apply from source genomic
                                coordinates to define targets intervals.
                                Multiple strides must be coma separated.
  -a, --auto <int>              Automatically select auto intervals for
                                duplication.
  -K, --kernel-size <int>       Size of the gaussian kernel for contact
                                density estimation.  [default: 11]
  -d, --deviation <float>       Standard deviation for contact density
                                estimation.  [default: 0.5]
  -m, --mode <str>              Statistical model to use for ambiguous reads
                                assignment. Multiple modes must be coma
                                separated.  [default: full]
  -S, --pattern <str>           Set pattern if benchmarking considering
                                patterns.
  -t, --threshold <float>       Set pattern score threshold under which
                                pattern are discarded.  [default: 0.0]
  -j, --jitter <int>            Set jitter for pattern detection interval
                                overlapping  [default: 0]
  -T, --trend TEXT              Set if detrending of the contact map has to be
                                performed.
  -k, --top <int>               Set the top k % of patterns to retain.
                                [default: 100]
  -i, --iterations <int>        Set the number of iterations for benchmarking.
                                [default: 3]
  -f, --force                   Set if previous analysis files have to be
                                deleted.
  --cpus <int>                  Threads to use for analysis.  [default: 1]
  -h, --help                    Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_build-matrix

### Tool Description
Create matrix (.cool) from pairs files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg build-matrix <options>

  Create matrix (.cool) from pairs files.

Options:
  -o, --output <str>  Output folder to save results.
  -r, --recover       Set if .cool matrix are built after reads reassignment.
                      Therefor pairs file from group2 will be used.
  -t, --cpus INTEGER  Threads to use for matrix building.
  -h, --help          Show this message and exit.

  For more information about cooler, please visit :
  https://cooler.readthedocs.io/en/latest/
```


## hicberg_build-pairs

### Tool Description
Create pair files from a pair of alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg build-pairs <options>

  Create pair files from a pair of alignment files.

Options:
  -o, --output <str>  Output folder to save results.
  -r, --recover       Set if pairs are built after reads reassignment.
                      Therefore alignment files of group2 will be used.
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_chunk

### Tool Description
Chunk provided inputs in a desired number of pieces.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg chunk <options> <input1> <input2>

  Chunk provided inputs in a desired number of pieces.

Options:
  -n, --chunks <int>  Number of chunks to generate.  [default: 2]
  -o, --output <str>  Output folder to save the chunks.
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_classify

### Tool Description
Perform classification of Hi-C reads (pairs). 3 groups wil be defined and 2 alignment files (.bam) will be created per group:

  - Unmapped read pairs (group 0)

  - Read pairs with both reads mapping at only one position (group 1)

  - Read pairs with at least one read mapping at multiple positions (group 2)

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg classify <options>

  Perform classification of Hi-C reads (pairs). 3 groups wil be defined and 2
  alignment files (.bam) will be created per group:

  - Unmapped read pairs (group 0)

  - Read pairs with both reads mapping at only one position (group 1)

  - Read pairs with at least one read mapping at multiple positions (group 2)

Options:
  -q, --mapq INTEGER  Minimum mapping quality to consider a read as non
                      ambiguous.
  -o, --output TEXT   Output folder to save results.
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_create-folder

### Tool Description
Create a folder to save results. Folder will be set as <output>/<name>.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg create-folder <options>

  Create a folder to save results. Folder will be set as <output>/<name>.

Options:
  -o, --output <str>  Output folder to save results. If not set, the current
                      directory is used.
  -n, --name <str>    Name of the output folder to create. If not set,
                      'sample' is used.
  -f, --force         Set if previous analysis files are deleted.
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_get-tables

### Tool Description
Create tables for the genome length detail and the bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg get-tables <options> <genome>

  Create tables for the genome length detail and the bins.

Options:
  -o, --output <str>  Output folder to save results. If not set, the current
                      directory is used.
  -b, --bins <int>    Genomic resolution.  [default: 2000]
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_pipeline

### Tool Description
Hi-C pipeline to generate enhanced contact matrix from fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg pipeline <options> <genome> <input1> <input2>

  Hi-C pipeline to generate enhanced contact matrix from fastq files.

Options:
  -i, --index <str>          Index of the genome.
  -n, --name <str>           Name of the analysis.  [default: sample]
  -r, --rate <float>         Rate to use for sub-sampling restriction map.
                             [default: 1.0]
  -D, --distance <int>       Maximum distance beyond which pairs are discarded
                             in omics mode.  [default: 1000]
  -t, --cpus <int>           Threads to use for analysis.  [default: 1]
  -K, --kernel-size <int>    Size of the gaussian kernel for contact density
                             estimation.  [default: 11]
  -d, --deviation <float>    Standard deviation for contact density
                             estimation.  [default: 0.5]
  -m, --mode <str>           Statistical model to use for ambiguous reads
                             assignment.  [default: full]
  -k, --max-alignment <int>  Set the number of alignments to report in
                             ambiguous reads case. Value of -1 reports all
                             alignments.
  -s, --sensitivity <str>    Set sensitivity level for Bowtie2.  [default:
                             very-sensitive]
  -b, --bins <int>           Genomic resolution.  [default: 2000]
  -e, --enzyme <str>         Enzymes to use for genome digestion.
  -c, --circular <str>       Name of the chromosome to consider as circular.
                             [default: ""]
  -q, --mapq <int>           Minimum mapping quality to consider a read as
                             valid.  [default: 35]
  -o, --output <str>         Output folder to save results.
  --start-stage <str>        Stage to start the pipeline.  [default: fastq]
  --exit-stage <str>         Stage to exit the pipeline.  [default: None]
  -f, --force                Set if previous analysis files are deleted.
  -B, --blacklist <str>      Blacklisted coordintaes to exclude reads for
                             statistical learning. Provide either a bed file
                             or a list of coordinates coma separated using
                             UCSC format.
  -h, --help                 Show this message and exit.

  For more information about hicberg and used components, please visit :
  https://github.com/sebgra/hicberg  - Bowtie2 : http://bowtie-
  bio.sourceforge.net/bowtie2/index.shtml  - Samtools :
  http://www.htslib.org/doc/samtools.html
```


## hicberg_plot

### Tool Description
Plot results from analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg plot <options> <genome>

  Plot results from analysis.

Options:
  -o, --output <str>  Output folder to save results.
  -b, --bins <int>    Genomic resolution.  [default: 2000]
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_rescue

### Tool Description
Reallocate ambiguous reads to the most plausible position according to
  model.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg rescue <options> <genome>

  Reallocate ambiguous reads to the most plausible position according to
  model.

Options:
  -o, --output <str>  Output folder to save results.
  -e, --enzyme <str>  Enzymes to use for genome digestion.
  -m, --mode <str>    Statistical model to use for ambiguous reads assignment.
                      [default: full]
  -t, --cpus <int>    Threads to use for analysis.  [default: 1]
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_statistics

### Tool Description
Extract statistics from non ambiguous Hi-C data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg statistics <options> <genome>

  Extract statistics from non ambiguous Hi-C data.

Options:
  -o, --output <str>       Output folder to save results.
  -m, --mode <str>         Statistical model to use for ambiguous reads
                           assignment.  [default: standard]
  -K, --kernel-size <int>  Size of the gaussian kernel for contact density
                           estimation.  [default: 11]
  -d, --deviation <float>  Standard deviation for contact density estimation.
                           [default: 0.5]
  -r, --rate <float>       Rate to use for sub-sampling restriction map.
                           [default: 1.0]
  -e, --enzyme <str>       Enzymes to use for genome digestion.
  -c, --circular <str>     Name of the chromosome to consider as circular.
                           [default: ""]
  -b, --bins <int>         Genomic resolution.  [default: 2000]
  -t, --cpus <int>         Threads to use for analysis.  [default: 1]
  -B, --blacklist <str>    Blacklisted coordintaes to exclude reads for
                           statistical learning. Provide either a bed file or
                           a list of coordinates coma separated using UCSC
                           format.
  -h, --help               Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## hicberg_tidy

### Tool Description
Tidy output folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
- **Homepage**: https://github.com/sebgra/hicberg
- **Package**: https://anaconda.org/channels/bioconda/packages/hicberg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hicberg tidy <options>

  Tidy output folder.

Options:
  -o, --output <str>  Output folder to save results.
  -h, --help          Show this message and exit.

  For more information about hicberg, please visit
  :https://github.com/sebgra/hicberg
```


## Metadata
- **Skill**: not generated
