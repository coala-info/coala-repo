cwlVersion: v1.2
class: CommandLineTool
baseCommand: clust
label: clust
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'clust'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/baselabujamous/clust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clust:1.18.0--pyh086e186_0
stdout: clust.out
