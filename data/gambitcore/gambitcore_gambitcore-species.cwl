cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambitcore-species
label: gambitcore_gambitcore-species
doc: "Kmer statistics for all species in a database. Warning it can take a long time
  to run.\n\nTool homepage: https://github.com/gambit-suite/gambitcore"
inputs:
  - id: gambit_directory
    type: Directory
    doc: A directory containing GAMBIT files (database and signatures)
    inputBinding:
      position: 1
  - id: species
    type:
      - 'null'
      - string
    doc: Provide the name of species to target (comma delimited), default is to 
      use everything in the database
    inputBinding:
      position: 101
      prefix: --species
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: kmer
    type:
      - 'null'
      - int
    doc: Length of the k-mer to use
    inputBinding:
      position: 101
      prefix: --kmer
  - id: kmer_prefix
    type:
      - 'null'
      - string
    doc: Kmer prefix
    inputBinding:
      position: 101
      prefix: --kmer_prefix
  - id: max_species_genomes
    type:
      - 'null'
      - int
    doc: Max number of genomes in a species to consider, ignore all others above
      this
    inputBinding:
      position: 101
      prefix: --max_species_genomes
  - id: core_proportion
    type:
      - 'null'
      - float
    doc: Proportion of genomes a kmer must be in for a species to be considered 
      core
    inputBinding:
      position: 101
      prefix: --core_proportion
  - id: num_genomes_per_species
    type:
      - 'null'
      - int
    doc: Number of genomes to keep for a species (0 means keep all)
    inputBinding:
      position: 101
      prefix: --num_genomes_per_species
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambitcore:0.0.2--py310h1fe012e_0
stdout: gambitcore_gambitcore-species.out
