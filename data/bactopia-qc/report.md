# bactopia-qc CWL Generation Report

## bactopia-qc

### Tool Description
Splits paired-end reads into separate files for read 1, read 2, and unpaired reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
- **Homepage**: https://bactopia.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bactopia-qc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bactopia-qc/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bactopia/bactopia-qc
- **Stars**: N/A
### Original Help Text
```text
java -ea -Xmx34970m -cp /usr/local/opt/bbmap-39.08-0/current/ jgi.SplitPairsAndSingles rp in= in2= out=repair-r1.fq out2=repair-r2.fq outs=repair-singles.fq ain=!{params.ain}
Executing jgi.SplitPairsAndSingles [rp, in=, in2=, out=repair-r1.fq, out2=repair-r2.fq, outs=repair-singles.fq, ain=!{params.ain}]

Exception in thread "main" java.lang.RuntimeException: Error - at least one input file is required.
	at jgi.SplitPairsAndSingles.<init>(SplitPairsAndSingles.java:149)
	at jgi.SplitPairsAndSingles.main(SplitPairsAndSingles.java:37)
cp: missing destination file operand after 'results/--help_R1.error-fastq.gz'
Try 'cp --help' for more information.
cp: missing destination file operand after 'results/--help_R2.error-fastq.gz'
Try 'cp --help' for more information.
pigz: skipping: repair-singles.fq does not exist
```

