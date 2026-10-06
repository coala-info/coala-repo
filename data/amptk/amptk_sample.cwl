cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - sample
label: amptk_sample
doc: "Script to sub-sample reads down to the same number for each sample (barcode)\n\
  \nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: input
    type: File
    doc: Input FASTQ
    inputBinding:
      position: 101
      prefix: --input
  - id: num_reads
    type: int
    doc: Number of reads to rarify down to
    inputBinding:
      position: 101
      prefix: --num_reads
  - id: out
    type: string
    doc: Output name
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_file
    type: File
    doc: Output FASTQ (or FASTA) file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_sample.out
