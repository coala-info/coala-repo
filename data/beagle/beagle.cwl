cwlVersion: v1.2
class: CommandLineTool
baseCommand: beagle
label: beagle
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the OCI image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/yampelo/beagle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
stdout: beagle.out
