cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_cluster
label: fastaptamer_fastaptamer_cluster
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message regarding a container runtime (Apptainer/Singularity) failing
  to build a SIF format due to insufficient disk space.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer_fastaptamer_cluster.out
