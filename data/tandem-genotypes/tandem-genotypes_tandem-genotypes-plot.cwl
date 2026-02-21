cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-plot
label: tandem-genotypes_tandem-genotypes-plot
doc: "Plot results from tandem-genotypes. (Note: The provided help text contains only
  container execution logs and error messages, and does not list specific arguments
  or usage instructions.)\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes_tandem-genotypes-plot.out
