cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmh_sankoff
label: machina_pmh_sankoff
doc: "Parsimonious Migration History (PMH) using the Sankoff algorithm (Note: The
  provided help text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_pmh_sankoff.out
