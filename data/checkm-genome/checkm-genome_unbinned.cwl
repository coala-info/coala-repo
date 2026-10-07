cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - unbinned
label: checkm-genome_unbinned
doc: "Identify unbinned sequences.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: bin_input
    type:
      - Directory
      - File
    doc: 'directory containing bins (fasta format) or path to file describing
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome
      translation file (pep)]'
    inputBinding:
      position: 1
  - id: seq_file
    type: File
    doc: 'sequences used to generate bins (fasta format)'
    inputBinding:
      position: 2
  - id: output_seq_file
    type: string
    doc: 'write unbinned sequences to file'
    inputBinding:
      position: 3
  - id: output_stats_file
    type: string
    doc: 'write unbinned sequence statistics to file'
    inputBinding:
      position: 4
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: 'required length of sequence'
    inputBinding:
      position: 101
      prefix: --min_seq_len
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_seq_file_out
    type: File
    doc: 'write unbinned sequences to file'
    outputBinding:
      glob: $(inputs.output_seq_file)
  - id: output_stats_file_out
    type: File
    doc: 'write unbinned sequence statistics to file'
    outputBinding:
      glob: $(inputs.output_stats_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
