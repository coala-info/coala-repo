cwlVersion: v1.2
class: CommandLineTool
baseCommand: mauveAligner
label: mauve_mauveAligner
doc: "The provided text does not contain help information for mauveAligner; it contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
stdout: mauve_mauveAligner.out
