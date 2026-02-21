cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep
doc: "The provided text does not contain help information or a description for the
  tool 'tadrep'. It appears to be an error log from a container build process.\n\n
  Tool homepage: https://github.com/oschwengers/tadrep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep.out
