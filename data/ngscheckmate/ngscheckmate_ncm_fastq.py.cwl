cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngscheckmate_ncm_fastq.py
label: ngscheckmate_ncm_fastq.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment info and a fatal error regarding container image conversion
  (no space left on device).\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
stdout: ngscheckmate_ncm_fastq.py.out
