cwlVersion: v1.2
class: CommandLineTool
baseCommand: stranger
label: stranger
doc: "Stranger is a tool for annotating STR (Short Tandem Repeat) variants in VCF
  files with information about repeat expansions and their clinical significance.\n
  \nTool homepage: https://github.com/moonso/stranger"
inputs:
  - id: vcf
    type: File
    doc: VCF file containing STR variants to be annotated
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to file instead of stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stranger:0.10.0--pyhdfd78af_0
