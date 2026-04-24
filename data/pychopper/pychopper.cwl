cwlVersion: v1.2
class: CommandLineTool
baseCommand: pychopper
label: pychopper
doc: "A tool to identify, orient and rescue full-length Nanopore cDNA reads.\n\nTool
  homepage: https://github.com/nanoporetech/pychopper"
inputs:
  - id: input_fastx
    type: File
    doc: Input FASTQ or FASTA file (can be gzipped)
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the kit
    inputBinding:
      position: 102
      prefix: --config_file
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of output files
    inputBinding:
      position: 102
      prefix: --force
  - id: kit
    type:
      - 'null'
      - string
    doc: Kit used for sequencing (e.g., PCS109, PCS111)
    inputBinding:
      position: 102
      prefix: --kit
  - id: method
    type:
      - 'null'
      - string
    doc: Search method (phmm, edlib, or sw)
    inputBinding:
      position: 102
      prefix: --method
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of the output reads
    inputBinding:
      position: 102
      prefix: --min_len
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum average quality of the output reads
    inputBinding:
      position: 102
      prefix: --min_qual
  - id: no_rescue
    type:
      - 'null'
      - boolean
    doc: Do not attempt to rescue reads
    inputBinding:
      position: 102
      prefix: --no_rescue
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_fastx
    type: File
    doc: Output FASTQ or FASTA file
    outputBinding:
      glob: '*.out'
  - id: unclassified
    type:
      - 'null'
      - File
    doc: Output file for unclassified reads
    outputBinding:
      glob: $(inputs.unclassified)
  - id: report
    type:
      - 'null'
      - File
    doc: PDF report file
    outputBinding:
      glob: $(inputs.report)
  - id: stats
    type:
      - 'null'
      - File
    doc: Output statistics file
    outputBinding:
      glob: $(inputs.stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pychopper:2.7.10--pyhdfd78af_0
