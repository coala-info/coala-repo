cwlVersion: v1.2
class: CommandLineTool
baseCommand: bolt
label: bolt-lmm
doc: "BOLT-LMM is a software package for genetic association analysis of large-scale
  datasets. (Note: The provided text contains system error messages and does not include
  help documentation or argument definitions.)\n\nTool homepage: https://alkesgroup.broadinstitute.org/BOLT-LMM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bolt-lmm:2.5--h15e0e67_0
stdout: bolt-lmm.out
