cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat-3n
label: hisat-3n
doc: "HISAT-3N (Hierarchical Indexing for Spliced Alignment of Transcripts - 3 Nucleotide)
  is a tool designed for mapping DNA or RNA sequences, particularly optimized for
  3-nucleotide conversion sequencing data such as BS-seq or SLAM-seq. (Note: The provided
  input text contains container runtime errors and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/fulcrumgenomics/hisat-3n"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
stdout: hisat-3n.out
