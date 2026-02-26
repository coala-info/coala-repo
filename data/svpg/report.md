# svpg CWL Generation Report

## svpg_call

### Tool Description
Call structural variants using SVPG

### Metadata
- **Docker Image**: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/coopsor/SVPG
- **Package**: https://anaconda.org/channels/bioconda/packages/svpg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svpg/overview
- **Total Downloads**: 289
- **Last updated**: 2026-01-20
- **GitHub**: https://github.com/coopsor/SVPG
- **Stars**: N/A
### Original Help Text
```text
usage: svpg call [-h] [--working_dir WORKING_DIR] [--bam BAM] [--ref REF]
                 [-o OUT] [--gfa GFA] [-t NUM_THREADS] [--read {hifi,ont}]
                 [--min_mapq MIN_MAPQ] [--min_sv_size MIN_SV_SIZE]
                 [--max_sv_size MAX_SV_SIZE]
                 [--max_merge_threshold MAX_MERGE_THRESHOLD]
                 [--ultra_split_size ULTRA_SPLIT_SIZE] [--alt_consensus]
                 [--noseq] [--realign] [-s MIN_SUPPORT] [--types TYPES]
                 [--contigs [CONTIGS ...]] [--skip_genotype]

options:
  -h, --help            show this help message and exit
  --working_dir WORKING_DIR
                        Specify the working directory to store output files.
  --bam BAM             Coordinate-sorted and indexed BAM file with aligned
                        long reads.
  --ref REF             The reference genome used for pangenome construction
                        (.fa), is also serves as the coordinate system for
                        SVPG’s SV call output.
  -o OUT, --out OUT     VCF output file name
  --gfa GFA             Pangenome reference file that the long reads were
                        aligned to (.gfa)
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads to use
  --read {hifi,ont}     Type of sequencing reads: `ont` for Oxford Nanopore,
                        `hifi` for PacBio HiFi.
  --min_mapq MIN_MAPQ   Minimum mapping quality for reads to be considered in
                        SV detection.
  --min_sv_size MIN_SV_SIZE
                        Minimum size of SVs to be detected.
  --max_sv_size MAX_SV_SIZE
                        Maximum SV size to detect include sequence
                        information. Set to -1 for unlimited size.
  --max_merge_threshold MAX_MERGE_THRESHOLD
                        Maximum distance of SV signals to be merged.
  --ultra_split_size ULTRA_SPLIT_SIZE
                        Ignore extremely large BNDs from split alignments
                        unless supported by high enough reads, which may be
                        regarded as false-negative intra-chromosomal
                        translocation
  --alt_consensus       Generate alternative allele consensus sequences for
                        insertion using pyabpoa.
  --noseq               Disable sequence extraction for SVs. Useful for ultra-
                        large SVs to save time and disk space.
  --realign             Realign the noise reads to the reference for more
                        accurate SV sequence inference
  -s MIN_SUPPORT, --min_support MIN_SUPPORT
                        Minimum read support threshold for SV calling. Adjust
                        based on sequencing depth.
  --types TYPES         SV types to include in output VCF (default:
                        DEL,INS,DUP,INV,BND). Give a comma-separated list of
                        SV types, like "DEL,INS"
  --contigs [CONTIGS ...]
                        Specify the chromosomes list to call SVs (e.g.,
                        --contigs chr1 chr2 chrX)
  --skip_genotype       Skip genotyping step to speed up the processing.
```


## svpg_graph-call

### Tool Description
Call structural variants (SVs) on a pangenome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/coopsor/SVPG
- **Package**: https://anaconda.org/channels/bioconda/packages/svpg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svpg graph-call [-h] [--working_dir WORKING_DIR] [--ref REF]
                       [--gfa GFA] [--gaf GAF] [-o OUT] [-t NUM_THREADS]
                       [--read READ] [--min_mapq MIN_MAPQ]
                       [--max_merge_threshold MAX_MERGE_THRESHOLD]
                       [--min_sv_size MIN_SV_SIZE] [--max_sv_size MAX_SV_SIZE]
                       [--ultra_split_size ULTRA_SPLIT_SIZE] [--alt_consensus]
                       [--noseq] [-s MIN_SUPPORT] [--types TYPES]
                       [--contigs [CONTIGS ...]]

