cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfaffix
label: gfaffix
doc: "The provided text does not contain help information for gfaffix; it contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/marschall-lab/GFAffix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfaffix:0.2.1--hc1c3326_0
stdout: gfaffix.out
