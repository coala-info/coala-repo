cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - ssu_finder
label: checkm-genome_checkm ssu_finder
doc: "Identify SSU (16S/18S) rRNAs in sequences.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: seq_file
    type: File
    doc: sequences used to generate bins (fasta format)
    inputBinding:
      position: 1
  - id: bin_input
    type: string
    doc: directory containing bins (fasta format) or path to file describing 
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, 
      genome translation file (pep)]
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: directory to write output files
    inputBinding:
      position: 3
  - id: concatenate
    type:
      - 'null'
      - int
    doc: concatenate hits that are within the specified number of base pairs
    inputBinding:
      position: 104
      prefix: --concatenate
  - id: evalue
    type:
      - 'null'
      - float
    doc: e-value threshold for identifying hits
    inputBinding:
      position: 104
      prefix: --evalue
  - id: extension
    type:
      - 'null'
      - string
    doc: extension of bins (other files in directory are ignored)
    inputBinding:
      position: 104
      prefix: --extension
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress console output
    inputBinding:
      position: 104
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm ssu_finder.out
