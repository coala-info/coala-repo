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


## methphaser_meth_phaser_post_processing

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
- **Homepage**: https://github.com/treangenlab/methphaser
- **Package**: https://anaconda.org/channels/bioconda/packages/methphaser/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.10/argparse.py", line 1866, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/local/lib/python3.10/argparse.py", line 2079, in _parse_known_args
    start_index = consume_optional(start_index)
  File "/usr/local/lib/python3.10/argparse.py", line 1987, in consume_optional
    raise ArgumentError(action, msg % explicit_arg)
argparse.ArgumentError: argument -h/--help: ignored explicit argument 'elp'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/meth_phaser_post_processing", line 701, in <module>
    main(sys.argv[1:])
  File "/usr/local/bin/meth_phaser_post_processing", line 605, in main
    args = parse_arg(argv)
  File "/usr/local/bin/meth_phaser_post_processing", line 98, in parse_arg
    args = parser.parse_args(argv)
  File "/usr/local/lib/python3.10/argparse.py", line 1833, in parse_args
    args, argv = self.parse_known_args(args, namespace)
  File "/usr/local/lib/python3.10/argparse.py", line 1869, in parse_known_args
    self.error(str(err))
  File "/usr/local/lib/python3.10/argparse.py", line 2592, in error
    self.print_usage(_sys.stderr)
  File "/usr/local/lib/python3.10/argparse.py", line 2562, in print_usage
    self._print_message(self.format_usage(), file)
  File "/usr/local/lib/python3.10/argparse.py", line 2528, in format_usage
    return formatter.format_help()
  File "/usr/local/lib/python3.10/argparse.py", line 283, in format_help
    help = self._root_section.format_help()
  File "/usr/local/lib/python3.10/argparse.py", line 214, in format_help
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 214, in <listcomp>
    item_help = join([func(*args) for func, args in self.items])
  File "/usr/local/lib/python3.10/argparse.py", line 338, in _format_usage
    assert ' '.join(opt_parts) == opt_usage
AssertionError
```

