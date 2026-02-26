# clair3-trio CWL Generation Report

## clair3-trio_run_clair3_trio.sh

### Tool Description
Clair3-Trio v0.7

### Metadata
- **Docker Image**: quay.io/biocontainers/clair3-trio:0.7--py39hd649744_2
- **Homepage**: https://github.com/HKU-BAL/Clair3-Trio
- **Package**: https://anaconda.org/channels/bioconda/packages/clair3-trio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clair3-trio/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HKU-BAL/Clair3-Trio
- **Stars**: N/A
### Original Help Text
```text
Clair3-Trio v0.7
Usage: ./run_clair3_trio.sh --bam_fn_c=BAM --bam_fn_p1=BAM --bam_fn_p2=BAM --ref_fn=REF --output=OUTPUT_DIR --threads=THREADS --model_path_clair3=MODEL_PREFIX --model_path_clair3_trio=MODEL_PREFIX [--bed_fn=BED] [options]

Required parameters:
--bam_fn_c=FILE                BAM file input, for child. The input file must be samtools indexed.
--bam_fn_p1=FILE               BAM file input, for parent1. The input file must be samtools indexed.
--bam_fn_p2=FILE               BAM file input, for parent1. The input file must be samtools indexed.
--ref_fn=FILE                  FASTA reference file input. The input file must be samtools indexed.
--model_path_clair3=STR        The folder path containing a Clair3 model (requiring six files in the folder, including pileup.data-00000-of-00002, pileup.data-00001-of-00002 pileup.index, full_alignment.data-00000-of-00002, full_alignment.data-00001-of-00002  and full_alignment.index).
--model_path_clair3_trio=STR   The folder path containing a Clair3-Trio model (files structure same as Clair3).
-t, --threads=INT              Max #threads to be used. The full genome will be divided into small chunks for parallel processing. Each chunk will use 4 threads. The #chunks being processed simultaneously is ceil(#threads/4)*3. 3 is the overloading factor.
-o, --output=PATH              VCF/GVCF output directory.


Optional parameters (Use "=value" instead of " value". E.g., "--bed_fn=fn.bed" instead of "--bed_fn fn.bed".):
-v, --version                  Check Clair3-Trio version
-h, --help                     Check Clair3-Trio help page
--bed_fn=FILE                  Call variants only in the provided bed regions.
--vcf_fn=FILE                  Candidate sites VCF file input, variants will only be called at the sites in the VCF file if provided.
--ctg_name=STR                 The name of the sequence to be processed.
--pileup_only                  Use the pileup model only when calling, default: disable.
--pileup_phasing               Use the pileup model calling and phasing, default: disable.
--sample_name_c=STR            Define the sample name for Child to be shown in the VCF file.[Child]
--sample_name_p1=STR           Define the sample name for Parent1 to be shown in the VCF file.[Parent1]
--sample_name_p2=STR           Define the sample name for Parent2 to be shown in the VCF file.[Parent2]
--gvcf                         Enable GVCF output, default: disable.
--qual=INT                     If set, variants with >=$qual will be marked PASS, or LowQual otherwise.
--samtools=STR                 Path of samtools, samtools version >= 1.10 is required.
--python=STR                   Path of python, python3 >= 3.6 is required.
--pypy=STR                     Path of pypy3, pypy3 >= 3.6 is required.
--parallel=STR                 Path of parallel, parallel >= 20191122 is required.
--whatshap=STR                 Path of whatshap, whatshap >= 1.0 is required.
--chunk_size=INT               The size of each chuck for parallel processing, default: 5000000.
--print_ref_calls              Show reference calls (0/0) in VCF file, default: disable.
--include_all_ctgs             Call variants on all contigs, otherwise call in chr{1..22,X,Y} and {1..22,X,Y}, default: disable.
--snp_min_af=FLOAT             Minimum SNP AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.08,hifi:0.08,ilmn:0.08.
--indel_min_af=FLOAT           Minimum Indel AF required for a candidate variant. Lowering the value might increase a bit of sensitivity in trade of speed and accuracy, default: ont:0.15,hifi:0.08,ilmn:0.08.
--trio_model_prefix=STR        Model prefix in trio calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index, default: trio.
--enable_output_phasing        Output phased variants using whatshap, default: disable.
--enable_output_haplotagging   Output enable_output_haplotagging BAM variants using whatshap, default: disable.
--enable_phasing               It means `--enable_output_phasing`. The option is retained for backward compatibility.
--var_pct_full=FLOAT           EXPERIMENTAL: Specify an expected percentage of low quality 0/1 and 1/1 variants called in the pileup mode for full-alignment mode calling, default: 0.3.
--ref_pct_full=FLOAT           EXPERIMENTAL: Specify an expected percentage of low quality 0/0 variants called in the pileup mode for full-alignment mode calling, default:  0.1 .
--var_pct_phasing=FLOAT        EXPERIMENTAL: Specify an expected percentage of high quality 0/1 variants used in WhatsHap phasing, default: 0.8 for ont guppy5 and 0.7 for other platforms.
--pileup_model_prefix=STR      EXPERIMENTAL: Model prefix in pileup calling, including $prefix.data-00000-of-00002, $prefix.data-00001-of-00002 $prefix.index. default: pileup.
```

