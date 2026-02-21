cwlVersion: v1.2
class: CommandLineTool
baseCommand: cats-rb
label: cats-rb
doc: "Categorizing and Analyzing Transcriptome Splicing (Note: The provided text is
  a container execution error log and does not contain help or usage information;
  therefore, no arguments could be extracted).\n\nTool homepage: https://github.com/bodulic/CATS-rb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb.out
