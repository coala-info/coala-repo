cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenie
label: refgenie_alias
doc: "refgenie - reference genome asset manager\n\nTool homepage: http://refgenie.databio.org"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: add
    type:
      - 'null'
      - boolean
    doc: Add local asset to the config file.
    inputBinding:
      position: 102
  - id: alias
    type:
      - 'null'
      - boolean
    doc: Interact with aliases.
    inputBinding:
      position: 102
  - id: build
    type:
      - 'null'
      - boolean
    doc: Build genome assets.
    inputBinding:
      position: 102
  - id: compare
    type:
      - 'null'
      - boolean
    doc: Compare two genomes.
    inputBinding:
      position: 102
  - id: getseq
    type:
      - 'null'
      - boolean
    doc: Get sequences from a genome.
    inputBinding:
      position: 102
  - id: id
    type:
      - 'null'
      - boolean
    doc: Return the asset digest.
    inputBinding:
      position: 102
  - id: init
    type:
      - 'null'
      - boolean
    doc: Initialize a genome configuration.
    inputBinding:
      position: 102
  - id: list
    type:
      - 'null'
      - boolean
    doc: List available local assets.
    inputBinding:
      position: 102
  - id: listr
    type:
      - 'null'
      - boolean
    doc: List available remote assets.
    inputBinding:
      position: 102
  - id: logdev
    type:
      - 'null'
      - boolean
    doc: Expand content of logging message format.
    inputBinding:
      position: 102
      prefix: --logdev
  - id: populate
    type:
      - 'null'
      - boolean
    doc: Populate registry paths with local paths.
    inputBinding:
      position: 102
  - id: populater
    type:
      - 'null'
      - boolean
    doc: Populate registry paths with remote paths.
    inputBinding:
      position: 102
  - id: pull
    type:
      - 'null'
      - boolean
    doc: Download assets.
    inputBinding:
      position: 102
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove a local asset.
    inputBinding:
      position: 102
  - id: seek
    type:
      - 'null'
      - boolean
    doc: Get the path to a local asset.
    inputBinding:
      position: 102
  - id: seekr
    type:
      - 'null'
      - boolean
    doc: Get the path to a remote asset.
    inputBinding:
      position: 102
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silence logging. Overrides verbosity.
    inputBinding:
      position: 102
      prefix: --silent
  - id: subscribe
    type:
      - 'null'
      - boolean
    doc: Add a refgenieserver URL to the config.
    inputBinding:
      position: 102
  - id: tag
    type:
      - 'null'
      - boolean
    doc: Tag an asset.
    inputBinding:
      position: 102
  - id: unsubscribe
    type:
      - 'null'
      - boolean
    doc: Remove a refgenieserver URL from the config.
    inputBinding:
      position: 102
  - id: upgrade
    type:
      - 'null'
      - boolean
    doc: Upgrade config. This will alter the files on disk.
    inputBinding:
      position: 102
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set logging level (1-5 or logging module level name)
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenie:0.12.1--pyhdfd78af_0
stdout: refgenie_alias.out
