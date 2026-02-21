cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymsaviz
label: pymsaviz
doc: "A tool for Multiple Sequence Alignment (MSA) visualization. (Note: The provided
  text contains only system error logs and no help information; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://moshi4.github.io/pyMSAviz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymsaviz:0.5.0--pyhdfd78af_0
stdout: pymsaviz.out
