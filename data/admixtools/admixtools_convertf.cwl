cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertf
label: admixtools_convertf
doc: "A tool from the AdmixTools package used to convert between different genetic
  data formats (e.g., PACKEDANCESTRYMAP, ANCESTRYMAP, EIGENSTRAT, PED). Note: The
  provided input text appears to be a system error log regarding a container build
  failure and does not contain the actual help text or argument definitions.\n\nTool
  homepage: https://github.com/DReichLab/AdmixTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_convertf.out
