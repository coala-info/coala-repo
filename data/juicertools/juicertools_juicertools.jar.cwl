cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicertools
label: juicertools_juicertools.jar
doc: "Juicebox Tools (Note: The provided text is an error log indicating a failure
  to pull the container image due to lack of disk space, rather than help text. No
  arguments could be extracted.)\n\nTool homepage: https://github.com/aidenlab/Juicebox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicertools:2.20.00--hdfd78af_0
stdout: juicertools_juicertools.jar.out
