cwlVersion: v1.2
class: CommandLineTool
baseCommand: wbuild
label: wbuild
doc: "The provided text does not contain help information or a description for the
  tool 'wbuild'. It appears to be a log output from a container runtime (Apptainer/Singularity)
  reporting a fatal error during an image build process.\n\nTool homepage: https://github.com/gagneurlab/wBuild"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wbuild:1.8.2--pyhdfd78af_0
stdout: wbuild.out
