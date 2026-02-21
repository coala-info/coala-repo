cwlVersion: v1.2
class: CommandLineTool
baseCommand: mccortex31
label: mccortex_mccortex31
doc: "De novo genome assembly and variant calling using de Bruijn graphs. (Note: The
  provided help text contains a system error message regarding container image conversion
  and disk space, rather than command-line usage instructions.)\n\nTool homepage:
  https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex_mccortex31.out
