cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - machina
  - pmh_tr
label: machina_pmh_tr
doc: "Parsimonious Migration History with Transition Restrictions (PMH-TR). Note:
  The provided help text contains only system error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh_tr.out
