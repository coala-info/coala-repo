cwlVersion: v1.2
class: CommandLineTool
baseCommand: ant
label: ant
doc: "Apache Ant is a Java-based build tool. (Note: The provided help text contains
  only a Java environment error and no usage information.)\n\nTool homepage: https://github.com/ant-design/ant-design"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ant:1.10.0--0
stdout: ant.out
