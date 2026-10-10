cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, kraken]
label: metasbt_kraken
doc: "Export a MetaSBT database into a custom kraken database.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
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
  - id: genomes
    type: File
    doc: "Path to the file with the list of paths to the genomes. Genomes must be in the MetaSBT database in order to be processed."
    inputBinding:
      position: 101
      prefix: "--genomes"
  - id: genome_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The genome files named in the genomes list; they are staged in the working directory so that the names in the list resolve."
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "The kmer size in bp. (default: 27)"
    inputBinding:
      position: 101
      prefix: "--kmer-size"
  - id: minimizer_length
    type:
      - 'null'
      - int
    doc: "The minimizer length in bp. (default: 21)"
    inputBinding:
      position: 101
      prefix: "--minimizer-length"
  - id: minimizer_spaces
    type:
      - 'null'
      - int
    doc: "Number of characters in minimizer that are ignored in comparisons. (default: 5)"
    inputBinding:
      position: 101
      prefix: "--minimizer-spaces"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for kraken2-build. (default: 1)"
    inputBinding:
      position: 101
      prefix: "--threads"
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
stdout: metasbt_kraken.out
