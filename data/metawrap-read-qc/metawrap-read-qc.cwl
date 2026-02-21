cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-read-qc
label: metawrap-read-qc
doc: "A tool for read quality control (QC) as part of the metaWRAP pipeline.\n\nTool
  homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-read-qc:1.3.0--hdfd78af_3
stdout: metawrap-read-qc.out
