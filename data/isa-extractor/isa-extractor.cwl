cwlVersion: v1.2
class: CommandLineTool
baseCommand: isa-extractor
label: isa-extractor
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/DarkLarsen/Minecraft-problem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isa-extractor:phenomenal-v1.1.3_cv1.0.5
stdout: isa-extractor.out
