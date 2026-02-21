cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict-java
label: vardict-java
doc: "The provided text does not contain help information for vardict-java. It appears
  to be a fatal error log from a container execution environment (Singularity/Apptainer)
  failing to fetch the OCI image.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java.out
