# metaplatanus CWL Generation Report

## metaplatanus

### Tool Description
metaplatanus version v1.3.1

### Metadata
- **Docker Image**: quay.io/biocontainers/metaplatanus:1.3.1--h6a68c12_1
- **Homepage**: https://github.com/rkajitani/metaplatanus
- **Package**: https://anaconda.org/channels/bioconda/packages/metaplatanus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaplatanus/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rkajitani/metaplatanus
- **Stars**: N/A
### Original Help Text
```text
metaplatanus version v1.3.1

Usage:
    metaplatanus [Options] -IP1 short_1.fastq(a) short_2.fastq(a) [-ont ont.fastq(a) ... -p pacbio.fastq(a) ...]

Options:
    -IP{INT} FWD1 REV1 [FWD2 REV2 ...] : lib_id inward_pair_files (reads in 2 files, fasta or fastq; at least one library required)
    -OP{INT} FWD1 REV1 [FWD2 REV2 ...] : lib_id outward_pair_files (reads in 2 files, fasta or fastq; aka mate-pairs or jumping-library)
    -binning_IP{INT} FWD1 REV1 ...     : lib_id inward_pair_files for binning process. (reads in 2 files, fasta or fastq; the data are usually from another sample)
    -p FILE1 [FILE2 ...]               : PacBio long-read file (fasta or fastq)
    -ont FILE1 [FILE2 ...]             : Oxford Nanopore long-read file (fasta or fastq)
    -x PAIR1 [PAIR2 ...]               : barcoded_pair_files (10x Genomics) (reads in 1 file, interleaved, fasta or fastq)
    -X FWD1 REV1 [FWD2 REV2 ...]       : barcoded_pair_files (10x Genomics) (reads in 2 files, fasta or fastq)
    -t INT                             : number of threads (<= 1; default, 1)
    -m INT                             : memory limit for making kmer distribution (unit, GB; default, 64)
    -o STR                             : prefix of output files (default "out")
    -tmp DIR                           : directory for temporary files (default, ".")
    -sub_bin DIR                       : directory for sub-executables, such as mata_plantaus and minimap2 (default, directory-of-this-script/sub_bin)
    -min_cov_contig INT                : k-mer coverage cutoff for contig-assembly of MetaPlatanus (default, 4 with MEGAHIT, 2 otherwise)
    -min_map_idt_binning FLOAT         : minimum identity (%) in read mapping for binning (default, 97)
    -no_megahit                        : do not perfom MEGAHIT assembly (default, off)
    -no_binning                        : do not perfom binning (default, off)
    -no_re_scaffold                    : do not perfom re-scaffolding (default, off)
    -no_tgsgapcloser                   : do not use TGS-GapCloser and NextPolish (default, off)
    -no_nextpolish                     : do not use NextPolish (default, off)
    -overwrite                         : overwrite the previous results, not re-start (default, off)
    -h, -help                          : display usage
    -v, -version                       : display version
```

