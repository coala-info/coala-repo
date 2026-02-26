# targqc CWL Generation Report

## targqc

### Tool Description
TargQC, target coverage evaluation tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/targqc:1.8.1--py37hb3f55d8_0
- **Homepage**: https://github.com/vladsaveliev/TargQC
- **Package**: https://anaconda.org/channels/bioconda/packages/targqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/targqc/overview
- **Total Downloads**: 10.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vladsaveliev/TargQC
- **Stars**: N/A
### Original Help Text
```text
Usage: targqc *.bam -o targqc_stats [--bed target.bed ...]

TargQC, target coverage evaluation tool. Version 1.8.1

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --test=TEST           Quick test of correct installation.
  --bed=BED, --capture=BED, --amplicons=BED
                        BED file with regions to analyse. If not specified,
                        CDS across full genome will be analysed
  -o DIR, --output-dir=DIR
                        Output directory (or directory name in case of bcbio
                        final dir)
  -g GENOME, --genome=GENOME
                        Genome build (hg19 or hg38), used to pick genome
                        annotation BED file if not specified, or path to .fa
                        bwa prefix
  --bwa--bwa-prefix=BWA_PREFIX
                        Path to BWA index prefix to align if input is FastQ
  --fai=FAI             Path to fai fasta index - sort BAM and BED files, and
                        to get chromosome lengths for proper padding BED
                        files; optional
  --padding=PADDING     integer indicating the number of bases to extend each
                        target region up and down-stream. Default is 200
  -T DEPTH_THRESHOLDS, --depth-threshold=DEPTH_THRESHOLDS
  --downsample-pairs-num=DOWNSAMPLE_PAIRS_NUM, --downsample-to=DOWNSAMPLE_PAIRS_NUM
                        If input is FastQ, select N random read pairs from
                        each input set (instead of default fraction 0.05).
  --downsample-fraction=DOWNSAMPLE_FRACTION, --downsample=DOWNSAMPLE_FRACTION
                        If input is FastQ, select K% random read pairs from
                        each input set. Default is 0.05%. To turn off (align
                        all reads), set --downsample 1
  -t THREADS, --nt=THREADS, --threads=THREADS
                        Number of threads
  --reuse               reuse intermediate non-empty files in the work dir
                        from previous run
  -s SCHEDULER, --scheduler=SCHEDULER
                        Scheduler to use for ipython parallel
  -q QUEUE, --queue=QUEUE
                        Scheduler queue to run jobs on, for ipython parallel
  -r RESOURCES, --resources=RESOURCES
                        Cluster specific resources specifications. Can be
                        specified multiple times. Supports SGE, Torque, LSF
                        and SLURM parameters.
  --reannotate          Re-annotate BED file with gene names, even if it's 4
                        columns or more
```

