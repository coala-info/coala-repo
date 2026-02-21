cwlVersion: v1.2
class: CommandLineTool
baseCommand: metasbt
label: metasbt
doc: "MetaSBT: a scalable framework for the taxonomical profiling of metagenomes (Note:
  The provided help text contains only container runtime error logs and no usage information).\n
  \nTool homepage: https://github.com/cumbof/MetaSBT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt.out
