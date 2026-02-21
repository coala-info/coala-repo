cwlVersion: v1.2
class: CommandLineTool
baseCommand: gc-meox-tms
label: gc-meox-tms_gc_meox_tms
doc: "GC-MeOx-TMS tool (Note: The provided help text contains only system error messages
  regarding container execution and does not list specific tool arguments).\n\nTool
  homepage: https://github.com/RECETOX/gc-meox-tms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gc-meox-tms:1.0.1--pyhdfd78af_0
stdout: gc-meox-tms_gc_meox_tms.out
