cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusepy
label: fusepy
doc: "fusepy is a Python module that provides a simple interface to FUSE and MacFUSE.
  (Note: The provided text contains system error messages and does not list command-line
  arguments.)\n\nTool homepage: http://github.com/terencehonles/fusepy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusepy:2.0.4--py36_0
stdout: fusepy.out
