cwlVersion: v1.2
class: CommandLineTool
baseCommand: addrg
label: addrg
doc: "Adds a read-group to a BAM file and writes the result to stdout.\n\nTool homepage:
  https://github.com/weex/addrgen"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: rg_name
    type: string
    doc: Read group name (ID)
    inputBinding:
      position: 2
  - id: sm_name
    type:
      - 'null'
      - string
    doc: Sample name (defaults to the value of rg-name)
    inputBinding:
      position: 3
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addrg:0.2.1--h577a1d6_14
stdout: addrg.out
