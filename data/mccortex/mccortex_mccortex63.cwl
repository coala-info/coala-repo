cwlVersion: v1.2
class: CommandLineTool
baseCommand: mccortex63
label: mccortex_mccortex63
doc: "McCortex is a tool for de novo genome assembly and variant calling using multicolour
  de Bruijn graphs. (Note: The provided text contains environment logs and a fatal
  error rather than command-line help documentation.)\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
stdout: mccortex_mccortex63.out
