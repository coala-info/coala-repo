cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnumed-client-de
label: gnumed-client-de
doc: GNUmed client (German version)
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gnumed-client-de:v1.7.5dfsg-3-deb_cv1
stdout: gnumed-client-de.out
