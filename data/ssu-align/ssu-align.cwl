cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-align
label: ssu-align
doc: "Small subunit ribosomal RNA (SSU rRNA) sequence alignment tool. (Note: The provided
  text contains container execution logs and a fatal error rather than the tool's
  help documentation.)\n\nTool homepage: http://eddylab.org/software/ssu-align/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-align.out
