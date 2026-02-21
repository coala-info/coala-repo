cwlVersion: v1.2
class: CommandLineTool
baseCommand: svanalyzer_SVmerge
label: svanalyzer_SVmerge
doc: "The provided text does not contain help information or usage instructions. It
  consists of container runtime logs and a fatal error message indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: http://svanalyzer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svanalyzer:0.36--pl5321hdfd78af_2
stdout: svanalyzer_SVmerge.out
