# methphaser CWL Generation Report

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

