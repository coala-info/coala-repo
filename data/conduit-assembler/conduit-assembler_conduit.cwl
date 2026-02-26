cwlVersion: v1.2
class: CommandLineTool
baseCommand: conduit
label: conduit-assembler_conduit
doc: "CONsensus Decomposition Utility In Transcriptome-assembly\n\nTool homepage:
  https://github.com/NatPRoach/conduit"
inputs:
  - id: correction_mode
    type: string
    doc: correction mode, "nano" or "hybrid"
    inputBinding:
      position: 1
  - id: input_illumina_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina files (required for hybrid mode, but can be dummy files for 
      nano mode simulation)
    inputBinding:
      position: 2
  - id: no_final_polish
    type:
      - 'null'
      - boolean
    doc: Disables the final polishing step (used to simulate nano mode)
    inputBinding:
      position: 103
      prefix: --no-final-polish
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduit.out
