cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenie
  - build
label: refgenie_build
doc: 'Build genome assets.


  Tool homepage: http://refgenie.databio.org'
inputs:
  - id: asset_registry_paths
    type:
      type: array
      items: string
    doc: One or more registry path strings that identify assets (e.g. hg38/fasta or
      hg38/fasta:tag).
    inputBinding:
      position: 1
  - id: assets
    type:
      - 'null'
      - type: array
        items: string
    doc: Override the default genome, asset and tag of the parents (e.g. fasta=hg38/fasta:default
      gtf=mm10/gencode_gtf:default).
    inputBinding:
      position: 102
      prefix: --assets
  - id: config_file
    type:
      - 'null'
      - File
    doc: Pipeline configuration file (YAML). Relative paths are with respect to the
      pipeline script.
    inputBinding:
      position: 102
      prefix: --config
  - id: docker
    type:
      - 'null'
      - boolean
    doc: Run all commands in the refgenie docker container.
    inputBinding:
      position: 102
      prefix: --docker
  - id: files
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide paths to the required files (e.g. fasta=/path/to/file.fa.gz).
    inputBinding:
      position: 102
      prefix: --files
  - id: genome
    type:
      - 'null'
      - string
    doc: Reference assembly ID, e.g. mm10.
    inputBinding:
      position: 102
      prefix: --genome
  - id: genome_description
    type:
      - 'null'
      - string
    doc: Add genome level description (e.g. The mouse mitochondrial genome, released
      in Dec 2013).
    inputBinding:
      position: 102
      prefix: --genome-description
  - id: map
    type:
      - 'null'
      - boolean
    doc: 'Run the map procedure: build assets and store the metadata in separate configs.'
    inputBinding:
      position: 102
      prefix: --map
  - id: new_start
    type:
      - 'null'
      - boolean
    doc: Overwrite all results to start a fresh run
    inputBinding:
      position: 102
      prefix: --new-start
  - id: params
    type:
      - 'null'
      - type: array
        items: string
    doc: Provide required parameter values (e.g. param1=value1).
    inputBinding:
      position: 102
      prefix: --params
  - id: preserve_map_configs
    type:
      - 'null'
      - boolean
    doc: Do not remove the genome configuration files produced in the potential map
      step of building
    inputBinding:
      position: 102
      prefix: --preserve-map-configs
  - id: pull_parents
    type:
      - 'null'
      - boolean
    doc: Automatically pull the default parent asset if required but not provided
    inputBinding:
      position: 102
      prefix: --pull-parents
  - id: recipe
    type:
      - 'null'
      - string
    doc: Provide a recipe to use.
    inputBinding:
      position: 102
      prefix: --recipe
  - id: recover
    type:
      - 'null'
      - boolean
    doc: Overwrite locks to recover from previous failed run
    inputBinding:
      position: 102
      prefix: --recover
  - id: reduce
    type:
      - 'null'
      - boolean
    doc: 'Run the reduce procedure: gather the metadata produced with `refgenie build
      --map`.'
    inputBinding:
      position: 102
      prefix: --reduce
  - id: requirements
    type:
      - 'null'
      - boolean
    doc: Show the build requirements for the specified asset and exit.
    inputBinding:
      position: 102
      prefix: --requirements
  - id: skip_read_lock
    type:
      - 'null'
      - boolean
    doc: Whether the config file should not be locked for reading
    inputBinding:
      position: 102
      prefix: --skip-read-lock
  - id: tag_description
    type:
      - 'null'
      - string
    doc: Add tag level description (e.g. built with version 0.3.2).
    inputBinding:
      position: 102
      prefix: --tag-description
  - id: volumes
    type:
      - 'null'
      - type: array
        items: string
    doc: If using docker, also mount these folders as volumes.
    inputBinding:
      position: 102
      prefix: --volumes
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
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files required by the recipe (for example the FASTA file for the fasta asset).
      They are staged in the working directory, so name them in the files option by
      their file name (for example fasta=genome.fa.gz).
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
      - $(inputs.input_files)
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_build.out
