# greenhill CWL Generation Report

## greenhill

### Tool Description
greenhill version: 1.1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/greenhill:1.1.0--h663a4a6_3
- **Homepage**: https://github.com/ShunOuchi/GreenHill
- **Package**: https://anaconda.org/channels/bioconda/packages/greenhill/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/greenhill/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-11-28
- **GitHub**: https://github.com/ShunOuchi/GreenHill
- **Stars**: N/A
### Original Help Text
```text
greenhill version: 1.1.0
greenhill --help 


Usage: greenhill [Options]
Options:
    -o STR                             : prefix of output file (default out, length <= 200)
    -c FILE1 [FILE2 ...]               : contig_file (fasta format; for Haplotype-aware style input)
    -b FILE1 [FILE2 ...]               : bubble_seq_file (fasta format; for Haplotype-aware style input)
    -cph FILE1 [FILE2 ...]             : contig_file (fasta format; for Pseudo-haplotype or Mixed-haplotype style input; only effective without -c, -b option)
    -ip{INT} PAIR1 [PAIR2 ...]         : lib_id inward_pair_file (reads in 1 file, fasta or fastq)
    -IP{INT} FWD1 REV1 [FWD2 REV2 ...] : lib_id inward_pair_files (reads in 2 files, fasta or fastq)
    -op{INT} PAIR1 [PAIR2 ...]         : lib_id outward_pair_file (reads in 1 file, fasta or fastq)
    -OP{INT} FWD1 REV1 [FWD2 REV2 ...] : lib_id outward_pair_files (reads in 2 files, fasta or fastq)
    -p PAIR1 [PAIR2 ...]               : long-read file (PacBio, Nanopore) (reads in 1 file, fasta or fastq)
    -hic PAIR1 [PAIR2 ...]             : HiC_pair_files (reads in 1 file, fasta or fastq)
    -HIC FWD1 REV1 [FWD2 REV2 ...]     : HiC_pair_files (reads in 2 files, fasta or fastq)
    -n{INT} INT                        : lib_id minimum_insert_size
    -a{INT} INT                        : lib_id average_insert_size
    -d{INT} INT                        : lib_id SD_insert_size
    -e FLOAT                           : coverage depth of homozygous region (default auto)
    -L INT                             : maximum fragment length of tag (10x Genomics) (default 200000)
    -s INT1 [INT2 ...]                 : mapping seed length for short reads (default 32 64 96)
    -k INT                             : minimum number of links to phase variants (default 1)
    -l INT                             : minimum number of links to scaffold (default 3)
    -t INT                             : number of threads (<= 1, default 1)
    -mapper FILE                       : path of mapper executable file (default, minimap2; only effective with -p option)
    -minimap2_sensitive                : sensitive mode for minimap2 (default, off; only effective with -p option)
    -reduce_redundancy                 : reduce redundant sequences that exactly matche others (default, off)
    -tmp DIR                           : directory for temporary files (default .)


Input format:
    Uncompressed and compressed (gzip or bzip2) files are accepted for -c, -ip, -IP, -op, -OP, -p, -hic and -HIC options.


Final output:
    PREFIX_afterPhase.fa

Other misc outputs:
    PREFIX_*
```

