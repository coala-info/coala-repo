cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddocent_test_HWE.sh
label: ddocent_test_HWE.sh
doc: "A tool for testing Hardy-Weinberg Equilibrium, likely part of the dDocent pipeline.
  Note: The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://ddocent.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddocent:2.9.8--hdfd78af_0
stdout: ddocent_test_HWE.sh.out
