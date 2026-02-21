cwlVersion: v1.2
class: CommandLineTool
baseCommand: themis
label: themis
doc: "The provided text does not contain help information for the tool 'themis'. It
  appears to be a log output from a container runtime (Apptainer/Singularity) failure
  during an image build process.\n\nTool homepage: https://github.com/xujialupaoli/Themis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/themis:0.1.0--py314h0cb7dc8_0
stdout: themis.out
