cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-run-hmms
label: anvio-minimal_anvi-run-hmms
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build/extract a container image due to
  lack of disk space. No command-line arguments could be extracted from this text.\n
  \nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-run-hmms.out
