cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - moabs
  - mcall
label: moabs_mcall
doc: "MOABS (Model-based Analysis of Bisulfite Sequencing) mcall subcommand. Note:
  The provided input text contains container runtime error logs rather than the tool's
  help documentation.\n\nTool homepage: https://github.com/sunnyisgalaxy/moabs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moabs:1.3.9.6--h3e6c209_8
stdout: moabs_mcall.out
