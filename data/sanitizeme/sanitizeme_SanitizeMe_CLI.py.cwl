cwlVersion: v1.2
class: CommandLineTool
baseCommand: SanitizeMe_CLI.py
label: sanitizeme_SanitizeMe_CLI.py
doc: "SanitizeMe CLI tool for processing sequencing data.\n\nTool homepage: https://github.com/jiangweiyao/SanitizeMe"
inputs:
  - id: input_folder
    type: Directory
    doc: Folder containing fastq files. Only files ending in .fq, .fg.gz, 
      .fastq, and .fastq.gz will be processed
    inputBinding:
      position: 101
      prefix: --InputFolder
  - id: large_reference
    type:
      - 'null'
      - boolean
    doc: Use this option if your reference file is greater than 4 Gigabases
    inputBinding:
      position: 101
      prefix: --LargeReference
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Select if you used Nanopore Sequencing
    inputBinding:
      position: 101
      prefix: --Nanopore
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output Folder. Default is ~/dehost_output/dehost_2026-02-25
    inputBinding:
      position: 101
      prefix: --OutputFolder
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Select if you used PacBio Genonmic Reads
    inputBinding:
      position: 101
      prefix: --PacBio
  - id: pacbio_ccs
    type:
      - 'null'
      - boolean
    doc: Select if you used PacBio CCS Genomic Reads
    inputBinding:
      position: 101
      prefix: --PacBioCCS
  - id: reference
    type: File
    doc: Host Reference fasta or fasta.gz file
    inputBinding:
      position: 101
      prefix: --Reference
  - id: short_read
    type:
      - 'null'
      - boolean
    doc: Select if you have single end short reads (Illumina)
    inputBinding:
      position: 101
      prefix: --ShortRead
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Default is 4. More is faster if your computer 
      supports it
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
stdout: sanitizeme_SanitizeMe_CLI.py.out
