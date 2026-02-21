cwlVersion: v1.2
class: CommandLineTool
baseCommand: msfragger
label: msfragger
doc: "MSFragger is an ultra-fast database search tool for peptide identification in
  mass spectrometry proteomics. (Note: The provided text contains system error logs
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/Nesvilab/MSFragger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msfragger:4.2--py311hdfd78af_0
stdout: msfragger.out
