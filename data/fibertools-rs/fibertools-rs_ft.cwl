cwlVersion: v1.2
class: CommandLineTool
baseCommand: ft
label: fibertools-rs_ft
doc: "Fiber-seq toolkit in rust\n\nTool homepage: https://github.com/mrvollger/fibertools-rs"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn off all logging
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: 'Logging level [-v: Info, -vv: Debug, -vvv: Trace]'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
stdout: fibertools-rs_ft.out
