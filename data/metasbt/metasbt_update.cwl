cwlVersion: v1.2
class: CommandLineTool
baseCommand: update
label: metasbt_update
doc: "Update a MetaSBT database with new genomes.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: completeness
    type:
      - 'null'
      - float
    doc: Percentage threshold on genomes completeness.
    inputBinding:
      position: 101
      prefix: --completeness
  - id: contamination
    type:
      - 'null'
      - float
    doc: Percentage threshold on genomes contamination.
    inputBinding:
      position: 101
      prefix: --contamination
  - id: database
    type: string
    doc: The database name.
    inputBinding:
      position: 101
      prefix: --database
  - id: dereplicate
    type:
      - 'null'
      - float
    doc: Dereplicate genomes based of their ANI distance according the specified
      threshold. The dereplication process is triggered in case of a threshold 
      >0.0.
    inputBinding:
      position: 101
      prefix: --dereplicate
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
  - id: pack
    type:
      - 'null'
      - boolean
    doc: Pack the database into a compressed tarball.
    inputBinding:
      position: 101
      prefix: --pack
  - id: pruning_threshold
    type:
      - 'null'
      - float
    doc: Threshold for pruning the Sequence Bloom Tree while profiling input 
      genomes.
    inputBinding:
      position: 101
      prefix: --pruning-threshold
  - id: uncertainty
    type:
      - 'null'
      - float
    doc: Uncertainty percentage for considering multiple best hits while 
      profiling input genomes.
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
stdout: metasbt_update.out
