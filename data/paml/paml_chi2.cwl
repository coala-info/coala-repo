cwlVersion: v1.2
class: CommandLineTool
baseCommand: chi2
label: paml_chi2
doc: "chi2 calculates the p value of a chi-square statistic (chi2 df x) or prints critical values of the chi-square distribution when no arguments are given.\n\nTool homepage: https://evomics.org/resources/software/molecular-evolution-software/paml"
inputs:
  - id: degrees_of_freedom
    type: int
    doc: Degrees of freedom of the chi-square distribution.
    inputBinding:
      position: 1
  - id: chi2_value
    type: float
    doc: The chi-square statistic whose p value is calculated.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the probability.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paml:4.10.10--h7b50bb2_0
stdout: paml_chi2.out
