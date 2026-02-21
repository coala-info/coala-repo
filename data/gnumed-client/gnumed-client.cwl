cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnumed-client
label: gnumed-client
doc: "The GNUmed client is the software used by clinicians to interact with the GNUmed
  electronic medical record system.\n\nTool homepage: https://github.com/aur-archive/gnumed-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gnumed-client:v1.7.5dfsg-3-deb_cv1
stdout: gnumed-client.out
