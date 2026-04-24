cwlVersion: v1.2
class: CommandLineTool
baseCommand: EGAP
label: egap_EGAP
doc: "Run Entheome Genome Assembly Pipeline (EGAP) Version:3.3.6\n\nTool homepage:
  https://github.com/iPsychonaut/EGAP"
inputs:
  - id: cpu_threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    inputBinding:
      position: 101
      prefix: --cpu_threads
  - id: input_csv
    type: File
    doc: Path to a CSV containing multiple sample data
    inputBinding:
      position: 101
      prefix: --input_csv
  - id: ram_gb
    type:
      - 'null'
      - int
    doc: Amount of RAM in GB to allocate
    inputBinding:
      position: 101
      prefix: --ram_gb
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for pipeline output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/egap:3.3.7--pyhdfd78af_0
