cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifi_trimmer
label: hifi_trimmer
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure.\n\nTool homepage: https://github.com/sanger-tol/hifi-trimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifiadapterfilt:3.0.0--hdfd78af_0
stdout: hifi_trimmer.out
