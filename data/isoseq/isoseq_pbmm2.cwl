cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - pbmm2
label: isoseq_pbmm2
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build a container image due to lack of disk space.\n\nTool
  homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq_pbmm2.out
