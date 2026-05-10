cwlVersion: v1.2
class: CommandLineTool
baseCommand: proksee evaluate
label: proksee_evaluate
doc: "Evaluate assembly quality\n\nTool homepage: https://github.com/proksee-project/proksee-cmd"
inputs:
  - id: contigs
    type: File
    doc: Contigs file (e.g. FASTA)
    inputBinding:
      position: 1
  - id: species
    type:
      - 'null'
      - string
    doc: The species to assemble. This will override species estimation. Must be
      spelled correctly.
    inputBinding:
      position: 102
      prefix: --species
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 103
      prefix: --output-directory
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
