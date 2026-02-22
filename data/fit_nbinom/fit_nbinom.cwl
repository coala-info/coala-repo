cwlVersion: v1.2
class: CommandLineTool
baseCommand: fit_nbinom
label: fit_nbinom
doc: "A tool for fitting a negative binomial distribution (Note: The provided help
  text contains system error logs rather than usage instructions, so arguments could
  not be extracted).\n\nTool homepage: https://github.com/joachimwolff/fit_nbinom/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fit_nbinom:1.2--pyh7cba7a3_0
stdout: fit_nbinom.out
