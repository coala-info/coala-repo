cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssDRIPSeqAnalysis.py
label: ssdrippipeline_ssDRIPSeqAnalysis.py
doc: "Performs DRIP-seq analysis.\n\nTool homepage: https://github.com/PEHGP/ssDripPipeline"
inputs:
  - id: config_file
    type: File
    doc: Path to the DRIP-seq configuration JSON file.
    inputBinding:
      position: 1
  - id: analysis_type
    type: string
    doc: 'Type of analysis to perform. Options: BaseAnalysis, DeseqAnalysis, DownstreamAnalysis,
      AllPip.'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssdrippipeline:0.0.5--kuan
stdout: ssdrippipeline_ssDRIPSeqAnalysis.py.out
