cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenie
  - populate
label: refgenie_populate
doc: 'Populate registry paths with local paths.


  Tool homepage: http://refgenie.databio.org'
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File with registry paths to populate
    inputBinding:
      position: 101
      prefix: --file
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_populate.out
