cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - coverage
label: checkm-genome_coverage
doc: "Calculate coverage of sequences.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
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
  - id: output_file
    type: string
    doc: 'print results to file'
    inputBinding:
      position: 2
  - id: bam_files
    type:
      type: array
      items: File
    doc: 'BAM files to parse (indexed)'
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 3
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
  - id: all_reads
    type:
      - 'null'
      - boolean
    doc: 'use all reads to estimate coverage instead of just those in proper pairs'
    inputBinding:
      position: 101
      prefix: --all_reads
  - id: min_align
    type:
      - 'null'
      - float
    doc: 'minimum alignment length as percentage of read length (default: 0.98)'
    inputBinding:
      position: 101
      prefix: --min_align
  - id: max_edit_dist
    type:
      - 'null'
      - float
    doc: 'maximum edit distance as percentage of read length (default: 0.02)'
    inputBinding:
      position: 101
      prefix: --max_edit_dist
  - id: min_qc
    type:
      - 'null'
      - int
    doc: 'minimum quality score (in phred) (default: 15)'
    inputBinding:
      position: 101
      prefix: --min_qc
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_file_out
    type: File
    doc: 'print results to file'
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
