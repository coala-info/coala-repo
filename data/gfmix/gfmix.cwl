cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfmix
label: gfmix
doc: "Phylogenetic analyses using the site-and-branch-heterogeneous GFmix model.
  Takes a PHYLIP protein alignment, a Newick tree with edge lengths, the .iqtree
  output file of an IQ-TREE run with a class-frequency mixture (+F, +G), a file of
  class frequencies and a root split file. Prints the log likelihood of the model.\n\nTool
  homepage: https://github.com/TheBrownLab/gfmix"
inputs:
  - id: seqfile
    type: File
    doc: The input sequence file in PHYLIP format (taxon names are 10 characters
      long, padded with blanks)
    inputBinding:
      position: 1
      prefix: -s
  - id: treefile
    type: File
    doc: A Newick tree file with edge lengths
    inputBinding:
      position: 1
      prefix: -t
  - id: iqtreefile
    type: File
    doc: The output file from IQ-TREE with extension .iqtree (run with a class-frequency
      mixture, +F and gamma rate variation)
    inputBinding:
      position: 1
      prefix: -i
  - id: frfile
    type: File
    doc: A file with the frequencies for each frequency class as rows (for example
      C20.aafreq.dat from the gfmix package)
    inputBinding:
      position: 1
      prefix: -f
  - id: rootfile
    type: File
    doc: A file with the integer labels 0, 1, ... of taxa on one side of the root
      split; labels follow the order of the sequences in the sequence file
    inputBinding:
      position: 1
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Log likelihood of the model
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfmix:1.0.2--hdbdd923_2
stdout: gfmix.out
