cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydna_repeatfinder
label: pydna_repeatfinder
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message regarding a container build failure.\n\n
  Tool homepage: https://github.com/linsalrob/repeatfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydna:5.2.0--pyhdfd78af_0
stdout: pydna_repeatfinder.out
