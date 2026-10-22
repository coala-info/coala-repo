cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - model-errors
label: tksm_model-errors
doc: "Model sequencing errors using Badread (in this image the module only prints its description)\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: reads
    type: File
    doc: "Reads (FASTQ) to learn the error model from"
    inputBinding:
      position: 1
      prefix: --reads
  - id: reference
    type: File
    doc: "Reference (transcriptome) FASTA the reads map to"
    inputBinding:
      position: 1
      prefix: --reference
  - id: alignment
    type: File
    doc: "PAF alignment of the reads to the reference"
    inputBinding:
      position: 1
      prefix: --alignment
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_model-errors.out
