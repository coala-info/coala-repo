cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvio-minimal
label: anvio-minimal
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal.out
