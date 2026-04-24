cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - trimseq
label: fermi_trimseq
doc: "Trim low-quality bases from the ends of sequences.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length after trimming.
    inputBinding:
      position: 102
      prefix: -l
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score for trimming.
    inputBinding:
      position: 102
      prefix: -q
  - id: no_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: Do not trim adapters.
    inputBinding:
      position: 102
      prefix: -N
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_trimseq.out
