# pipelign CWL Generation Report

## pipelign

### Tool Description
creates multiple sequence alignment from FASTA formatted sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/pipelign:0.2--py36_0
- **Homepage**: https://github.com/asmmhossain/pipelign/
- **Package**: https://anaconda.org/channels/bioconda/packages/pipelign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pipelign/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/asmmhossain/pipelign
- **Stars**: N/A
### Original Help Text
```text
usage: pipelign [-h] -i INFILE -o OUTFILE [-t LENTHR] [-a {dna,aa,rna}] [-f]
                [-b] [-z] [-p SIMPER] [-r {J,G}] [-e {P,C}] [-q THREAD]
                [-s MITERATELONG] [-m MITERATEMERGE] -d OUTDIR [-c]
                [-w AMBIGPER] [-n {1,2,3,4,5,6}] [-x]

Pipelign: creates multiple sequence alignment from FASTA formatted sequence file

optional arguments:
  -h, --help            show this help message and exit
  -i INFILE, --inFile INFILE
                        Input sequence file in FASTA format
  -o OUTFILE, --outFile OUTFILE
                        FASTA formatted output alignment file
  -t LENTHR, --lenThr LENTHR
                        Length threshold for full sequences (default: 0.7)
  -a {dna,aa,rna}, --alphabet {dna,aa,rna}
                        Input sequences can be dna/rna/aa (default: dna)
  -f, --keepOrphans     Add fragments without clusters
  -b, --keepBadSeqs     Add long sequences with too many ambiguous residues
  -z, --mZip            Create zipped intermediate output files
  -p SIMPER, --simPer SIMPER
                        Percent sequence similarity for clustering (default: 0.8)
  -r {J,G}, --run {J,G}
                        Run either (J)oblib/(G)NU parallel version (default: G)
  -e {P,C}, --merge {P,C}
                        Merge using (P)arallel/(C)onsensus strategy  (default: P)
  -q THREAD, --thread THREAD
                        Number of CPU/threads to use (default: 1)
  -s MITERATELONG, --mIterateLong MITERATELONG
                        Number of iterations to refine long alignments (default: 1)
  -m MITERATEMERGE, --mIterateMerge MITERATEMERGE
                        Number of iterations to refine merged alignment (default: 1)
  -d OUTDIR, --outDir OUTDIR
                        Name for output directory to hold intermediate files
  -c, --clearExistingDirectory
                        Remove files from existing output directory
  -w AMBIGPER, --ambigPer AMBIGPER
                        Proportion of ambiguous characters allowed in the long sequences (default: 0.1)
  -n {1,2,3,4,5,6}, --stage {1,2,3,4,5,6}
                        1  Make cluster alignments and HMM of long sequences
                        2  Align long sequences only
                        3  Assign fragments to clusters
                        4  Make cluster alignments with fragments
                        5  Align all sequences
  -x, --excludeClusters
                        Exclude clusters from final alignment
```

