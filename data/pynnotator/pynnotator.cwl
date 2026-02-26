cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynnotator
label: pynnotator
doc: "Annotate VCF files\n\nTool homepage: http://github.com/raonyguimaraes/pynnotator"
inputs:
  - id: options
    type:
      - 'null'
      - string
    doc: install test
    inputBinding:
      position: 1
  - id: genome_build
    type:
      - 'null'
      - string
    doc: The genome build you want to use
    inputBinding:
      position: 102
      prefix: -b
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: a VCF file to be annotated
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynnotator:2.0--py_0
stdout: pynnotator.out
