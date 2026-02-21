cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath
label: megapath
doc: "The provided text does not contain help information for megapath; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/edwwlui/MegaPath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath:2--h43eeafb_4
stdout: megapath.out
