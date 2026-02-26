cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling
label: strling
doc: "STRling is a tool for analyzing short tandem repeats (STRs) in sequencing data.\n\
  \nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: call
    type:
      - 'null'
      - boolean
    doc: call STRs
    inputBinding:
      position: 101
  - id: extract
    type:
      - 'null'
      - boolean
    doc: extract informative STR reads from a BAM/CRAM. This is a required first
      step.
    inputBinding:
      position: 101
  - id: index
    type:
      - 'null'
      - boolean
    doc: identify large STRs in the reference genome, to produce ref.fasta.str.
    inputBinding:
      position: 101
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge putitive STR loci from multiple samples. Only required for joint 
      calling.
    inputBinding:
      position: 101
  - id: pull_region
    type:
      - 'null'
      - boolean
    doc: for debugging; pull all reads (and mates) for a given regions
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
stdout: strling.out
