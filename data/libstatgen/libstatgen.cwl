cwlVersion: v1.2
class: CommandLineTool
baseCommand: libstatgen
label: libstatgen
doc: "The provided text is a container runtime error log and does not contain help
  documentation for the tool.\n\nTool homepage: https://genome.sph.umich.edu/wiki/C++_Library:_libStatGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libstatgen:1.0.15--hd03093a_2
stdout: libstatgen.out
