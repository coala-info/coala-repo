cwlVersion: v1.2
class: CommandLineTool
baseCommand: SanitizeMePaired_CLI.py
label: sanitizeme_SanitizeMePaired_CLI.py
doc: "Sanitizes paired-end sequencing data by removing host sequences.\n\nTool homepage:
  https://github.com/jiangweiyao/SanitizeMe"
inputs:
  - id: input_folder
    type: Directory
    doc: Folder containing paired fq, fq.gz, fastq, and fastq.gz files. Program 
      will recursively find paired reads
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
  - id: reference
    type: File
    doc: Host Reference fasta or fasta.gz file
    inputBinding:
      position: 101
      prefix: --Reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. More is faster if your computer supports it
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output Folder. Default is ~/dehost_output/dehost_2026-02-25
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
