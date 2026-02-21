cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidseeker
label: plasmidseeker
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a failed container build process.\n\nTool homepage:
  https://github.com/bioinfo-ut/PlasmidSeeker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidseeker:v1.0dfsg-1-deb_cv1
stdout: plasmidseeker.out
