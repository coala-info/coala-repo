cwlVersion: v1.2
class: CommandLineTool
baseCommand: mGEMS
label: mgems_mGEMS
doc: "mGEMS is a tool for extracting sequencing reads belonging to specific taxonomic
  groups from metagenomic datasets using pseudoalignments and posterior probabilities.\n\
  \nTool homepage: https://github.com/PROBIC/mGEMS"
inputs:
  - id: abundance_estimates
    type: File
    doc: Abundance estimates file
    inputBinding:
      position: 101
      prefix: --abundance
  - id: group_indicators
    type: File
    doc: Group indicators file
    inputBinding:
      position: 101
      prefix: -i
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Group names to extract (optional)
    inputBinding:
      position: 101
      prefix: --groups
  - id: index
    type: Directory
    doc: Themisto index
    inputBinding:
      position: 101
      prefix: --index
  - id: input_reads
    type:
      type: array
      items: File
    doc: Input reads (e.g., <input-reads_1>,<input-reads_2>)
    inputBinding:
      position: 101
      prefix: -r
  - id: probs
    type: File
    doc: Posterior probabilities file
    inputBinding:
      position: 101
      prefix: --probs
  - id: themisto_alns
    type:
      type: array
      items: File
    doc: Themisto pseudoalignments for the input reads
    inputBinding:
      position: 101
      prefix: --themisto-alns
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
