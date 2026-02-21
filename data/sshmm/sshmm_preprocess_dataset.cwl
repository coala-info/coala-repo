cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshmm_preprocess_dataset
label: sshmm_preprocess_dataset
doc: "Preprocess dataset for SSHMM\n\nTool homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
stdout: sshmm_preprocess_dataset.out
