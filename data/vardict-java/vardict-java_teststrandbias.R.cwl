cwlVersion: v1.2
class: CommandLineTool
baseCommand: teststrandbias.R
label: vardict-java_teststrandbias.R
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log (Singularity/Apptainer) indicating a failure to fetch the OCI
  image.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java_teststrandbias.R.out
