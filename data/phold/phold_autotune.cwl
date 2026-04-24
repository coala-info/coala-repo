cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold autotune
label: phold_autotune
doc: "Determines optimal batch size for 3Di prediction with your hardware\n\nTool
  homepage: https://github.com/gbouras13/phold"
inputs:
  - id: database_path
    type:
      - 'null'
      - string
    doc: Specific path to installed phold database
    inputBinding:
      position: 101
      prefix: --database
  - id: input_path
    type:
      - 'null'
      - File
    doc: Optional path to input file of proteins if you do not want to use the 
      default sample of 5000 Phold DB proteins
    inputBinding:
      position: 101
      prefix: --input
  - id: max_batch
    type:
      - 'null'
      - int
    doc: Maximum batch size to test
    inputBinding:
      position: 101
      prefix: --max_batch
  - id: min_batch
    type:
      - 'null'
      - int
    doc: Minimum batch size to test
    inputBinding:
      position: 101
      prefix: --min_batch
  - id: sample_seqs
    type:
      - 'null'
      - int
    doc: Number of proteins to subsample from input.
    inputBinding:
      position: 101
      prefix: --sample_seqs
  - id: step
    type:
      - 'null'
      - int
    doc: Controls batch size step increment
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_cpus_only
    type:
      - 'null'
      - boolean
    doc: Use cpus only.
    inputBinding:
      position: 101
      prefix: --cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_autotune.out
