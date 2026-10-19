cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenie
  - populater
label: refgenie_populater
doc: 'Populate registry paths with remote paths.


  Tool homepage: http://refgenie.databio.org'
inputs:
  - id: append_server
    type:
      - 'null'
      - boolean
    doc: Whether the provided servers should be appended to the list.
    inputBinding:
      position: 101
      prefix: --append-server
  - id: file
    type:
      - 'null'
      - File
    doc: File with registry paths to populate
    inputBinding:
      position: 101
      prefix: --file
  - id: genome_server
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more URLs to use. This information will not persist in the genome
      config file.
    inputBinding:
      position: 101
      prefix: --genome-server
  - id: remote_class
    type:
      - 'null'
      - string
    doc: Remote data provider class, e.g. 'http' or 's3'
    inputBinding:
      position: 101
      prefix: --remote-class
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 101
      prefix: --skip-read-lock
  - id: genome_config
    type: File
    doc: Path to the local genome configuration file. It is staged in a writable work
      folder and returned as genome_config_out.
    inputBinding:
      position: 100
      prefix: --genome-config
      valueFrom: $(self.basename)
  - id: genomes_dir
    type:
      - 'null'
      - Directory
    doc: Asset folder of the configuration (the genome_folder entry, "genomes"), from
      a previous refgenie step. It is staged in a writable work folder and returned
      as genomes_dir_out.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: genome_config_out
    type: File
    doc: Updated genome configuration file
    outputBinding:
      glob: $(inputs.genome_config.basename)
  - id: genomes_dir_out
    type: Directory
    doc: Asset folder of the configuration, with the changes of this step
    outputBinding:
      glob: genomes
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.genome_config.basename)
        entry: $(inputs.genome_config)
        writable: true
      - entryname: genomes
        entry: '$(inputs.genomes_dir ? inputs.genomes_dir : {"class": "Directory",
          "listing": []})'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_populater.out
