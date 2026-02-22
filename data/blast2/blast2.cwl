cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast2
label: blast2
doc: "The provided text does not contain help information or a description for the
  tool; it contains system error messages related to a failed container image retrieval
  (no space left on device).\n\nTool homepage: https://github.com/guyduche/Blast2Bam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/blast2:v1-2.8.1-1-deb_cv1
stdout: blast2.out
