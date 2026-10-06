cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-coverage
label: autometa_autometa-coverage
doc: "Construct contig coverage table given an input `assembly` and provided files: forward/reverse reads, SAM, BAM or BED alignments, or SPAdes contig names.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: assembly
    type: File
    doc: "</path/to/metagenome.fasta>"
    inputBinding:
      position: 1
      prefix: --assembly
  - id: fwd_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "</path/to/forwards-reads.fastq>"
    inputBinding:
      position: 1
      prefix: --fwd-reads
  - id: rev_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "</path/to/reverse-reads.fastq>"
    inputBinding:
      position: 1
      prefix: --rev-reads
  - id: se_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "</path/to/single-end-reads.fastq>"
    inputBinding:
      position: 1
      prefix: --se-reads
  - id: sam
    type:
      - 'null'
      - File
    doc: "</path/to/alignments.sam>"
    inputBinding:
      position: 1
      prefix: --sam
  - id: bam
    type:
      - 'null'
      - File
    doc: "</path/to/alignments.bam>"
    inputBinding:
      position: 1
      prefix: --bam
  - id: bed
    type:
      - 'null'
      - File
    doc: "</path/to/alignments.bed>"
    inputBinding:
      position: 1
      prefix: --bed
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Num processors to use"
    inputBinding:
      position: 1
      prefix: --cpus
  - id: from_spades
    type:
      - 'null'
      - boolean
    doc: "Extract k-mer coverages from contig IDs. (Input assembly is output from SPAdes)"
    inputBinding:
      position: 1
      prefix: --from-spades
  - id: out
    type: string
    doc: "Path to write a table of coverages (written in the output directory)"
    inputBinding:
      position: 1
      prefix: --out
      valueFrom: "$(runtime.outdir)/$(self)"
outputs:
  - id: coverage_out
    type: File
    doc: "Contig coverage table"
    outputBinding:
      glob: "$(inputs.out)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
