# shortstack CWL Generation Report

## shortstack_ShortStack

### Tool Description
ShortStack is a tool for analyzing small RNA sequencing data, particularly for identifying and characterizing microRNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0
- **Homepage**: https://github.com/MikeAxtell/ShortStack
- **Package**: https://anaconda.org/channels/bioconda/packages/shortstack/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shortstack/overview
- **Total Downloads**: 36.5K
- **Last updated**: 2025-05-24
- **GitHub**: https://github.com/MikeAxtell/ShortStack
- **Stars**: N/A
### Original Help Text
```text
usage: ShortStack [-h] [--version] (--genomefile GENOMEFILE | --autotrim_only)
                  [--known_miRNAs KNOWN_MIRNAS]
                  (--readfile [READFILE ...] | --bamfile [BAMFILE ...])
                  [--outdir OUTDIR] [--adapter ADAPTER | --autotrim]
                  [--autotrim_key AUTOTRIM_KEY] [--threads THREADS]
                  [--mmap {u,f,r}] [--align_only] [--dicermin DICERMIN]
                  [--dicermax DICERMAX] [--locifile LOCIFILE | --locus LOCUS]
                  [--nohp] [--dn_mirna] [--strand_cutoff STRAND_CUTOFF]
                  [--mincov MINCOV] [--pad PAD] [--make_bigwigs]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --genomefile GENOMEFILE
                        FASTA file of the reference genome
  --autotrim_only       If this switch is set, ShortStack quits after
                        performing auto-trimming of input reads.
  --known_miRNAs KNOWN_MIRNAS
                        FASTA file of known/suspected mature microRNAs
  --readfile [READFILE ...]
                        One or more files of reads (fq, fa, gzip OK)
  --bamfile [BAMFILE ...]
                        One or more BAM alignment files
  --outdir OUTDIR       Output directory name. Defaults to ShortStack_time
  --adapter ADAPTER     3-primer adapter sequence to trim off ofreads. If
                        given applies to all input fastq files. Mutually
                        exclusive with --autotrim.
  --autotrim            If this switch is set, automatically discover the
                        3-prime adapter from each input readfile, and trim it.
                        This uses the sequence from --autotrim_key to discover
                        the adapter sequence. Mutually exlcusive with
                        --adapter.
  --autotrim_key AUTOTRIM_KEY
                        Sequence of an abundant, known small RNA to be used to
                        discover the 3-prime adapter sequence. Has no effect
                        unless --autotrim is specified. Defaults to
                        TCGGACCAGGCTTCATTCCCC (miR166). Can be upper or lower-
                        case, T or U and must be 20-30 bases long.
  --threads THREADS     Number of threads to use (integer) - default: 1
  --mmap {u,f,r}        Protocol for multi-mapped reads: u, f, or r - default:
                        u
  --align_only          If this switch is set, ShortStack quits after
                        performing alignments without any analyses performed.
  --dicermin DICERMIN   Minimum size of a valid Dicer-processed small RNA.
                        Must be integer >= 15 and <= dicermax. Default: 20.
  --dicermax DICERMAX   Maximum size of a valid Dicer-processed small RNA.
                        Must be integer >= 15 and <= dicermax. Default: 24.
  --locifile LOCIFILE   File listing intervals to analyze. Can be simple tab-
                        delimited, .bed, or .gff3. Tab-delimited format is
                        column 1 with coordinates Chr:start-stop, column 2
                        with names. Input file assumed to be simple tab-
                        delimited unless file name ends in .bed or .gff3.
                        Mutually exclusive with --locus.
  --locus LOCUS         Analyze the specified interval, given in format
                        Chr:start-stop. Mutually exclusive with --locifile.
  --nohp                If this switch is set, RNA folding will not take
                        place, thus MIRNA loci cannot be annotated. This does
                        however save CPU time.
  --dn_mirna            If this switch is set, a de novo search for new MIRNA
                        loci will be performed. By default, de novo MIRNA
                        finding is not performed and MIRNA searches are
                        limited to loci matching RNAs from --known_miRNAs that
                        align to the genome
  --strand_cutoff STRAND_CUTOFF
                        Cutoff for calling the strandedness of a small RNA
                        locus. Must be a floating point > 0.5 and < 1.
                        Default: 0.8.
  --mincov MINCOV       Minimum alignment depth required to nucleate a small
                        RNA cluster during de novo cluster search. In units of
                        reads per million. Must be a floating point number.
                        Default: 0.5
  --pad PAD             Initial peaks (continuous regions with depth exceeding
                        argument mincov are merged if they are this distance
                        or less from each other. Must be an integer >= 1.
                        Default: 200
  --make_bigwigs        If this switch is set then bigwigs will be made from
                        alignments.
```

