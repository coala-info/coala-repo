cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-extract-reads
label: krakenuniq_extract_reads
doc: "Extract all reads from a FASTQ/FASTA file that are matched to a specified taxon by KrakenUniq.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: "Input is FASTA file (default: FASTQ)"
    inputBinding:
      position: 100
      prefix: -a
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: "Output in FASTA format"
    inputBinding:
      position: 100
      prefix: -f
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Invert: print all reads not matching taxon"
    inputBinding:
      position: 100
      prefix: -i
  - id: taxdb
    type:
      - 'null'
      - File
    doc: "TAXDB file used to find the children of the taxonomy IDs (taxDB in the database folder)"
    inputBinding:
      position: 100
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose"
    inputBinding:
      position: 100
      prefix: -v
  - id: paired
    type:
      - 'null'
      - boolean
    doc: "Paired-end reads: use a '%' in the fasta/q file name as placeholder for 1 and 2"
    inputBinding:
      position: 100
      prefix: -p
  - id: taxon
    type: string
    doc: "Taxonomy ID, possibly multiple separated by ','"
    inputBinding:
      position: 201
  - id: kraken_file
    type: File
    doc: "KrakenUniq result file"
    inputBinding:
      position: 202
  - id: sequence_name
    type: string
    doc: "Name of the fasta/fastq file in the working directory (use '%' for 1 and 2 with -p)"
    inputBinding:
      position: 203
  - id: sequence_files
    type:
      type: array
      items: File
    doc: "Fasta/fastq files (possibly gzipped), staged into the working directory"
outputs:
  - id: output
    type: stdout
    doc: "Extracted reads"
stdout: krakenuniq_extract_reads.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.sequence_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
