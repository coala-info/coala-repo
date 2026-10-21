cwlVersion: v1.2
class: CommandLineTool
baseCommand: to_basespace
label: rust-mdbg_to_basespace
doc: "Converts the output of gfatools asm -u [any number of simplifications] to base-space.\n\
  \nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Activate debug mode
    inputBinding:
      position: 1
      prefix: --debug
  - id: gfa
    type: File
    doc: Input file (output of gfatools asm -u)
    inputBinding:
      position: 2
      prefix: --gfa
      valueFrom: $(self.basename)
  - id: sequences
    type: string
    doc: Prefix of rust-mdbg, i.e. with [prefix].*.sequences files and the original
      GFA [prefix].gfa
    inputBinding:
      position: 3
      prefix: --sequences
  - id: sequences_files
    type:
      type: array
      items: File
    doc: The [prefix].*.sequences files written by rust-mdbg (staged next to the prefix)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: complete_gfa
    type: File
    doc: GFA with base-space sequences
    outputBinding:
      glob: $(inputs.gfa.basename).complete.gfa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gfa)
      - $(inputs.sequences_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_to_basespace.out
