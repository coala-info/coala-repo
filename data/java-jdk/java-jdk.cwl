cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: java-jdk
doc: "The Java Development Kit (JDK) is a software development environment used for
  developing Java applications and applets. (Note: The provided text is an error log
  from a container runtime and does not contain CLI help information or arguments).\n
  \nTool homepage: https://github.com/coderbruis/JavaSourceCodeLearning"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/java-jdk:8.0.112--0
stdout: java-jdk.out
