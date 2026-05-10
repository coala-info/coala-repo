cwlVersion: v1.2
class: CommandLineTool
baseCommand: stranger
label: stranger
doc: "Stranger is a tool for annotating STR (Short Tandem Repeat) variants in VCF
  files with information about repeat expansions and their clinical significance.\n\
  \ \nTool homepage: https://github.com/moonso/stranger"
inputs:
  - id: vcf
    type: File
    doc: VCF file containing STR variants to be annotated
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to file instead of stdout
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stranger:0.10.0--pyhdfd78af_0
