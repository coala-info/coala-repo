cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusterone
label: clusterone
doc: "The provided text does not contain help information for the tool 'clusterone'.
  It is an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build or extract the container image due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://paccanarolab.org/cluster-one/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterone:1.0--hdfd78af_0
stdout: clusterone.out
