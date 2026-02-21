cwlVersion: v1.2
class: CommandLineTool
baseCommand: manta
label: manta
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment info and a fatal error log regarding a container build
  failure.\n\nTool homepage: https://github.com/Illumina/manta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta.out
