cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - FastTree
label: fasttree
doc: FastTree infers approximately-maximum-likelihood phylogenetic trees from 
  alignments of nucleotide or protein sequences.
inputs:
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Alignment file in fasta or phylip interleaved format (placed after all options)
    inputBinding:
      position: 200
  - id: out
    type:
      - 'null'
      - string
    doc: Output tree file
    inputBinding:
      position: 102
      prefix: -out
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: Nucleotide alignment input
    inputBinding:
      position: 102
      prefix: -nt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress reporting information
    inputBinding:
      position: 102
      prefix: -quiet
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Suppress progress indicator
    inputBinding:
      position: 102
      prefix: -nopr
  - id: log
    type:
      - 'null'
      - string
    doc: Save intermediate trees, settings, and model details
    inputBinding:
      position: 102
      prefix: -log
  - id: fastest
    type:
      - 'null'
      - boolean
    doc: Speed up the neighbor joining phase & reduce memory usage (recommended 
      for >50,000 sequences)
    inputBinding:
      position: 102
      prefix: -fastest
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Analyze multiple alignments (phylip format only) (use for global 
      bootstrap, with seqboot and CompareToBootstrap.pl)
    inputBinding:
      position: 102
      prefix: -n
  - id: nosupport
    type:
      - 'null'
      - boolean
    doc: Do not compute support values
    inputBinding:
      position: 102
      prefix: -nosupport
  - id: intree
    type:
      - 'null'
      - File
    doc: Set the starting tree(s)
    inputBinding:
      position: 102
      prefix: -intree
  - id: intree1
    type:
      - 'null'
      - File
    doc: Use this starting tree for all the alignments (for faster global 
      bootstrap on huge alignments)
    inputBinding:
      position: 102
      prefix: -intree1
  - id: pseudo
    type:
      - 'null'
      - boolean
    doc: Use pseudocounts (recommended for highly gapped sequences)
    inputBinding:
      position: 102
      prefix: -pseudo
  - id: gtr
    type:
      - 'null'
      - boolean
    doc: Generalized time-reversible model (nucleotide alignments only)
    inputBinding:
      position: 102
      prefix: -gtr
  - id: lg
    type:
      - 'null'
      - boolean
    doc: Le-Gascuel 2008 model (amino acid alignments only)
    inputBinding:
      position: 102
      prefix: -lg
  - id: wag
    type:
      - 'null'
      - boolean
    doc: Whelan-And-Goldman 2001 model (amino acid alignments only)
    inputBinding:
      position: 102
      prefix: -wag
  - id: quote
    type:
      - 'null'
      - boolean
    doc: Allow spaces and other restricted characters (but not ' ) in sequence 
      names and quote names in the output tree (fasta input only; FastTree will 
      not be able to read these trees back in)
    inputBinding:
      position: 102
      prefix: -quote
  - id: noml
    type:
      - 'null'
      - boolean
    doc: Turn off maximum-likelihood
    inputBinding:
      position: 102
      prefix: -noml
  - id: nome
    type:
      - 'null'
      - boolean
    doc: Turn off minimum-evolution NNIs and SPRs (recommended if running 
      additional ML NNIs with -intree)
    inputBinding:
      position: 102
      prefix: -nome
  - id: mllen
    type:
      - 'null'
      - boolean
    doc: Used with -nome and -intree to optimize branch lengths for a fixed 
      topology
    inputBinding:
      position: 102
      prefix: -mllen
  - id: cat
    type:
      - 'null'
      - int
    doc: Specify the number of rate categories of sites
    inputBinding:
      position: 102
      prefix: -cat
  - id: nocat
    type:
      - 'null'
      - boolean
    doc: Use constant rates
    inputBinding:
      position: 102
      prefix: -nocat
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: After optimizing the tree under the CAT approximation, rescale the 
      lengths to optimize the Gamma20 likelihood
    inputBinding:
      position: 102
      prefix: -gamma
  - id: constraints
    type:
      - 'null'
      - File
    doc: Constrain the topology search (constraintAlignment should have 1s or 0s
      to indicates splits)
    inputBinding:
      position: 102
      prefix: -constraints
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: Output tree file
    outputBinding:
      glob: $(inputs.out)
  - id: output_log
    type:
      - 'null'
      - File
    doc: Save intermediate trees, settings, and model details
    outputBinding:
      glob: $(inputs.log)
  - id: tree_stdout
    type: stdout
    doc: Newick tree written to standard output when -out is not used
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasttree:2.2.0--h7b50bb2_1
stdout: fasttree.out
s:url: https://morgannprice.github.io/fasttree
$namespaces:
  s: https://schema.org/
