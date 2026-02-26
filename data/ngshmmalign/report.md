# ngshmmalign CWL Generation Report

## ngshmmalign

### Tool Description
ngshmmalign

### Metadata
- **Docker Image**: quay.io/biocontainers/ngshmmalign:0.1.1--0
- **Homepage**: https://github.com/cbg-ethz/ngshmmalign
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngshmmalign/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cbg-ethz/ngshmmalign
- **Stars**: N/A
### Original Help Text
```text
Allowed options:

Generic options:
  -h [ --help ]                    Print this help

Configuration:
  -r arg                           File containing the profile/MSA of the 
                                   reference
  -R arg                           File containing the profile/MSA of the 
                                   reference. Will perform a comprehensive 
                                   parameter estimation using MAFFT. Mutually 
                                   exclusive with -r option
  -o arg (=aln.sam)                Filename where alignment will be written to
  -w [ --wrong ] arg (=/dev/null)  Filename where alignment will be written 
                                   that are filtered (too short, unpaired)
  -t arg (=20)                     Number of threads to use for alignment. 
                                   Defaults to number of logical cores found
  -l                               Do not clean up MAFFT temporary MSA files
  -E                               Use full-exhaustive search, avoiding indexed
                                   lookup
  -X                               Replace general aligned state 'M' with '=' 
                                   (match) and 'X' (mismatch) in CIGAR
  -N arg (=CONSENSUS)              Name of consensus reference contig that will
                                   be created
  -U                               Loci with ambiguous bases get their emission
                                   probabilities according to their allele 
                                   frequencies. In practice this is 
                                   undesirable, as it leads to systematic 
                                   accumulation of gaps in homopolymeric 
                                   regions with SNVs
  -s [ --seed ] arg (=42)          Value of seed for deterministic run. A value
                                   of 0 will pick a random seed from some 
                                   non-deterministic entropy source
  --hard                           Hard-clip reads. Clipped bases will NOT be 
                                   in the sequence in the alignment
  --HARD                           Extreme Hard-clip reads. Do not write 
                                   hard-clip in CIGAR, as if the hard-clipped 
                                   bases never existed. Mutually exclusive with
                                   previous option
  -v                               Show progress indicator while aligning
  -M arg (=L * 0.8)                Minimum mapped length of read
  -a arg (=0.05)                   Minimum frequency for calling ambiguous base
  --error arg (=0.005)             Global substitution probability
  --go arg (=1e-4)                 Gap open probability
  --ge arg (=0.30)                 Gap extend probability
  --io arg (=5e-5)                 Insert open probability
  --ie arg (=0.50)                 Insert extend probability
  --ep arg (=1/L)                  Jump to end probability; usually 1/L, where 
                                   L is the average length of the reads
  --lco arg (=0.10)                Left clip open probability
  --lce arg (=0.90)                Left clip extend probability
  --rco arg (=lco/L)               Right clip open probability
  --rce arg (=0.90)                Right clip extend probability
```


## Metadata
- **Skill**: generated
