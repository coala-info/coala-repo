cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, update]
label: metasbt_update
doc: "Update a MetaSBT database with new metagenome-assembled genomes.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.workdir)
        writable: true
      - "$(inputs.genome_files ? inputs.genome_files : [])"
inputs:
  - id: workdir
    type: Directory
    doc: "Path to the working directory with the MetaSBT database. It is staged as a writable copy."
    inputBinding:
      position: 101
      prefix: "--workdir"
      valueFrom: "$(self.basename)"
  - id: database
    type: string
    doc: "The database name."
    inputBinding:
      position: 101
      prefix: "--database"
  - id: genome
    type:
      - 'null'
      - File
    doc: "Path to the input genome (fasta with extension .fa, .fasta or .fna). Give this or genomes."
    inputBinding:
      position: 101
      prefix: "--genome"
  - id: genomes
    type:
      - 'null'
      - File
    doc: "Path to the file with a list of paths to the input genomes. Give this or genome."
    inputBinding:
      position: 101
      prefix: "--genomes"
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The genome files named in the genomes list; they are staged in the working directory so that the names in the list resolve."
  - id: dereplicate
    type:
      - 'null'
      - float
    doc: "Dereplicate genomes based of their ANI distance according the specified threshold. The dereplication process is triggered in case of a threshold >0.0. (default: 0.0)"
    inputBinding:
      position: 101
      prefix: "--dereplicate"
  - id: completeness
    type:
      - 'null'
      - float
    doc: "Percentage threshold on genomes completeness. (default: 0.0)"
    inputBinding:
      position: 101
      prefix: "--completeness"
  - id: contamination
    type:
      - 'null'
      - float
    doc: "Percentage threshold on genomes contamination. (default: 100.0)"
    inputBinding:
      position: 101
      prefix: "--contamination"
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Process the input genomes in parallel. (default: 20)"
    inputBinding:
      position: 101
      prefix: "--nproc"
  - id: pack
    type:
      - 'null'
      - boolean
    doc: "Pack the database into a compressed tarball. (default: False)"
    inputBinding:
      position: 101
      prefix: "--pack"
  - id: uncertainty
    type:
      - 'null'
      - float
    doc: "Uncertainty percentage for considering multiple best hits while profiling input genomes. (default: 20.0)"
    inputBinding:
      position: 101
      prefix: "--uncertainty"
  - id: pruning_threshold
    type:
      - 'null'
      - float
    doc: "Threshold for pruning the Sequence Bloom Tree while profiling input genomes. (default: 0.0)"
    inputBinding:
      position: 101
      prefix: "--pruning-threshold"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: workdir_out
    type: Directory
    doc: "Working directory with the database and the results"
    outputBinding:
      glob: "$(inputs.workdir.basename)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_update.out
