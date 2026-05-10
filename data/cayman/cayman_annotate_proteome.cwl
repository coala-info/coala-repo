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
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
