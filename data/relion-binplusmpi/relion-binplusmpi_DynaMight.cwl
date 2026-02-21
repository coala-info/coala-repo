cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-binplusmpi_DynaMight
label: relion-binplusmpi_DynaMight
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message regarding an OCI image build
  failure.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_DynaMight.out
