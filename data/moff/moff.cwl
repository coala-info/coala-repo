cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff
label: moff
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a 'no space left on device' failure while attempting to pull the moff
  container image.\n\nTool homepage: https://github.com/compomics/moFF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--py36_2
stdout: moff.out
