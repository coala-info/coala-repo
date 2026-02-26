# bwameth CWL Generation Report

## bwameth_bwameth.py

### Tool Description
map bisulfite converted reads to an insilico converted genome using bwa mem.

### Metadata
- **Docker Image**: quay.io/biocontainers/bwameth:0.20--py35_0
- **Homepage**: https://github.com/brentp/bwa-meth
- **Package**: https://anaconda.org/channels/bioconda/packages/bwameth/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bwameth/overview
- **Total Downloads**: 50.0K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/brentp/bwa-meth
- **Stars**: N/A
### Original Help Text
```text
usage: 
map bisulfite converted reads to an insilico converted genome using bwa mem.
A command to this program like:

    python bwameth.py --reference ref.fa A.fq B.fq

Gets converted to:

    bwa mem -pCMR ref.fa.bwameth.c2t '<python bwameth.py c2t A.fq B.fq'

So that A.fq has C's converted to T's and B.fq has G's converted to A's
and both are streamed directly to the aligner without a temporary file.
The output is a corrected, sorted, indexed BAM.

       [-h] --reference REFERENCE [-t THREADS] [--read-group READ_GROUP]
       [--set-as-failed {f,r}] [--version]
       fastqs [fastqs ...]

positional arguments:
  fastqs                bs-seq fastqs to align. Runmultiple sets separated by
                        commas, e.g. ... a_R1.fastq,b_R1.fastq
                        a_R2.fastq,b_R2.fastq note that the order must be
                        maintained.

optional arguments:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        reference fasta
  -t THREADS, --threads THREADS
  --read-group READ_GROUP
                        read-group to add to bam in same format as to bwa:
                        '@RG\tID:foo\tSM:bar'
  --set-as-failed {f,r}
                        flag alignments to this strand as not passing QC
                        (0x200). Targetted BS-Seq libraries are often to a
                        single strand, so we can flag them as QC failures.
                        Note f == OT, r == OB. Likely, this will be 'f' as we
                        will expect reads to align to the original-bottom (OB)
                        strand and will flag as failed those aligning to the
                        forward, or original top (OT).
  --version             show program's version number and exit
```

