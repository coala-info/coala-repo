cwlVersion: v1.2
class: CommandLineTool
baseCommand: strip_it
label: strip_it
doc: "The provided text does not contain help information or usage instructions for
  the tool 'strip_it'. It appears to be a log output from a container runtime (Apptainer/Singularity)
  reporting a fatal error during an image build process.\n\nTool homepage: https://github.com/fjykTec/ModernWMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
stdout: strip_it.out
