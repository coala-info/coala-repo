# methphaser CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| methphaser_meth_phaser_parallel | PASS | real ONT R10 HLA reads, phased VCF and block GTF from the MethPhaser Zenodo set (chr6:30.70-30.95 Mb subset); block relationships written |
| methphaser_meth_phaser_post_processing | PASS | same subset; re-phased VCF and methylation-tagged BAM written, blocks merged |

## methphaser_meth_phaser_parallel

### Tool Description
methphaser: phase reads based on methlytion informaiton

### Metadata
- **Docker Image**: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
- **Homepage**: https://github.com/treangenlab/methphaser
- **Package**: https://anaconda.org/channels/bioconda/packages/methphaser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methphaser/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/treangenlab/methphaser
- **Stars**: N/A
### Original Help Text
```text
usage: meth_phaser_parallel [-h] -b BAM_FILE -r REFERENCE -g GTF -vc
                            VCF_CALLED [-vt VCF_TRUTH] [-t THREADS]
                            [-ml MAX_LEN] [-c CUT_OFF] [-a ASSIGNMENT_MIN]
                            [-o OUTPUT_DIR] [-k K_ITERATIONS]

methphaser: phase reads based on methlytion informaiton

options:
  -h, --help            show this help message and exit
  -vt VCF_TRUTH, --vcf_truth VCF_TRUTH
                        Truth vcf file for benchmarking
  -t THREADS, --threads THREADS
                        threads
  -ml MAX_LEN, --max_len MAX_LEN
                        maximum homozygous region length for phasing, default:
                        -1 (ignore the largest homozygous region, centromere),
                        input -2 for not skipping anything
  -c CUT_OFF, --cut_off CUT_OFF
                        the minimum percentage of vote to determine a read's
                        haplotype
  -a ASSIGNMENT_MIN, --assignment_min ASSIGNMENT_MIN
                        minimum assigned read number for ranksum test
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        output_directory
  -k K_ITERATIONS, --k_iterations K_ITERATIONS
                        use at most k iterations, use -1 for unlimited
                        iterations.

Required arguments:
  -b BAM_FILE, --bam_file BAM_FILE
                        input methylation annotated bam file
  -r REFERENCE, --reference REFERENCE
                        reference genome
  -g GTF, --gtf GTF     gtf file from whatshap visualization
  -vc VCF_CALLED, --vcf_called VCF_CALLED
                        called vcf file from HapCUT2
```

## methphaser_meth_phaser_post_processing

### Tool Description
methphaser: use the block relationships from meth_phaser_parallel to write a re-phased VCF file and methylation-tagged BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
- **Homepage**: https://github.com/treangenlab/methphaser
- **Package**: https://anaconda.org/channels/bioconda/packages/methphaser/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meth_phaser_post_processing [-h] -ib -if -ov -ob -vc [-t] [-vt] [-hs] [-mc] [-vd]

methphaser: phase reads based on methlytion informaiton

Required arguments:
  -ib, --input_bam_file         input SNP-phased bam file
  -if, --meth_phasing_input_folder  meth phasing input folder
  -ov, --output_vcf             output VCF file location
  -ob, --output_bam             output BAM file (without .bam suffix)
  -vc, --vcf_called             SNP-phased VCF file
  -t, --threads                 threads, default 1

options:
  -vt, --vcf_truth              truth VCF provided by GIAB
  -hs, --high_success_rate_param  Enable high success rate parameter
  -mc, --minimum_coverage       Minimum read number to assign blocks' relationship. default: 0.
  -vd, --voting_difference      minimum voting difference for relationship assignment, default=0.5
```
