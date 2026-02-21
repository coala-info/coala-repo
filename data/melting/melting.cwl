cwlVersion: v1.2
class: CommandLineTool
baseCommand: melting
label: melting
doc: "A tool for computing melting temperatures of nucleic acid duplexes (Note: The
  provided help text contains only system error messages and no usage information).\n
  \nTool homepage: https://github.com/google-deepmind/meltingpot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting:v5.2.0-1-deb_cv1
stdout: melting.out
