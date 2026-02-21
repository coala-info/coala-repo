cwlVersion: v1.2
class: CommandLineTool
baseCommand: msfragger
label: msfragger_MSFragger.jar
doc: "MSFragger: An ultra-fast database search engine for peptide identification in
  mass spectrometry-based proteomics.\n\nTool homepage: https://github.com/Nesvilab/MSFragger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msfragger:4.2--py311hdfd78af_0
stdout: msfragger_MSFragger.jar.out