options:
  -h, --help            show this help message and exit
  --working_dir WORKING_DIR
                        Specify the working directory to store output files.
  --ref REF             The reference genome used for pangenome construction
                        (.fa), is also serves as the coordinate system for
                        SVPG’s SV call output.
  --gfa GFA             Pangenome reference file that the long reads were
                        aligned to (.gfa)
  --gaf GAF             GAF file that aligns to the pangenome reference (.gaf)
  -o OUT, --out OUT     Specify the output file name.
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads to use for parallel processing.
  --read READ           Type of sequencing reads: `ont` for Oxford Nanopore,
                        `hifi` for PacBio HiFi.
  --min_mapq MIN_MAPQ   Minimum mapping quality for reads to be considered in
                        SV detection.
  --max_merge_threshold MAX_MERGE_THRESHOLD
                        Maximum distance of SV signals to be merged
  --min_sv_size MIN_SV_SIZE
                        Minimum size of SVs to be detected.
  --max_sv_size MAX_SV_SIZE
                        Maximum size of SVs to be detected. Set to -1 for
                        unlimited size (recommend somatic SV).
  --ultra_split_size ULTRA_SPLIT_SIZE
                        Ignore extremely large BNDs from split alignments
                        unless supported by high enough reads, which may be
                        regarded as false-negative intra-chromosomal
                        translocation
  --alt_consensus       Generate alternative allele consensus sequences for
                        insertion using pyabpoa.
  --noseq               Disable sequence extraction for SVs. Useful for ultra-
                        large SVs to save time and disk space.
  -s MIN_SUPPORT, --min_support MIN_SUPPORT
                        Minimum read support threshold for SV calling. Adjust
                        based on sequencing depth.
  --types TYPES         SV types to include in output VCF (default:
                        DEL,INS,DUP,INV,BND). Give a comma-separated list of
                        SV types, like "DEL,INS"
  --contigs [CONTIGS ...]
                        Specify the chromosomes list to call SVs (e.g.,
                        --contigs chr1 chr2 chrX)
```


## svpg_augment

### Tool Description
Augment a pangenome graph with SV calls from sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/coopsor/SVPG
- **Package**: https://anaconda.org/channels/bioconda/packages/svpg/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svpg augment [-h] [--working_dir WORKING_DIR] [--ref REF] [--gfa GFA]
                    [-o OUT] [--vcf_out VCF_OUT] [-t NUM_THREADS]
                    [--read READ] [--sample_list SAMPLE_LIST]
                    [--min_mapq MIN_MAPQ] [--min_sv_size MIN_SV_SIZE]
                    [--max_sv_size MAX_SV_SIZE] [--skip_call]

options:
  -h, --help            show this help message and exit
  --working_dir WORKING_DIR
                        Specify the working directory to store output files.
  --ref REF             The reference genome used for pangenome construction
                        (.fa), is also serves as the coordinate system for
                        SVPG’s SV call output.
  --gfa GFA             Pangenome reference file that the long reads were
                        aligned to (.gfa)
  -o OUT, --out OUT     Augmented GFA output file name
  --vcf_out VCF_OUT     VCF output file name
  -t NUM_THREADS, --num_threads NUM_THREADS
                        Number of threads to use for parallel processing.
  --read READ           Type of sequencing reads: `ont` for Oxford Nanopore,
                        `hifi` for PacBio HiFi.
  --sample_list SAMPLE_LIST
                        Path to a TSV file listing the paths to FASTA files of
                        new samples. if not provided, all FASTA files under
                        `working_dir` will be processed. For example, the
                        sample.tsv file may look like(sample_1 name ≠ sample_2
                        name): /path/to/sample_1.fasta /path/to/sample_2.fasta
  --min_mapq MIN_MAPQ   Minimum mapping quality for reads to be considered in
                        SV detection.
  --min_sv_size MIN_SV_SIZE
                        Minimum size of SVs to be detected.
  --max_sv_size MAX_SV_SIZE
                        Minimum size of SVs to be detected. Set to -1 for
                        unlimited size (recommend somatic SV).
  --skip_call           Skip SV calling step and directly proceed to graph
                        augmentation using existing VCF files in the working
                        directory.
```

