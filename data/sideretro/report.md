# sideretro CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sideretro_make-vcf | PASS | synthetic data: planted read pairs and a synthetic parental exon; the database came from sider process-sample and merge-call run in one container |
| sideretro_merge-call | Not completed | genotype step re-opens the BAM by the absolute path saved by process-sample, which changes between cwltool jobs; works only inside one container |
| sideretro_process-sample | PASS |  |

## sideretro_process-sample

### Tool Description
Extract alignments related to an event of retrocopy and write a SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
- **Homepage**: https://github.com/galantelab/sideRETRO
- **Package**: https://anaconda.org/channels/bioconda/packages/sideretro/overview
- **Validation**: PASS

### Original Help Text
```text
sideRETRO 1.1.6

Usage: sider process-sample [-h] [-q] [-d] [-s] [-l FILE] [-o DIR]
                            [-p STR] [-t INT] [-c INT] [-Q INT]
                            [-m INT] [-f FLOAT] [-F FLOAT | -r]
                            [-D] [-M FLOAT] [-e] [-i FILE]
                            -a FILE <FILE> ...

Extract alignments related to event of retrocopy

Examples:
   $ sider ps -l ps.log -a gencode.gff3.gz -o result in.bam
   $ sider ps -t 3 -a gencode.gtf in1.bam in2.sam in3.bam
   $ sider ps -t 5 -m 15000 -Q 20 -F 0.9 -a exon.gtf -i list.txt

Output:
   A SQLite3 database that can be processed at 'merge-call' step

Arguments:
   One or more alignment file in SAM/BAM/CRAM format

Mandatory Options:
   -a, --annotation-file   Gene annotation on the reference genome
                           in GTF/GFF3 format. sider will look for 'exon'
                           with the attribute 'transcript_type=protein_coding'.
                           The attributes 'gene_name', 'gene_id' and 'exon_id'
                           are also required
   -i, --input-file        File containing a newline separated list of
                           alignment files in SAM/BAM/CRAM format.
                           This option is not mandatory if one or more
                           SAM/BAM/CRAM files are passed as argument.
                           If 'input-file' and arguments are set
                           concomitantly, then the union of all alignment
                           files is used

Input/Output Options:
   -h, --help              Show help options
   -q, --quiet             Decrease verbosity to error messages only
                           or suppress terminal outputs at all if
                           'log-file' is passed
       --silent            Same as '--quiet'
   -d, --debug             Increase verbosity to debug level
   -l, --log-file          Print log messages to a file
   -o, --output-dir        Output directory. Create the directory if it does
                           not exist [default:"."]
   -p, --prefix            Prefix output files [default:"out"]

SQLite3 Options:
   -c, --cache-size        Set SQLite3 cache size in KiB [default:"200000"]

Read Quality Options:
   -Q, --phred-quality     Minimum mapping quality of the reads required
                           [default:"8"]
   -M, --max-base-freq     Maximum base frequency fraction allowed
                           [default:"0.75"]
   -D, --deduplicate       Remove duplicated reads. Reads are considered
                           duplicates when they share the 5 prime positions
                           of both reads and read-pairs

Processing Options:
   -s, --sorted            Assume all reads are grouped by queryname, even if
                           there is no SAM/BAM/CRAM header tag 'SO:queryname'
   -t, --threads           Number of threads [default:"1"]
   -m, --max-distance      Maximum distance allowed between paired-end reads
                           [default:"10000"]
   -f, --exon-frac         Minimum overlap required as a fraction of exon
                           [default:"1e-09"; 1 base]
   -F, --alignment-frac    Minimum overlap required as a fraction of
                           alignment [default:"1e-09"; 1 base]
   -e, --either            The minimum fraction must be satisfied for at least
                           exon OR alignment. Without '-e', both fractions would
                           have to be satisfied
   -r, --reciprocal        The fraction overlap must be reciprocal for exon and
                           alignment. If '-f' is 0.5, then '-F' will be set to
                           0.5 as well
```

## sideretro_merge-call

### Tool Description
Discover and annotate retrocopies from SQLite3 databases made by process-sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
- **Homepage**: https://github.com/galantelab/sideRETRO
- **Package**: https://anaconda.org/channels/bioconda/packages/sideretro/overview
- **Validation**: PASS

