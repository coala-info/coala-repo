cwlVersion: v1.2
class: CommandLineTool
baseCommand: recon
label: repeatmasker-recon
doc: "See 00README for details.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs:
  - id: seq_name_list_file
    type: File
    doc: Sequence name list file
    inputBinding:
      position: 1
  - id: msp_file
    type: File
    doc: MSP file
    inputBinding:
      position: 2
  - id: integer
    type: int
    doc: An integer value
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
stdout: repeatmasker-recon.out
