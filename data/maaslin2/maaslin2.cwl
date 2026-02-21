cwlVersion: v1.2
class: CommandLineTool
baseCommand: maaslin2
label: maaslin2
doc: "\nTool homepage: http://huttenhower.sph.harvard.edu/maaslin2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maaslin2:1.16.0--r43hdfd78af_0
stdout: maaslin2.out