### Original Help Text
```text
sideRETRO 1.1.6

Usage: sider merge-call [-h] [-q] [-d] [-l FILE] [-o DIR] [-p STR]
                        [-c INT] [-I] [-e INT] [-m INT] [-b STR]
                        [-B FILE] [[-T STR] [[-H|S] KEY=VALUE]]
                        [-P INT] [-x INT] [-g INT] [-n INT]
                        [-t INT] [-Q INT] [-i FILE]
                        <FILE> ...

Discover and annotate retrocopies

Examples:
   $ sider mc -l mc.log -I in.db
   $ sider mc -e 500 -m 20 -p in1_plus_in2 in1.db in2.db
   $ sider mc -b chrY -B gencode.gff3 -t 10 -Q 20 -i list.txt

Output:
   Annotate all retrocopies at the first input SQLite3 database
   or generate a new one with all results. Next run 'make-vcf'

Arguments:
   One or more SQLite3 databases generated in the 'process-sample' step

Mandatory Options:
   -i, --input-file           File containing a newline separated list of
                              SQLite3 databases to be processed. This
                              option is not mandatory if one or more
                              SQLite3 databases are passed as argument.
                              If 'input-file' and arguments are set
                              concomitantly, then the union of all files
                              is used

Input/Output Options:
   -h, --help                 Show help options
   -q, --quiet                Decrease verbosity to error messages only
                              or suppress terminal outputs at all if
                              'log-file' is passed
       --silent               Same as '--quiet'
   -d, --debug                Increase verbosity to debug level
   -l, --log-file             Print log messages to a file
   -o, --output-dir           Output directory. Create the directory if it does
                              not exist [default:"."]
   -p, --prefix               Prefix output files [default:"out"]
   -I, --in-place             Merge all databases with the first one of the list,
                              instead of creating a new file

SQLite3 Options:
   -c, --cache-size           Set SQLite3 cache size in KiB [default:"200000"]

Clustering Options:
   -e, --epsilon              DBSCAN: Maximum distance between two alignments
                              inside a cluster [default:"300"]
   -m, --min-pts              DBSCAN: Minimum number of points required to form a
                              dense region [default:"10"]

Filter & Annotation Options:
   -b, --blacklist-chr        Avoid clustering from and to this chromosome. This
                              option can be passed multiple times [default:"chrM"]
   -B, --blacklist-region     GTF/GFF3/BED blacklisted regions. If the file is in
                              GTF/GFF3 format, the user may indicate the 'feature'
                              (third column), the 'attribute' (ninth column) and
                              its values
   -P, --blacklist-padding    Increase the blacklisted regions ranges (left and right)
                              by N bases [default:"0"]
   -T, --gff-feature          The value of 'feature' (third column) for GTF/GFF3
                              file [default:"gene"]
   -H, --gff-hard-attribute   The 'attribute' (ninth column) for GTF/GFF3
                              file. It may be passed in the format key=value
                              (e.g. gene_type=pseudogene). Each value will match
                              as regex, so 'pseudogene' can capture IG_C_pseudogene,
                              IG_V_pseudogene etc. This option can be passed multiple
                              times and must be true in all of them
   -S, --gff-soft-attribute   Works as 'gff-hard-attribute'. The difference is
                              if this option is passed multiple times, it needs
                              to be true only once
                              [default:"gene_type=processed_pseudogene tag=retrogene"]
   -x, --parental-distance    Minimum distance allowed between a cluster and
                              its putative parental gene [default:"1000000"]
   -g, --genotype-support     Minimum number of reads coming from a given source
                              (SAM/BAM/CRAM) within a cluster [default:"1"]
   -n, --near-gene-rank       Minimum ranked distance between genes in order to
                              consider them close [default:"3"]

Genotyping Options:
   -t, --threads              Number of threads [default:"1"]
   -Q, --phred-quality        Minimum mapping quality used to define reference
                              allele reads [default:"8"]
```

## sideretro_make-vcf

### Tool Description
Generate a VCF file with all annotated retrocopies.

### Metadata
- **Docker Image**: quay.io/biocontainers/sideretro:1.1.6--hb728cf0_0
- **Homepage**: https://github.com/galantelab/sideRETRO
- **Package**: https://anaconda.org/channels/bioconda/packages/sideretro/overview
- **Validation**: PASS

### Original Help Text
```text
sideRETRO 1.1.6

Usage: sider make-vcf [-h] [-q] [-d] [-s] [-l FILE] [-o DIR]
                      [-p STR] [-n INT] [-e FLOAT]
                      [-r FILE] <FILE>

Generate VCF file with all annotated retrocopies

Examples:
   $ sider vcf in.db
   $ sider vcf -r hg38.fa -o result in.db

Output:
   A VCF file

Arguments:
   SQLite3 database generated at 'process-sample'
   and 'merge-call' steps

Input/Output Options:
   -h, --help                 Show help options
   -q, --quiet                Decrease verbosity to error messages only
                              or suppress terminal outputs at all if
                              'log-file' is passed
       --silent               Same as '--quiet'
   -d, --debug                Increase verbosity to debug level
   -l, --log-file             Print log messages to a file
   -o, --output-dir           Output directory. Create the directory if it does
                              not exist [default:"."]
   -p, --prefix               Prefix output files [default:"out"]

Filter & Annotation Options:
   -n, --near-gene-dist       Minimum distance between genes in order to
                              consider them close [default:"10000"]
   -e, --orientation-error    Maximum error allowed for orientation rho
                              [default:"0.05"]
   -r, --reference-file       FASTA file for the reference genome
```

