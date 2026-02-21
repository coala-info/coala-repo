cwlVersion: v1.2
class: CommandLineTool
baseCommand: motulizer_mOTUconvert.py
label: motulizer_mOTUconvert.py
doc: "A tool for converting mOTU (molecular Operational Taxonomic Unit) data. (Note:
  The provided help text contains only system error messages regarding container execution
  and disk space, so specific arguments could not be extracted.)\n\nTool homepage:
  https://github.com/moritzbuck/mOTUlizer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
stdout: motulizer_mOTUconvert.py.out
