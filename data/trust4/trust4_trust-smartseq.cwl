cwlVersion: v1.2
class: CommandLineTool
baseCommand: trust-smartseq.pl
label: trust4_trust-smartseq
doc: "TRUST4 SMART-seq pipeline: runs TRUST4 on each cell listed in the read list files and merges the representative chains into one report, annotation and AIRR file.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: read_list1
    type: File
    doc: "file containing the list of read 1 (or single-end) files, one per cell"
    inputBinding:
      position: 101
      prefix: "-1"
  - id: read_list2
    type:
      - 'null'
      - File
    doc: "file containing the list of read 2 files"
    inputBinding:
      position: 101
      prefix: "-2"
  - id: reads
    type: File[]
    doc: "the read files named in the list files (staged into the working directory so the names resolve)"
  - id: fasta_file
    type: File
    doc: "path to the fasta file coordinate and sequence of V/D/J/C genes"
    inputBinding:
      position: 101
      prefix: -f
  - id: ref
    type:
      - 'null'
      - File
    doc: "path to detailed V/D/J/C gene reference file from IMGT database (recommended)"
    inputBinding:
      position: 101
      prefix: --ref
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "prefix of final output files (default: TRUST)"
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      position: 101
      prefix: -t
  - id: representative
    type:
      - 'null'
      - int
    doc: "number of representative for each detected chain (default: 1)"
    inputBinding:
      position: 101
      prefix: --representative
  - id: cgene_end
    type:
      - 'null'
      - int
    doc: "skip reads aligned after the first INT bp of the C gene (default: 200)"
    inputBinding:
      position: 101
      prefix: --cgeneEnd
  - id: trust_path
    type:
      - 'null'
      - string
    doc: "TRUST4 executable files (default: same as this script)"
    inputBinding:
      position: 101
      prefix: --trust-path
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Final report, annotation and AIRR files"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'TRUST') + '_*')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
