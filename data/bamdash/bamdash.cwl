cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdash
label: bamdash
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/jonas-fuchs/BAMdash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0
stdout: bamdash.out
