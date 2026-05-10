cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree2ncbitax
label: genera_tree2ncbitax
doc: "Converts a NEWICK tree to NCBI taxonomy format.\n\nTool homepage: https://github.com/josuebarrera/GenEra"
inputs:
  - id: genome
    type: string
    doc: Name of the target genome (the name should match the NEWICK labels)
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_file
    type: File
    doc: Name of input NEWICK tree
    inputBinding:
      position: 101
      prefix: --input
  - id: taxid
    type: int
    doc: NCBI taxonomy ID that is shared between all the organims in the 
      phylogeny
    inputBinding:
      position: 101
      prefix: --taxid
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
