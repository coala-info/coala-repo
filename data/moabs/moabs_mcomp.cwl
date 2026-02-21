cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - moabs
  - mcomp
label: moabs_mcomp
doc: "MOABS (Model-based Analysis of Bisulfite Sequencing) comparison tool. Note:
  The provided text contains a system error message regarding container execution
  and does not list command-line arguments.\n\nTool homepage: https://github.com/sunnyisgalaxy/moabs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moabs:1.3.9.6--h3e6c209_8
stdout: moabs_mcomp.out
