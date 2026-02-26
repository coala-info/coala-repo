# rmats CWL Generation Report

## rmats_rmats.py

### Tool Description
rMATS-turbo

### Metadata
- **Docker Image**: quay.io/biocontainers/rmats:4.3.0--py311hf2f0b74_5
- **Homepage**: http://rnaseq-mats.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/rmats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rmats/overview
- **Total Downloads**: 78.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: rmats.py [options]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --gtf GTF             An annotation of genes and transcripts in GTF format
  --b1 B1               A text file containing a comma separated list of the
                        BAM files for sample_1. (Only if using BAM)
  --b2 B2               A text file containing a comma separated list of the
                        BAM files for sample_2. (Only if using BAM)
  --s1 S1               A text file containing a comma separated list of the
                        FASTQ files for sample_1. If using paired reads the
                        format is ":" to separate pairs and "," to separate
                        replicates. (Only if using fastq)
  --s2 S2               A text file containing a comma separated list of the
                        FASTQ files for sample_2. If using paired reads the
                        format is ":" to separate pairs and "," to separate
                        replicates. (Only if using fastq)
  --od OD               The directory for final output from the post step
  --tmp TMP             The directory for intermediate output such as ".rmats"
                        files from the prep step
  -t {paired,single}    Type of read used in the analysis: either "paired" for
                        paired-end data or "single" for single-end data.
                        Default: paired
  --libType {fr-unstranded,fr-firststrand,fr-secondstrand}
                        Library type. Use fr-firststrand or fr-secondstrand
                        for strand-specific data. Only relevant to the prep
                        step, not the post step. Default: fr-unstranded
  --readLength READLENGTH
                        The length of each read. Required parameter, with the
                        value set according to the RNA-seq read length
  --variable-read-length
                        Allow reads with lengths that differ from --readLength
                        to be processed. --readLength will still be used to
                        determine IncFormLen and SkipFormLen
  --anchorLength ANCHORLENGTH
                        The "anchor length" or "overhang length" used when
                        counting the number of reads spanning splice
                        junctions. A minimum number of "anchor length"
                        nucleotides must be mapped to each end of a given
                        splice junction. The minimum value is 1 and the
                        default value is set to 1 to make use of all possible
                        splice junction reads.
  --tophatAnchor TOPHATANCHOR
                        The "anchor length" or "overhang length" used in the
                        aligner. At least "anchor length" nucleotides must be
                        mapped to each end of a given splice junction. The
                        default is 1. (Only if using fastq)
  --bi BINDEX           The directory name of the STAR binary indices (name of
                        the directory that contains the suffix array file).
                        (Only if using fastq)
  --nthread NTHREAD     The number of threads. The optimal number of threads
                        should be equal to the number of CPU cores. Default: 1
  --tstat TSTAT         The number of threads for the statistical model. If
                        not set then the value of --nthread is used
  --cstat CSTAT         The cutoff splicing difference. The cutoff used in the
                        null hypothesis test for differential alternative
                        splicing. The default is 0.0001 for 0.01% difference.
                        Valid: 0 <= cutoff < 1. Does not apply to the paired
                        stats model
  --task {prep,post,both,inte,stat}
                        Specify which step(s) of rMATS-turbo to run. Default:
                        both. prep: preprocess BAM files and generate .rmats
                        files. post: load .rmats files into memory, detect and
                        count alternative splicing events, and calculate P
                        value (if not --statoff). both: prep + post. inte
                        (integrity): check that the BAM filenames recorded by
                        the prep task(s) match the BAM filenames for the
                        current command line. stat: run statistical test on
                        existing output files
  --statoff             Skip the statistical analysis
  --paired-stats        Use the paired stats model
  --darts-model         Use the DARTS statistical model
  --darts-cutoff DARTS_CUTOFF
                        The cutoff of delta-PSI in the DARTS model. The output
                        posterior probability is P(abs(delta_psi) > cutoff).
                        The default is 0.05
  --novelSS             Enable detection of novel splice sites (unannotated
                        splice sites). Default is no detection of novel splice
                        sites
  --mil MIL             Minimum Intron Length. Only impacts --novelSS
                        behavior. Default: 50
  --mel MEL             Maximum Exon Length. Only impacts --novelSS behavior.
                        Default: 500
  --allow-clipping      Allow alignments with soft or hard clipping to be used
  --fixed-event-set FIXED_EVENT_SET
                        A directory containing fromGTF.[AS].txt files to be
                        used instead of detecting a new set of events
  --individual-counts   Output individualCounts.[AS_Event].txt files and add
                        the individual count columns to [AS_Event].MATS.JC.txt
```

