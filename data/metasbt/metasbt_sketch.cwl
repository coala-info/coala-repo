cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, sketch]
label: metasbt_sketch
doc: "Sketch the input genomes.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
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
    type:
      - 'null'
      - string
    doc: "The database name. (default: MetaSBT)"
    default: "MetaSBT"
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
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Process the input genomes in parallel. (default: 20)"
    inputBinding:
      position: 101
      prefix: "--nproc"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: workdir_out
    type: Directory
    doc: "Working directory with the database and the results"
    outputBinding:
      glob: "$(inputs.workdir.basename)"
  - id: sketches
    type: Directory
    doc: "Folder with the sketches of the database"
    outputBinding:
      glob: "$(inputs.workdir.basename)/$(inputs.database)/sketches"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_sketch.out
