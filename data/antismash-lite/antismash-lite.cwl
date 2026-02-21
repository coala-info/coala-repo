cwlVersion: v1.2
class: CommandLineTool
baseCommand: antismash
label: antismash-lite
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space. It does
  not contain the actual help text or usage information for the tool.\n\nTool homepage:
  https://docs.antismash.secondarymetabolites.org/intro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antismash-lite:8.0.1--pyhdfd78af_0
stdout: antismash-lite.out
