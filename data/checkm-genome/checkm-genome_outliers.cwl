cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - outliers
label: checkm-genome_outliers
doc: "[Experimental] Identify outliers in bins relative to reference distributions.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: results_dir
    type: Directory
    doc: 'directory specified during qa command'
    inputBinding:
      position: 1
  - id: bin_input
    type:
      - Directory
      - File
    doc: 'directory containing bins (fasta format) or path to file describing
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, genome
      translation file (pep)]'
    inputBinding:
      position: 2
  - id: tetra_profile
    type: File
    doc: 'tetranucleotide profiles for each sequence (see tetra command)'
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: 'print results to file'
    inputBinding:
      position: 4
  - id: distributions
    type:
      - 'null'
      - int
    doc: 'reference distribution used to identify outliers; integer between 0 and 100
      (default: 95)'
    inputBinding:
      position: 101
      prefix: --distributions
  - id: report_type
    type:
      - 'null'
      - string
    doc: 'report sequences that are outliers in all or any reference distribution
      (default: any)'
    inputBinding:
      position: 101
      prefix: --report_type
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
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
