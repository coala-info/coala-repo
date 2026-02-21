cwlVersion: v1.2
class: CommandLineTool
baseCommand: LINKS-make
label: links_LINKS-make
doc: "Long Interval Nucleotide K-mer Scaffolder (Note: The provided text contains
  only system error messages regarding container execution and does not include usage
  or argument information.)\n\nTool homepage: https://github.com/bcgsc/LINKS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/links:2.0.1--h9948957_7
stdout: links_LINKS-make.out
