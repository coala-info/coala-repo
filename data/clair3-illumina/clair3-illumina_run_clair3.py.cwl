cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3-illumina_run_clair3.py
label: clair3-illumina_run_clair3.py
doc: "Clair3 is a germline small variant caller for long-reads and short-reads (Illumina).\n
  \nTool homepage: https://github.com/HKU-BAL/Clair3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3-illumina:1.2.0--h2987a09_0
stdout: clair3-illumina_run_clair3.py.out
