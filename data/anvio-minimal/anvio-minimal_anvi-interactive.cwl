cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-interactive
label: anvio-minimal_anvi-interactive
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build a container image due to lack
  of disk space.\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-interactive.out
