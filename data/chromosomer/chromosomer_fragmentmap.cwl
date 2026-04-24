cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer fragmentmap
label: chromosomer_fragmentmap
doc: "Construct a fragment map from fragment alignments to reference chromosomes.\n\
  \nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: alignment_file
    type: File
    doc: a BLAST tabular file of fragment alignments to reference chromosomes
    inputBinding:
      position: 1
  - id: gap_size
    type: int
    doc: a size of a gap inserted between mapped fragments
    inputBinding:
      position: 2
  - id: fragment_lengths
    type: File
    doc: a file containing lengths of fragment sequences; it can be obtained 
      using the 'chromosomer fastalength' tool
    inputBinding:
      position: 3
  - id: ratio_threshold
    type:
      - 'null'
      - float
    doc: the least ratio of two greatest fragment alignment scores to determine 
      the fragment placed to a reference genome
    inputBinding:
      position: 104
      prefix: --ratio_threshold
  - id: shrink_gaps
    type:
      - 'null'
      - boolean
    doc: shrink large interfragment gaps to the specified size
    inputBinding:
      position: 104
      prefix: --shrink_gaps
outputs:
  - id: output_map
    type: File
    doc: an output fragment map file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
