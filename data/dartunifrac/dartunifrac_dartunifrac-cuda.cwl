cwlVersion: v1.2
class: CommandLineTool
baseCommand: dartunifrac-cuda
label: dartunifrac_dartunifrac-cuda
doc: "The provided text does not contain help information for the tool; it is a system
  error log regarding a container build failure (no space left on device).\n\nTool
  homepage: https://github.com/jianshu93/DartUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dartunifrac:0.2.9--h3dc2dae_0
stdout: dartunifrac_dartunifrac-cuda.out
