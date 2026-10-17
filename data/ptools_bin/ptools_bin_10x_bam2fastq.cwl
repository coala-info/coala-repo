cwlVersion: v1.2
class: CommandLineTool
baseCommand: 10x_bam2fastq
label: ptools_bin_10x_bam2fastq
doc: "Convert 10x pBAM records (read from standard input) to three FASTQ files, PREFIX_I1.fastq.gz (sample index), PREFIX_R1.fastq.gz (cell barcode and UMI) and PREFIX_R2.fastq.gz (read). Needs the SR, SY, CR, CY, UR and UY tags.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: prefix
    type: string
    doc: Prefix of the three output FASTQ files
    inputBinding:
      position: 1
  - id: sam_file
    type: File
    doc: pBAM records without header (output of samtools view), read from standard input
outputs:
  - id: index_fastq
    type: File
    doc: Sample index reads
    outputBinding:
      glob: $(inputs.prefix)_I1.fastq.gz
  - id: read1_fastq
    type: File
    doc: Cell barcode and UMI reads
    outputBinding:
      glob: $(inputs.prefix)_R1.fastq.gz
  - id: read2_fastq
    type: File
    doc: Biological reads
    outputBinding:
      glob: $(inputs.prefix)_R2.fastq.gz
stdin: $(inputs.sam_file.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
