cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-unpack-reference
label: isaac4_isaac-unpack-reference
doc: "Unpack an Isaac reference archive made by isaac-pack-reference.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: input_file
    type: File
    doc: Archive path
    inputBinding:
      position: 101
      prefix: --input-file
  - id: make_movable
    type:
      - 'null'
      - boolean
    doc: Store relative paths in sorted-reference.xml so that the entire folder can be copied elsewhere
    inputBinding:
      position: 101
      prefix: --make-movable
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't actually run any commands; just print them
    inputBinding:
      position: 101
      prefix: --dry-run
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4_isaac-unpack-reference.out
