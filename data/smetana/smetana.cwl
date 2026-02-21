cwlVersion: v1.2
class: CommandLineTool
baseCommand: smetana
label: smetana
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/execution attempt.\n\n
  Tool homepage: https://github.com/cdanielmachado/smetana"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smetana:1.2.1--pyhdfd78af_0
stdout: smetana.out
