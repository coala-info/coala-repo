# tigmint CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tigmint_tigmint-arcs-tsv | PASS | synthetic data: small planted ARCS graph and FASTA |
| tigmint_tigmint-cut | PASS |  |
| tigmint_tigmint-filter-paf | PASS |  |
| tigmint_tigmint-ntlink-map | Failed | image problem: ntLink is not installed in the image (FileNotFoundError: ntLink) |
| tigmint_tigmint_estimate_dist.py | PASS |  |
| tigmint_tigmint_molecule.py | PASS |  |
| tigmint_tigmint_molecule_paf.py | PASS |  |

## tigmint_tigmint-arcs-tsv

### Tool Description
Create a XXX.tigpair_checkpoint.tsv file from ARCS graph output that LINKS can utilize

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint-arcs-tsv [-h] graph_file out_file fasta_file

Create a XXX.tigpair_checkpoint.tsv file from ARCS graph output that LINKS can
utilize

positional arguments:
  graph_file  ARCS graph file output (.gv)
  out_file    Output file name. Must be named XXX.tigpair_checkpoint.tsv,
              where XXX is same as base name (-b) given to LINKS.
  fasta_file  FASTA file of sequences to scaffold

optional arguments:
  -h, --help  show this help message and exit
```

## tigmint_tigmint-cut

### Tool Description
Find misassembled regions in assembly using Chromium molecule extents

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint-cut [-h] [--version] -o FASTAOUT [-b BEDOUT] [-p PROCESSES]
                   [-w WINDOW] [-n SPANNING] [-t TRIM] [-f PARAM_FILE]
                   [-m MIN_LENGTH]
                   fasta bed

Find misassembled regions in assembly using Chromium molecule extents

positional arguments:
  fasta                 Reference genome fasta file (must have FAI index
                        generated)
  bed                   Sorted bed file of molecule extents

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o FASTAOUT, --fastaout FASTAOUT
                        The output FASTA file.
  -b BEDOUT, --bedout BEDOUT
                        The output BED file. Default is the output FASTA
                        filename plus .bed
  -p PROCESSES, --processes PROCESSES
                        Number of parallel processes to launch [8]
  -w WINDOW, --window WINDOW
                        Window size used to check for spanning molecules (bp)
                        [1000]
  -n SPANNING, --spanning SPANNING
                        Spanning molecules threshold (no misassembly in window
                        if num. spanning molecules >= n) [2].
  -t TRIM, --trim TRIM  Number of base pairs to trim at contig cuts (bp) [0]
  -f PARAM_FILE, --param_file PARAM_FILE
                        File containing calculated parameters for tigmint-long
  -m MIN_LENGTH, --min_length MIN_LENGTH
                        Minimum contig length for tallying attempted
                        corrections (bp) [3000]
```

## tigmint_tigmint-filter-paf

### Tool Description
Given a PAF-formatted mapping file, output molecule extents BED

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint-filter-paf [-h] [-m M] [--version] PAF

Given a PAF-formatted mapping file, output molecule extents BED

positional arguments:
  PAF         Input PAF file

optional arguments:
  -h, --help  show this help message and exit
  -m M        Minimum size of output extents (bp)
  --version   show program's version number and exit
```

## tigmint_tigmint-ntlink-map

### Tool Description
Run ntLink mapping, then output a filtered and sorted BED file with mapping extents

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint-ntlink-map [-h] --bed BED -k K -w W [-t T] [--path PATH] [-m M]
                          --span SPAN [--version]
                          target reads

Run ntLink mapping, then output a filtered and sorted BED file with mapping
extents

positional arguments:
  target       Draft assembly to scaffold
  reads        Long reads file

optional arguments:
  -h, --help   show this help message and exit
  --bed BED    Name for output BED file with mapping extents
  -k K         K-mer size (bp)
  -w W         Window size
  -t T         Number of threads [4]
  --path PATH  Path to directory with tigmint-fiter-paf executable, if not in
               PATH
  -m M         Minimum size for mapping block (bp) [2000]
  --span SPAN  Span value specified for tigmint-cut
  --version    show program's version number and exit
```

## tigmint_tigmint_estimate_dist.py

### Tool Description
Sample reads and estimate the Tigmint-long dist parameter from a read length percentile

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint_estimate_dist.py [-h] [-n N] [-p P] [-d D] [-o O] [-v] READS

Sample the reads from the given fasta/fastq file and estimate the Tigmint-long
dist parameter based on the chosen length percentile

positional arguments:
  READS          Input reads file (fa or fq)

optional arguments:
  -h, --help     show this help message and exit
  -n N           Number of reads to sample [10000]
  -p P           Read length percentile to use for dist parameter estimation
                 [50]
  -d D           Lower bound read length for percentile calculation [1000]
  -o O           Output file name [tigmint-long.params.tsv]
  -v, --version  show program's version number and exit
```

## tigmint_tigmint_molecule.py

### Tool Description
Group linked reads into molecules from a BAM sorted by BX tag and position

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint_molecule.py [-h] [--version] [-o FILE] [-w FILE] [--bed]
                           [--tsv] [-d N] [-m N] [-q N] [-a N] [-n N] [-s N]
                           [-p PARAM_FILE]
                           BAM

Group linked reads into molecules. Read a SAM/BAM file and output a TSV file.
The SAM/BAM file must be sorted by BX tag and then by position.

positional arguments:
  BAM                   Input BAM file sorted by BX tag then position, - for
                        stdin

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o FILE, --output FILE
                        Output TSV file [stdout]
  -w FILE, --out-bam FILE
                        Output BAM file with MI tags (optional)
  --bed                 Output in BED format [default]
  --tsv                 Output in TSV format
  -d N, --dist N        Maximum distance between reads in the same molecule
                        [50000]
  -m N, --reads N       Minimum number of reads per molecule (duplicates are
                        filtered out) [4]
  -q N, --mapq N        Minimum mapping quality [0]
  -a N, --as-ratio N    Minimum ratio of alignment score (AS) over read length
                        [0.65]
  -n N, --nm N          Maximum number of mismatches (NM) [5]
  -s N, --size N        Minimum molecule size [2000]
  -p PARAM_FILE, --params PARAM_FILE
```

## tigmint_tigmint_molecule_paf.py

### Tool Description
Group linked reads simulated from long reads into molecules from a PAF file

### Metadata
- **Docker Image**: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
- **Homepage**: https://github.com/bcgsc/tigmint
- **Package**: https://anaconda.org/channels/bioconda/packages/tigmint/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tigmint_molecule_paf.py [-h] [--version] [-o FILE] [-d N] [-m N] [-s N]
                               [-p PARAM_FILE] [-q N]
                               PAF

Group linked reads simulated from long reads into molecules. Read a PAF file
and output a BED file.

positional arguments:
  PAF                   Input PAF file, - for stdin

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o FILE, --output FILE
                        Output molecule BED file [stdout]
  -d N, --dist N        Maximum distance between reads in the same molecule
                        [50000]
  -m N, --reads N       Minimum number of reads per molecule (duplicates
                        filtered out) [4]
  -s N, --size N        Minimum molecule size [2000]
  -p PARAM_FILE, --params PARAM_FILE
  -q N, --mapq N        Minimum mapping quality [0]
```

