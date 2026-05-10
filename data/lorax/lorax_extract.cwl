cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorax extract
label: lorax_extract
doc: "Extracts reads from a BAM file based on a list of reads and a reference genome.\n\
  \nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: contig_bam
    type: File
    doc: contig BAM file
    inputBinding:
      position: 1
  - id: fafile
    type:
      - 'null'
      - File
    doc: gzipped fasta/q file
    inputBinding:
      position: 102
      prefix: --fafile
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: output fastq
    inputBinding:
      position: 102
      prefix: --fastq
  - id: genome
    type: File
    doc: reference fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: hashes
    type:
      - 'null'
      - boolean
    doc: list of reads are hashes
    inputBinding:
      position: 102
      prefix: --hashes
  - id: reads
    type: string
    doc: list of reads
    inputBinding:
      position: 102
      prefix: --reads
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: gzipped match file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
