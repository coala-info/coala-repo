# agc CWL Generation Report

## agc_create

### Tool Description
AGC (Assembled Genomes Compressor) - Create a compressed archive from assembled genomes in FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/refresh-bio/agc
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc create [options] <ref.fa> [<in1.fa> ...] > <out.agc>
Options:
   -a             - adaptive mode (default: false)
   -b <int>       - batch size (default: 50; min: 1; max: 1000000000)
   -c             - concatenated genomes in a single file (default: false)
   -d             - do not store cmd-line (default: true)
   -f <float>     - fraction of fall-back minimizers (default: 0.000000; min: 0.000000; max: 0.050000)
   -i <file_name> - file with FASTA file names (alterantive to listing file names explicitely in command line)
   -k <int>       - k-mer length(default: 31; min: 17; max: 32)
   -l <int>       - min. match length (default: 20; min: 15; max: 32)
   -o <file_name> - output to file (default: output is sent to stdout)
   -s <int>       - expected segment size (default: 60000; min: 100; max: 1000000)
   -t <int>       - no of threads (default: 28; min: 1; max: 56)
   -v <int>       - verbosity level (default: 0; min: 0; max: 2)
```


## agc_append

### Tool Description
Assembled Genomes Compressor - append genomes to an existing archive

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc append [options] <in.agc> [<in1.fa> ...] > <out.agc>
Options:
   -a             - adaptive mode (default: false)
   -c             - concatenated genomes in a single file (default: false)
   -d             - do not store cmd-line (default: true)
   -f <float>     - fraction of fall-back minimizers (default: 0.000000; min: 0.000000; max: 0.050000)
   -i <file_name> - file with FASTA file names (alterantive to listing file names explicitely in command line)
   -o <file_name> - output to file (default: output is sent to stdout)
   -t <int>       - no of threads (default: 28; min: 1; max: 56)
   -v <int>       - verbosity level (default: 0; min: 0; max: 2)
```


## agc_getcol

### Tool Description
Assembled Genomes Compressor - get collection of sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc getcol [options] <in.agc> > <out.fa>
Options:
   -g <int>         - optional gzip with given level (default: 0; min: 0; max: 9)
   -f               - fast mode (needs more RAM) (default: false)
   -l <int>         - line length (default: 80; min: 40; max: 2000000000)
   -o <output_path> - output to files at path (default: output is sent to stdout)
   -r               - without reference (default: false)
   -t <int>         - no of threads (default: 28; min: 1; max: 56)
   -v <int>         - verbosity level (default: 0; min: 0; max: 2)
```


## agc_getset

### Tool Description
Assembled Genomes Compressor - extract a set of samples from an AGC file

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc getset [options] <in.agc> <sample_name1> [<sample_name2> ...] > <out.fa>
Options:
   -g <int>       - optional gzip with given level (default: 0; min: 0; max: 9)
   -l <int>       - line length (default: 80; min: 40; max: 2000000000)
   -o <file_name> - output to file (default: output is sent to stdout)
   -p             - disable file prefetching (useful for small genomes)
   -s             - enable streaming mode (slower but need less memory)
   -t <int>       - no of threads (default: 28; min: 1; max: 56)
   -v <int>       - verbosity level (default: 0; min: 0; max: 2)
```


## agc_getctg

### Tool Description
Extract contigs from an AGC (Assembled Genomes Compressor) file. Supports various formats for specifying contigs, samples, and ranges.

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc getctg [options] <in.agc> <contig1> [<contig2> ...] > <out.fa>
       agc getctg [options] <in.agc> <contig1@sample1> [<contig2@sample2> ...] > <out.fa>
       agc getctg [options] <in.agc> <contig1:from-to>[<contig2:from-to> ...] > <out.fa>
       agc getctg [options] <in.agc> <contig1@sample1:from-to> [<contig2@sample2:from-to> ...] > <out.fa>
Options:
   -g <int>       - optional gzip with given level (default: 0; min: 0; max: 9)
   -l <int>       - line length (default: 80; min: 40; max: 2000000000)
   -o <file_name> - output to file (default: output is sent to stdout)
   -p             - disable file prefetching (useful for short queries)
   -s             - enable streaming mode (slower but need less memory)
   -t <int>       - no of threads (default: 28; min: 1; max: 56)
   -v <int>       - verbosity level (default: 0; min: 0; max: 2)
```


## agc_listref

### Tool Description
List reference genomes in an AGC (Assembled Genomes Compressor) file

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc listref [options] <in.agc> > <out.txt>
Options:
   -o <file_name> - output to file (default: output is sent to stdout)
```


## agc_listset

### Tool Description
List datasets in an Assembled Genomes Compressor (AGC) file

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc listset [options] <in.agc> > <out.txt>
Options:
   -o <file_name> - output to file (default: output is sent to stdout)
```


## agc_listctg

### Tool Description
List contigs in an AGC (Assembled Genomes Compressor) file for specified samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc listctg [options] <in.agc> <sample1> [<sample2> ...] > <out.txt>
Options:
   -o <file_name> - output to file (default: output is sent to stdout)
```


## agc_info

### Tool Description
AGC (Assembled Genomes Compressor) - Get information about an AGC file

### Metadata
- **Docker Image**: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/agc
- **Package**: https://anaconda.org/channels/bioconda/packages/agc/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
AGC (Assembled Genomes Compressor) v. 3.2.0 [build 20241121.1]
Usage: agc info [options] <in.agc> > <out.txt>
Options:
   -o <file_name> - output to file (default: output is sent to stdout)
```


## Metadata
- **Skill**: generated
