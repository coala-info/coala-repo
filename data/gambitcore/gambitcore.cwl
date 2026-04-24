cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambitcore
label: gambitcore
doc: "How complete is an assembly compared to the core genome of its species?\n\n\
  Tool homepage: https://github.com/gambit-suite/gambitcore"
inputs:
  - id: gambit_directory
    type: Directory
    doc: A directory containing GAMBIT files (database and signatures)
    inputBinding:
      position: 1
  - id: fasta_filenames
    type:
      type: array
      items: File
    doc: A list of FASTA files of genomes
    inputBinding:
      position: 2
  - id: concise
    type:
      - 'null'
      - boolean
    doc: concise output
    inputBinding:
      position: 103
      prefix: --concise
  - id: core_proportion
    type:
      - 'null'
      - float
    doc: Proportion of genomes a kmer must be in for a species to be considered 
      core
    inputBinding:
      position: 103
      prefix: --core_proportion
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use
    inputBinding:
      position: 103
      prefix: --cpus
  - id: kmer
    type:
      - 'null'
      - int
    doc: Length of the k-mer to use. Dont change these, must match database 
      parameters.
    inputBinding:
      position: 103
      prefix: --kmer
  - id: kmer_prefix
    type:
      - 'null'
      - string
    doc: Kmer prefix. Dont change these, must match database parameters.
    inputBinding:
      position: 103
      prefix: --kmer_prefix
  - id: max_species_genomes
    type:
      - 'null'
      - int
    doc: Max number of genomes in a species to consider, ignore all others above
      this
    inputBinding:
      position: 103
      prefix: --max_species_genomes
  - id: num_genomes_per_species
    type:
      - 'null'
      - int
    doc: Number of genomes to keep for a species (0 means keep all). Dont change
      this.
    inputBinding:
      position: 103
      prefix: --num_genomes_per_species
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambitcore:0.0.2--py310h1fe012e_0
stdout: gambitcore.out
