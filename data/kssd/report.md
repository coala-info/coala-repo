# kssd CWL Generation Report

## kssd_shuffle

### Tool Description
The shuffle doc prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/kssd:2.21--h577a1d6_3
- **Homepage**: https://github.com/yhg926/public_kssd
- **Package**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yhg926/public_kssd
- **Stars**: N/A
### Original Help Text
```text
Usage: kssd shuffle [OPTION...]

The shuffle doc prefix.

  -k, --halfKmerLen=INT      a half of the length of k-mer. For proyakat
                             genome, k = 8 is suggested; for mammals, k = 10 or
                             11 is suggested.[8]

  -s, --halfSubstrLen=INT    a half of the length of k-mer substring. [5]

  -l, --level=INT            the level of dimensionality reduction, the
                             expectation dimensionality reduction rate is 16^n
                             if set -l = n. [2]

  -o, --outfile=STRING       specify the output file name prefix, if not
                             specify default shuffle named 'default.shuf
                             generated'

      --usedefault           All options use default value, which assuming
                             prokaryote genomes, k=8, s=5, and l=2.

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

The shuffle doc suffix.

Report bugs to yhg926@gmail.com.
```


## kssd_dist

### Tool Description
The dist doc prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/kssd:2.21--h577a1d6_3
- **Homepage**: https://github.com/yhg926/public_kssd
- **Package**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kssd dist [OPTION...] [-r <refernce>] [<query>]

The dist doc prefix.

  -A, --abundance            abundance estimate mode.

      --byread               sketch the file by read[false].

      --correction=0/1       perform correction for shared k-mer counts or not
                             .[0]

  -D, --mutDist_max=FLT      max mutation allowed for distance output.[1]

  -f, --skf=<skfpath>        share_kmer_ct file path.

      --keepcofile           keep intermedia .co files.

      --keepskf              turn on share_kmer_ct file keep mode.[false]

  -k, --halfKmerlength=INT   set half Kmer length: 2-15 [8]

  -l, --list=file            a file contain paths for all query sequences

  -L, --DimRdcLevel=INT      Dimension Reduction Level or provide .shuf
                             file[2]

  -m, --maxMemory=NUM        maximal memory (in G) usage allowed

  -M, --metric=0/1           output metrics: 0: Jaccard/1: Containment [0]

  -n, --LstKmerOcrs=INT      Specify the Least Kmer occurence in fastq file

  -N, --neighborN_max=INT    max number of nearest reference genomes.[1]

  -o, --outdir=<path>        folder path for results files.

  -O, --outfields=0/1/2      output fields(latter includes former):
                             Distance/Q-values/Confidence Intervels.[2]

  -p, --threadN=INT          set threads number [all threads]

  -P, --pipecmd=<cmd>        pipe command.

  -Q, --quality=INT          Filter Kmer with lowest base quality < q
                             (Phred).[0]

  -r, --reference_dir=<path> reference genome/database search against.

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

The dist doc suffix.

Report bugs to yhg926@gmail.com.
```


## kssd_set

### Tool Description
The set doc prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/kssd:2.21--h577a1d6_3
- **Homepage**: https://github.com/yhg926/public_kssd
- **Package**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kssd set [OPTION...] <combined sketch>

The set doc prefix.

  -u, --union                get union set of the sketches.

  -i, --intsect=<pan>        intersect with the pan-sketch for all input
                             sketches.

  -s, --subtract=<pan>       subtract the pan-sketch from all input sketches.

  -q, --uniq_union           get uniq union set of the sketches.

  -c, --combin_pan           combine pan files to combco file.

  -g, --grouping=<file.tsv>  grouping genomes by input category file.

  -p, --threads=<INT>        number of threads.

  -P, --print                print genome names.

  -o, --outdir=<path>        specify the output directory.

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

The set doc suffix.

Report bugs to yhg926@gmail.com.
```


## kssd_reverse

### Tool Description
The reverse doc prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/kssd:2.21--h577a1d6_3
- **Homepage**: https://github.com/yhg926/public_kssd
- **Package**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kssd reverse [OPTION...] <co dir>

The reverse doc prefix.

  -b, --byreads              recover k-mer from sketched reads .

  -L, --shufFile=<path>      provide .shuf file.

  -o, --outdir=<path>        path for recovered k-mer files.

  -p, --threads=INT          threads num.

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

The reverse doc suffix.

Report bugs to yhg926@gmail.com.
```


## kssd_composite

### Tool Description
The composite doc prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/kssd:2.21--h577a1d6_3
- **Homepage**: https://github.com/yhg926/public_kssd
- **Package**: https://anaconda.org/channels/bioconda/packages/kssd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kssd composite [OPTION...]

The composite doc prefix.

  -r, --ref=<DIR>            Path of species specific pan uniq kmer database
                             (reference) 

  -q, --query=<DIR>          Path of query sketches with abundances 

  -o, --outfile=<DIR>        Output path 

  -p, --threads=<INT>        Threads number to use 

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

The composite doc suffix.

Report bugs to yhg926@gmail.com.
```


## Metadata
- **Skill**: generated
