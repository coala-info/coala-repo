cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-merge
label: anvio-minimal_anvi-merge
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to lack of disk space ('no space left on device').\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-merge.out
