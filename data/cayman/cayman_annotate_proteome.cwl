cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cayman
  - annotate_proteome
label: cayman_annotate_proteome
doc: "Annotate proteome with HMMs\n\nTool homepage: https://github.com/zellerlab/cayman"
inputs:
  - id: hmmdb
    type: Directory
    doc: path to folder containing HMMs
    inputBinding:
      position: 1
  - id: proteins
    type: File
    doc: path to protein sequences in fasta format
    inputBinding:
      position: 2
  - id: cutoffs
    type:
      - 'null'
      - File
    doc: path to file containing HMM-specific p-value cutoffs
    inputBinding:
      position: 103
      prefix: --cutoffs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
