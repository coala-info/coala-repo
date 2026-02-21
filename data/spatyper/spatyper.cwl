cwlVersion: v1.2
class: CommandLineTool
baseCommand: spatyper
label: spatyper
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) failing
  to fetch the image.\n\nTool homepage: https://github.com/HCGB-IGTP/spaTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spatyper:0.3.3--pyhdfd78af_3
stdout: spatyper.out
