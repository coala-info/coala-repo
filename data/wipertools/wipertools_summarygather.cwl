cwlVersion: v1.2
class: CommandLineTool
baseCommand: wipertools_summarygather
label: wipertools_summarygather
doc: "A tool from the wipertools suite, likely used for gathering summaries. (Note:
  The provided text contains container build logs rather than tool help documentation.)\n
  \nTool homepage: https://github.com/mazzalab/fastqwiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
stdout: wipertools_summarygather.out
