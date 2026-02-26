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
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
