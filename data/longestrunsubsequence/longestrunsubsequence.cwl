cwlVersion: v1.2
class: CommandLineTool
baseCommand: longestrunsubsequence
label: longestrunsubsequence
doc: "A tool for finding the longest run subsequence. (Note: The provided help text
  contains only container runtime error messages and no usage information.)\n\nTool
  homepage: https://github.com/AlBi-HHU/longest-run-subsequence"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longestrunsubsequence:1.0.1--py_0
stdout: longestrunsubsequence.out
