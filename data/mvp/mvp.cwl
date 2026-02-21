cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvp
label: mvp
doc: "The provided text does not contain help information for the 'mvp' tool. It contains
  error messages related to a Singularity/Apptainer environment failure (no space
  left on device) while attempting to pull a Docker image.\n\nTool homepage: https://gitlab.com/LPCDRP/motif-variants"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvp:0.4.3--py35_0
stdout: mvp.out
