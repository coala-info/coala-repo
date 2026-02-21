cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractSplitReads_BwaMem
label: lumpy-sv-minimal_extractSplitReads_BwaMem
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log indicating a failure to build the SIF format
  due to insufficient disk space.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
stdout: lumpy-sv-minimal_extractSplitReads_BwaMem.out
