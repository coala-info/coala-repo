cwlVersion: v1.2
class: CommandLineTool
baseCommand: alien-hunter
label: alien-hunter
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build/execution due to insufficient
  disk space.\n\nTool homepage: https://github.com/Brenin1991/alienHunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/alien-hunter:v1.7-7-deb_cv2
stdout: alien-hunter.out
