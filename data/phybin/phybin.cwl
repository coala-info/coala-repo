cwlVersion: v1.2
class: CommandLineTool
baseCommand: phybin
label: phybin
doc: "The provided text does not contain help information or usage instructions for
  the tool 'phybin'. It contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull a Docker image due to insufficient disk
  space.\n\nTool homepage: https://github.com/rrnewton/PhyBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phybin:v0.3-3-deb_cv1
stdout: phybin.out
