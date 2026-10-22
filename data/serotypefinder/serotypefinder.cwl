cwlVersion: v1.2
class: CommandLineTool
baseCommand: serotypefinder
label: serotypefinder
doc: 'SerotypeFinder identifies the serotype (O and H antigen genes) of Escherichia coli from assembled genomes or reads.


  Tool homepage: https://bitbucket.org/genomicepidemiology/serotypefinder'
inputs:
  - id: infile
    type: File[]
    doc: FASTA or FASTQ input files.
    inputBinding:
      position: 1
      prefix: --infile
  - id: output_path
    type: string
    doc: Output directory (created before the run).
    inputBinding:
      position: 2
      prefix: --outputPath
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory for storage of the results from the external software.
    inputBinding:
      position: 3
      prefix: --tmp_dir
  - id: method_path
    type:
      - 'null'
      - string
    doc: Path to method to use (kma or blastn).
    inputBinding:
      position: 4
      prefix: --methodPath
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Path to the databases.
    inputBinding:
      position: 5
      prefix: --databasePath
  - id: databases
    type:
      - 'null'
      - string
    doc: Databases chosen to search in - if none is specified all is used.
    inputBinding:
      position: 6
      prefix: --databases
  - id: mincov
    type:
      - 'null'
      - float
    doc: Minimum coverage.
    inputBinding:
      position: 7
      prefix: --mincov
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum threshold for identity.
    inputBinding:
      position: 8
      prefix: --threshold
  - id: extented_output
    type:
      - 'null'
      - boolean
    doc: Give extended output with alignment files, template and query hits in fasta and a tab separated file with gene profile results.
    inputBinding:
      position: 9
      prefix: --extented_output
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode.
    inputBinding:
      position: 10
      prefix: --quiet
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/serotypefinder:2.0.2--py312hdfd78af_1
