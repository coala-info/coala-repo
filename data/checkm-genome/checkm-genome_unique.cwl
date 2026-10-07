cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - unique
label: checkm-genome_unique
doc: "Ensure no sequences are assigned to multiple bins.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
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
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (all other files in bin directory are ignored) (default:
      fna)'
    inputBinding:
      position: 101
      prefix: --extension
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_unique.out
