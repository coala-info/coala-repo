cwlVersion: v1.2
class: CommandLineTool
baseCommand: univariate_make
label: univariate_make
doc: "A tool for univariate analysis (Note: The provided help text contains container
  build logs and error messages rather than command-line usage instructions).\n\n
  Tool homepage: https://github.com/ServiceNow/N-BEATS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/univariate:phenomenal-v2.2.6_cv1.3.32
stdout: univariate_make.out
