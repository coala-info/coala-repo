cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectral_hk
label: spectral_hk
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log (Singularity/Apptainer) indicating a failure
  to fetch or build the image.\n\nTool homepage: https://github.com/ncats/spectral_hk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectral_hk:0.1--h7b50bb2_2
stdout: spectral_hk.out
