cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - quick
label: cnvetti_quick
doc: "Easy-to-use shortcuts for command and important use cases.\n\nTool homepage:
  https://github.com/bihealth/cnvetti"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (wis-build-model, wis-call, wis-call-matched,
      pool-build-model, pool-call)
    inputBinding:
      position: 1
  - id: io_threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use for (de)compression in I/O.
    default: 0
    inputBinding:
      position: 102
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
stdout: cnvetti_quick.out
