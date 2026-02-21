cwlVersion: v1.2
class: CommandLineTool
baseCommand: doubletdetection
label: doubletdetection
doc: "A tool for detecting doublets in single-cell RNA-seq data. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/JonathanShor/DoubletDetection"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doubletdetection:4.3.0.post1--pyhdfd78af_0
stdout: doubletdetection.out
