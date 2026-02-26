# sim4db CWL Generation Report

## sim4db

### Tool Description
sim4db

### Metadata
- **Docker Image**: quay.io/biocontainers/sim4db:2008--pl5321h609437b_2
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sim4db/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-10-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: sim4db -genomic g.fasta -cdna c.fasta -output o.sim4db [options]

       -v            print status to stderr while running
       -V            print script lines (stderr) as they are processed
       -YN           print script lines (to given file) as they are processed, annotated with yes/no

       -cdna         use these cDNA sequences
       -genomic      use these genomic sequences
       -script       use this script file
       -pairwise     do pairs of sequences
       -output       write output to this file
       -touch        create this file when the program finishes execution

       -threads      Use n threads.

       -mincoverage  iteratively find all exon models with the specified
                     minimum PERCENT COVERAGE
       -minidentity  iteratively find all exon models with the specified
                     minimum PERCENT EXON IDENTITY
       -minlength    iteratively find all exon models with the specified
                     minimum ABSOLUTE COVERAGE (number of bp matched)
       -alwaysreport always report <number> exon models, even if they
                     are below the quality thresholds

         If no mincoverage or minidentity or minlength is given, only
         the best exon model is returned.

         You will probably want to specify ALL THREE of mincoverage,
         minidentity and minlength!  Don't assume the default values
         are what you want!

         You will DEFINITELY want to specify at least one of mincoverage,
         minidentity and minlength with alwaysreport!  If you don't, mincoverage
         will be set to 90 and minidentity to 95 -- to reduce the number of
         spurious matches when a good match is found.

       -nodeflines   don't include the defline in the output
       -alignments   print alignments

       -polytails    DON'T mask poly-A and poly-T tails.
       -cut          Trim marginal exons if A/T % > x (poly-AT tails)

       -noncanonical Don't force canonical splice sites
       -splicemodel  Use the following splice model: 0 - original sim4;
                     1 - GeneSplicer; 2 - Glimmer (default: 0)

       -forcestrand  Force the strand prediction to always be
                     'forward' or 'reverse'

       -interspecies Use sim4cc for inter-species alignments

  The following are for use only by immortals.
       -Z            set the (spaced) seed pattern
       -H            set the relink weight factor
       -K            set the first MSP threshold
       -C            set the second MSP threshold
       -Ma           set the limit of the number of MSPs allowed
       -Mp           same, as percentage of bases in cDNA
                     NOTE:  If used, both -Ma and -Mp must be specified!
```


## Metadata
- **Skill**: generated
