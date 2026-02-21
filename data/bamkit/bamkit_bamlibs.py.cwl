cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamlibs.py
label: bamkit_bamlibs.py
doc: "A tool to extract library information from BAM files. Note: The provided help
  text appears to be a system error log (no space left on device) and does not contain
  usage instructions or argument definitions.\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamlibs.py.out
