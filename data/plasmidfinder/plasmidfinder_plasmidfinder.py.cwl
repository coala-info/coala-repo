cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidfinder.py
label: plasmidfinder_plasmidfinder.py
doc: "PlasmidFinder is a tool for identifying plasmids in bacterial genomes.\n\nTool
  homepage: https://bitbucket.org/genomicepidemiology/plasmidfinder"
inputs:
  - id: infile
    type:
      type: array
      items: File
    doc: FASTA or FASTQ input files.
    inputBinding:
      position: 1
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Path to the databases
    inputBinding:
      position: 102
      prefix: --databasePath
  - id: databases
    type:
      - 'null'
      - string
    doc: "Databases chosen to search in - if non is specified\nall is used"
    inputBinding:
      position: 102
      prefix: --databases
  - id: extented_output
    type:
      - 'null'
      - boolean
    doc: "Give extented output with allignment files, template\nand query hits in
      fasta and a tab seperated file with\ngene profile results"
    inputBinding:
      position: 102
      prefix: --extented_output
  - id: method_path
    type:
      - 'null'
      - string
    doc: Path to method to use (kma or blastn)
    inputBinding:
      position: 102
      prefix: --methodPath
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum coverage
    inputBinding:
      position: 102
      prefix: --mincov
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --quiet
  - id: speciesinfo_json
    type:
      - 'null'
      - string
    doc: "Argument used by the cge pipeline. It takes a list in\njson format consisting
      of taxonomy, from domain ->\nspecies. A database is chosen based on the taxonomy."
    inputBinding:
      position: 102
      prefix: --speciesinfo_json
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum hreshold for identity
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: "Temporary directory for storage of the results from\nthe external software."
    inputBinding:
      position: 102
      prefix: --tmp_dir
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to blast output
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidfinder:2.1.6--hdfd78af_0
