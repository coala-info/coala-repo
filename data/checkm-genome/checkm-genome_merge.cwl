cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - merge
label: checkm-genome_merge
doc: "Identify bins with complementary sets of marker genes.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: marker_file
    type: File
    doc: 'marker file to use for assessing potential bin mergers (marker set or HMM
      file)'
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
  - id: output_dir
    type: string
    doc: 'directory to write output files'
    inputBinding:
      position: 3
  - id: genes
    type:
      - 'null'
      - boolean
    doc: 'bins contain genes as amino acids instead of nucleotide contigs'
    inputBinding:
      position: 101
      prefix: --genes
  - id: delta_comp
    type:
      - 'null'
      - float
    doc: 'minimum increase in completeness to report pair (default: 5.0)'
    inputBinding:
      position: 101
      prefix: --delta_comp
  - id: delta_cont
    type:
      - 'null'
      - float
    doc: 'maximum increase in contamination to report pair (default: 10.0)'
    inputBinding:
      position: 101
      prefix: --delta_cont
  - id: merged_comp
    type:
      - 'null'
      - float
    doc: 'minimum merged completeness to report pair (default: 50.0)'
    inputBinding:
      position: 101
      prefix: --merged_comp
  - id: merged_cont
    type:
      - 'null'
      - float
    doc: 'maximum merged contamination to report pair (default: 20.0)'
    inputBinding:
      position: 101
      prefix: --merged_cont
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 101
      prefix: --extension
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
  - id: output_dir_out
    type: Directory
    doc: 'directory to write output files'
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
