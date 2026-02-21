cwlVersion: v1.2
class: CommandLineTool
baseCommand: spine
label: spine
doc: "The provided text does not contain help information or usage instructions for
  the tool 'spine'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  attempting to pull a Docker image.\n\nTool homepage: https://github.com/egonozer/Spine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spine:0.3.2--pl526_0
stdout: spine.out
