cwlVersion: v1.2
class: CommandLineTool
baseCommand: neffy_neff
label: neffy_neff
doc: "The provided text contains error logs and environment information rather than
  the tool's help documentation. No arguments or descriptions could be extracted from
  the input.\n\nTool homepage: https://github.com/Maryam-Haghani/NEFFy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy:0.1.1--py311he264feb_1
stdout: neffy_neff.out
