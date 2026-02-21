cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssdrippipeline_ssDRIPSeqAnalysis.py
label: ssdrippipeline_ssDRIPSeqAnalysis.py
doc: "A tool for ssDRIP-seq analysis. Note: The provided help text contains system
  logs and error messages rather than command-line usage instructions.\n\nTool homepage:
  https://github.com/PEHGP/ssDripPipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssdrippipeline:0.0.5--kuan
stdout: ssdrippipeline_ssDRIPSeqAnalysis.py.out
