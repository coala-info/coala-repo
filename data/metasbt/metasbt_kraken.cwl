cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken
label: metasbt_kraken
doc: "Export a MetaSBT database into a custom kraken database.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: The database name.
    inputBinding:
      position: 101
      prefix: --database
  - id: genomes
    type: File
    doc: "Path to the file with the list of paths to the\ngenomes. Genomes must be
      in the MetaSBT database in\norder to be processed."
    inputBinding:
      position: 101
      prefix: --genomes
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The kmer size in bp.
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: minimizer_length
    type:
      - 'null'
      - int
    doc: The minimizer length in bp.
    inputBinding:
      position: 101
      prefix: --minimizer-length
  - id: minimizer_spaces
    type:
      - 'null'
      - int
    doc: "Number of characters in minimizer that are ignored in\ncomparisons."
    inputBinding:
      position: 101
      prefix: --minimizer-spaces
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for kraken2-build.
    inputBinding:
      position: 101
      prefix: --threads
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
stdout: metasbt_kraken.out
