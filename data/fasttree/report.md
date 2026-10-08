# fasttree CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fasttree | PASS | fixed: alignment now comes after the options, standard output tree is collected, -expert removed; Galaxy nucleotide test gives a same-size tree (476 of 530 splits shared with the older Galaxy version output); protein run gives a Newick tree |

## fasttree

### Tool Description
FastTree infers approximately-maximum-likelihood phylogenetic trees from alignments of nucleotide or protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fasttree:2.2.0--h7b50bb2_1
- **Homepage**: https://morgannprice.github.io/fasttree
- **Package**: https://anaconda.org/channels/bioconda/packages/fasttree/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown or incorrect use of option --help
  FastTree protein_alignment > tree
  FastTree < protein_alignment > tree
  FastTree -out tree protein_alignment
  FastTree -nt nucleotide_alignment > tree
  FastTree -nt -gtr < nucleotide_alignment > tree
  FastTree < nucleotide_alignment > tree
FastTree accepts alignments in fasta or phylip interleaved formats

Common options (must be before the alignment file):
  -quiet to suppress reporting information
  -nopr to suppress progress indicator
  -log logfile -- save intermediate trees, settings, and model details
  -fastest -- speed up the neighbor joining phase & reduce memory usage
        (recommended for >50,000 sequences)
  -n <number> to analyze multiple alignments (phylip format only)
        (use for global bootstrap, with seqboot and CompareToBootstrap.pl)
  -nosupport to not compute support values
  -intree newick_file to set the starting tree(s)
  -intree1 newick_file to use this starting tree for all the alignments
        (for faster global bootstrap on huge alignments)
  -pseudo to use pseudocounts (recommended for highly gapped sequences)
  -gtr -- generalized time-reversible model (nucleotide alignments only)
  -lg -- Le-Gascuel 2008 model (amino acid alignments only)
  -wag -- Whelan-And-Goldman 2001 model (amino acid alignments only)
  -quote -- allow spaces and other restricted characters (but not ' ) in
           sequence names and quote names in the output tree (fasta input only;
           FastTree will not be able to read these trees back in)
  -noml to turn off maximum-likelihood
  -nome to turn off minimum-evolution NNIs and SPRs
        (recommended if running additional ML NNIs with -intree)
  -nome -mllen with -intree to optimize branch lengths for a fixed topology
  -cat # to specify the number of rate categories of sites (default 20)
      or -nocat to use constant rates
  -gamma -- after optimizing the tree under the CAT approximation,
      rescale the lengths to optimize the Gamma20 likelihood
  -constraints constraintAlignment to constrain the topology search
       constraintAlignment should have 1s or 0s to indicates splits
  -expert -- see more options
For more information, see http://www.microbesonline.org/fasttree/
```
