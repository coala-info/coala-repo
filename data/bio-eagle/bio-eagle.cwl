cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle
label: bio-eagle
doc: "Eagle is a software tool for high-accuracy genetic phasing of samples with large-scale
  genotype data. (Note: The provided text contains system error messages and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/ialbert/bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bio-eagle:v2.4.1-1-deb_cv1
stdout: bio-eagle.out
