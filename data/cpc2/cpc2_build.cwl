cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpc2_build
label: cpc2_build
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a failed container build process (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: https://github.com/gao-lab/CPC2_standalone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpc2:1.0.1--hdfd78af_0
stdout: cpc2_build.out
