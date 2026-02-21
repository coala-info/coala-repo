cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-refine
label: anvio_anvi-refine
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build or extract a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-refine.out
