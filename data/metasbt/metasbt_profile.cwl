cwlVersion: v1.2
class: CommandLineTool
baseCommand: profile
label: metasbt_profile
doc: "Profile a set of genomes. This is used to report the closest kingdom, phylum,
  class, order, family, genus, species, and the closest genome in a specific database.\n\
  \nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: The database name.
    inputBinding:
      position: 101
      prefix: --database
  - id: genome
    type: File
    doc: Path to the input genome.
    inputBinding:
      position: 101
      prefix: --genome
  - id: genomes
    type: File
    doc: Path to the file with a list of paths to the input genomes.
    inputBinding:
      position: 101
      prefix: --genomes
  - id: nproc
    type:
      - 'null'
      - int
    doc: Process the input genomes in parallel.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: pruning_threshold
    type:
      - 'null'
      - float
    doc: Threshold for pruning the Sequence Bloom Tree.
    inputBinding:
      position: 101
      prefix: --pruning-threshold
  - id: uncertainty
    type:
      - 'null'
      - float
    doc: Uncertainty percentage for considering multiple best hits.
    inputBinding:
      position: 101
      prefix: --uncertainty
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_profile.out
