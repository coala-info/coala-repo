cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - consensus
label: lorikeet-genome_lorikeet consensus
doc: "Consensus caller for lorikeet\n\nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: coupled
    type:
      type: array
      items: File
    doc: Paired-end FASTQ files
    inputBinding:
      position: 101
      prefix: --coupled
  - id: genome_fasta_directory
    type: Directory
    doc: Directory containing genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: genome_fasta_files
    type:
      type: array
      items: File
    doc: Genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome-fasta-files
  - id: interleaved
    type:
      type: array
      items: File
    doc: Interleaved FASTQ files
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: longread_bam_files
    type:
      type: array
      items: File
    doc: Long-read BAM files
    inputBinding:
      position: 101
      prefix: --longread-bam-files
  - id: longreads
    type:
      type: array
      items: File
    doc: Long-read FASTQ files
    inputBinding:
      position: 101
      prefix: --longreads
  - id: read1
    type:
      type: array
      items: File
    doc: Read 1 FASTQ files
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      type: array
      items: File
    doc: Read 2 FASTQ files
    inputBinding:
      position: 101
      prefix: --read2
  - id: single
    type:
      type: array
      items: File
    doc: Single-end FASTQ files
    inputBinding:
      position: 101
      prefix: --single
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
stdout: lorikeet-genome_lorikeet consensus.out
