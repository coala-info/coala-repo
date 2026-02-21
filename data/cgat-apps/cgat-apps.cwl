cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgat-apps
label: cgat-apps
doc: "The provided text does not contain help information for cgat-apps; it is a fatal
  error log from a container runtime (Apptainer/Singularity) indicating a 'no space
  left on device' error during image extraction.\n\nTool homepage: https://www.cgat.org/downloads/public/cgat/documentation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgat-apps:0.7.10--py311h251f972_1
stdout: cgat-apps.out
