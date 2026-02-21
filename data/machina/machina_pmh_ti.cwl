cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh_ti
label: machina_pmh_ti
doc: "Parsimonious Migration History with Tumor Iteration. (Note: The provided text
  is a system error log regarding a container build failure and does not contain usage
  instructions or argument definitions).\n\nTool homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh_ti.out
