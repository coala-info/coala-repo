cwlVersion: v1.2
class: CommandLineTool
baseCommand: sunbeam
label: sunbeamlib_sunbeam
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  during an image build process.\n\nTool homepage: https://github.com/sunbeam-labs/sunbeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sunbeamlib:5.2.2--pyhdfd78af_0
stdout: sunbeamlib_sunbeam.out
