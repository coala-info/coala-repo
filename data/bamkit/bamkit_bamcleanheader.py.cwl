cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamcleanheader.py
label: bamkit_bamcleanheader.py
doc: "A tool for cleaning BAM headers. (Note: The provided help text contains system
  error messages regarding container image extraction and disk space, rather than
  tool usage information.)\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamcleanheader.py.out
