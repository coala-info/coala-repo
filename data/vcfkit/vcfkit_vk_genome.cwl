cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - genome
label: vcfkit_vk_genome
doc: "Manage genome data\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Subcommand to run (location, list, ncbi, wormbase); leave empty with search_term
    inputBinding:
      position: 1
  - id: genome_path
    type:
      - 'null'
      - string
    doc: Path to genome data
    inputBinding:
      position: 2
  - id: accession_chrom_names
    type:
      - 'null'
      - boolean
    doc: Use accession names for chromosomes (NCBI only)
    inputBinding:
      position: 103
      prefix: --accession-chrom-names
  - id: genome_directory
    type:
      - 'null'
      - string
    doc: Set Genome Directory
    inputBinding:
      position: 103
      prefix: --directory=
      separate: false
  - id: ref
    type:
      - 'null'
      - string
    doc: Assembly name for NCBI or Wormbase
    inputBinding:
      position: 103
      prefix: --ref=
      separate: false
  - id: search_term
    type:
      - 'null'
      - string
    doc: Search term for genomes
    inputBinding:
      position: 103
      prefix: --search=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_genome.out