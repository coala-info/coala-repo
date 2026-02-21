cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_shiver_init.sh
label: shiver_shiver_init.sh
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/ChrisHIV/shiver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_init.sh.out
