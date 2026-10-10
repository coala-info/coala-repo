# mirge CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mirge_annotate | Failed | image problem: bowtie, samtools and RNAfold are not in the image ('bowtie can't be found'), so miRge2.0 cannot run; new CWL written from the help |
| mirge_predict | Failed | image problem: bowtie, samtools and RNAfold are not in the image, so miRge2.0 cannot run; new CWL written from the help (not run) |


## mirge_annotate

### Tool Description
Annotate the reads from miRNA sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/mirge:2.0.6--py27_4
- **Homepage**: https://github.com/mhalushka/miRge
- **Package**: https://anaconda.org/channels/bioconda/packages/mirge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

Usage: miRge2.0 annotate [-h] [<args>]

Example:
miRge2.0 annotate -s seq_file.fastq -d miRBase -pb /home/yin/tools/bowtie-1.1.1 -lib /home/yin/miRge.Libs -sp human -ad illumina -ai -gff -trf -cpu 4

optional arguments:
  -h, --help            show this help message and exit
  -s [sample <required> [sample <required> ...]]
                        two options: 1. A file where each row represents one
                        sample name; 2. *.fastq *.fastq ... Or *.fastq.gz
                        *.fastq.gz ...
  -o <dir>              the directory of the outputs (default: current
                        directory)
  -d <string required>  the miRNA database (default: miRBase. miRGeneDB is
                        optional)
  -pb <dir required>    the path to the system's bowtie binary
  -lib <dir required>   the path to the miRge libraries
  -sp <string required>
                        the species can be human, mouse, fruitfly, nematode,
                        rat and zebrafish (novel miRNA detection is confined
                        in human and mouse)
  -ex <float>           the threshold of the proportion of canonical reads for
                        the miRNAs to determine whether keeping them or not
                        when counting. Users can set it between 0 and 0.5.
                        (default: 0.1)
  -ad <string>          the adapter need to be removed which could be
                        illumina, ion or a defined sequence (default: none)
  -phred64              phred64 format (default: 64)
  -spikeIn              switch to annotate spike-ins if the bowtie index files
                        are loacted at the path of bowtie's index files
                        (default: off)
  -tcf                  switch to write trimmed and collapsed fasta file
                        (default: off)
  -di                   switch to calculate of isomirs entropy (default: off)
  -cpu <int>            the number of processors to use for trimming, qc, and
                        alignment (default: 1)
  -ai                   switch to calculate of A to I editing (default: off)
  -gff                  switch to output results in gff format (default: off)
  -trf                  switch to analyze tRNA fragment (default: off)
  --version             show program's version number and exit
```

## mirge_predict

### Tool Description
Detect novel miRNAs from miRNA sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/mirge:2.0.6--py27_4
- **Homepage**: https://github.com/mhalushka/miRge
- **Package**: https://anaconda.org/channels/bioconda/packages/mirge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

Usage: miRge2.0 predict [-h] [<args>]

Example:
miRge2.0 predict -s seq_file.fastq -d miRBase -pb /home/yin/tools/bowtie-1.1.1 -lib /home/yin/miRge.Libs -ps /usr/local/bin -pr /usr/local/bin -sp human -ad illumina -ai -gff -trf -cpu 4

optional arguments:
  -h, --help            show this help message and exit
  -s [sample <required> [sample <required> ...]]
                        two options: 1. A file where each row represents one
                        sample name; 2. *.fastq *.fastq ... Or *.fastq.gz
                        *.fastq.gz ...
  -o <dir>              the directory of the outputs (default: current
                        directory)
  -d <string required>  the miRNA database (default: miRBase. miRGeneDB is
                        optional)
  -pb <dir required>    the path to the system's bowtie binary
  -lib <dir required>   the path to the miRge libraries
  -sp <string required>
                        the species can be human, mouse, fruitfly, nematode,
                        rat and zebrafish (novel miRNA detection is confined
                        in human and mouse)
  -ps <dir required>    the path to the system's samtools binary
  -pr <dir required>    the path to the system's rnafold binary
  -ex <float>           the threshold of the proportion of canonical reads for
                        the miRNAs to determine whether keeping them or not
                        when counting. Users can set it between 0 and 0.5.
                        (default: 0.1)
  -ad <string>          the adapter need to be removed which could be
                        illumina, ion or a defined sequence (default: none)
  -phred64              phred64 format(default: 64)
  -spikeIn              switch to annotate spike-ins if the bowtie index files
                        are loacted at the path of bowtie's index files
                        (default: off)
  -tcf                  switch to write trimmed and collapsed fasta file
                        (default: off)
  -di                   switch to calculate of isomirs entropy (default: off)
  -cpu <int>            the number of processors to use for trimming, qc, and
                        alignment (default: 1)
  -ai                   switch to calculate of A to I editing (default: off)
  -gff                  switch to output results in gff format (default: off)
  -trf                  switch to analyze tRNA fragment (default: off)
  -ws <file>            the file containing the overall samples to analysis
                        for novel miRNA prediction. No header, just a list of
                        *.fastq file names in a column. Names of files can be
                        to your choosing (e.g. filestochecknovel.txt)
  -minl <int>           the minimum length of the reatined reads for novel
                        miRNA detection (default: 16)
  -maxl <int>           the maximum length of the reatined reads for novel
                        miRNA detection (default: 25)
  -cc <int>             the maximum read count of the reatined reads for novel
                        miRNA detection (default: 2)
  -ml <int>             the maximum number of mapping loci for the retained
                        reads for novel miRNA detection (default: 3)
  -sl <int>             the seed length when invoking Bowtie for novel miRNA
                        detection (default: 25)
  -olc <int>            the length of overlapped seqence when joining reads
                        into longer sequences based on the coordinate on the
                        genome for novel miRNA detection (default: 14)
  -clc <int>            the maximum length of the clustered sequences for
                        novel miRNA detection (default: 30)
  --version             show program's version number and exit
```
