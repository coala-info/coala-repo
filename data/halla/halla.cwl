cwlVersion: v1.2
class: CommandLineTool
baseCommand: halla
label: halla
doc: "The provided text does not contain help information for the tool 'halla'. It
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: http://huttenhower.sph.harvard.edu/halla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halla:0.8.40--pyhdfd78af_0
stdout: halla.out
