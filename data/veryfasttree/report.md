# veryfasttree CWL Generation Report

## veryfasttree_VeryFastTree

### Tool Description
VeryFastTree accepts alignments in NEXUS, Fasta, Fastq or Phylip interleaved formats compressed with ZLib and libBZ2.

### Metadata
- **Docker Image**: quay.io/biocontainers/veryfasttree:4.0.5--h9948957_0
- **Homepage**: https://github.com/citiususc/veryfasttree
- **Package**: https://anaconda.org/channels/bioconda/packages/veryfasttree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/veryfasttree/overview
- **Total Downloads**: 23.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/citiususc/veryfasttree
- **Stars**: N/A
### Original Help Text
```text
VeryFastTree 4.0.5 (OpenMP, AVX2)
  VeryFastTree protein_alignment > tree
  VeryFastTree < protein_alignment > tree
  VeryFastTree -out tree protein_alignment
  VeryFastTree -nt nucleotide_alignment > tree
  VeryFastTree -nt -gtr < nucleotide_alignment > tree
  VeryFastTree < nucleotide_alignment > tree
  VeryFastTree accepts alignments in NEXUS, Fasta, Fastq or Phylip interleaved formats compressed with ZLib and libBZ2.

Usage: VeryFastTree [OPTIONS] [protein_alignment]

Common options:
  -n <number>                 to analyze multiple alignments (phylip format only) (use for global bootstrap, with seqboot and CompareToBootstrap.pl)
  -intree newick_file         to set the starting tree(s)
  -intree1 newick_file        to use this starting tree for all the alignments (for faster global bootstrap on huge alignments)
  -quiet                      to suppress reporting information
  -nopr                       to suppress progress indicator
  -log logfile                save intermediate trees, settings, and model details
  -quote                      allow spaces and other restricted characters (but not ' ) in sequence names and quote names in the output tree (fasta/fastq input only; VeryFastTree will not be able to read these trees back in)
  -pseudo                     to use pseudocounts (recommended for highly gapped sequences)
  -noml                       to turn off maximum-likelihood
  -lg                         Le-Gascuel 2008 model (amino acid alignments only)
  -wag                        Whelan-And-Goldman 2001 model (amino acid alignments only)
  -gtr                        generalized time-reversible model (nucleotide alignments only)
  -cat n                      to specify the number of rate categories of sites (default 20) or -nocat to use constant rates
  -gamma                      after optimizing the tree under the CAT approximation, rescale the lengths to optimize the Gamma20 likelihood
  -nome                       to turn off minimum-evolution NNIs and SPRs (recommended if running additional ML NNIs with -intree), -nome -mllen with -intree to optimize branch lengths for a fixed topology
  -nosupport                  to not compute support values
  -fastest Excludes: -slow    speed up the neighbor joining phase & reduce memory usage (recommended for >50,000 sequences)
  -constraints constraintAlignment
                              to constrain the topology search constraintAlignment should have 1s or 0s to indicates splits
  -threads n (Env:OMP_NUM_THREADS)
                              number of threads (n) used in the parallel execution.
  -double-precision           to use double precision arithmetic. Therefore, it is equivalent to compile FastTree-2 with -DUSE_DOUBLE
  -ext name=AUTO              to speed up computations enabling the vector extensions. Available: AUTO(default), NONE, SSE, SSE3 , AVX, AVX2, AVX512 or CUDA
  -expert                     see more options
For more information, see http://www.microbesonline.org/fasttree/, https://github.com/citiususc/veryfasttree or the comments in the source code
```

