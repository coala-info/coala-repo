cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi_splitfa
label: fermi_splitfa
doc: "Split a FASTQ file into multiple FASTA files.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for output FASTA files
    inputBinding:
      position: 2
  - id: num_files
    type:
      - 'null'
      - int
    doc: Number of output FASTA files
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_splitfa.out
