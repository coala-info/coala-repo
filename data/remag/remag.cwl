cwlVersion: v1.2
class: CommandLineTool
baseCommand: remag
label: remag
doc: "REconstruction of MAp-based Genomes (Note: The provided text appears to be a
  container build log rather than CLI help text; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/danielzmbp/remag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/remag:0.3.4--pyhdfd78af_0
stdout: remag.out
