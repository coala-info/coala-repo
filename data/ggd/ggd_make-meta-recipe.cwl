cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd make-meta-recipe
label: ggd_make-meta-recipe
doc: "Make a ggd data meta-recipe\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: script
    type: File
    doc: bash script that contains the commands for the metarecipe.
    inputBinding:
      position: 1
  - id: authors
    type: string
    doc: The author(s) of the data metarecipe being created, (This recipe)
    inputBinding:
      position: 102
      prefix: --authors
  - id: channel
    type:
      - 'null'
      - string
    doc: the ggd channel to use.
    inputBinding:
      position: 102
      prefix: --channel
  - id: coordinate_base
    type:
      - 'null'
      - string
    doc: The genomic coordinate basing for the file(s) in the recipe. Use 'NA' 
      for a metarecipe
    inputBinding:
      position: 102
      prefix: --coordinate-base
  - id: data_provider
    type: string
    doc: 'The data provider where the data was accessed. (Example: UCSC, Ensembl,
      gnomAD, etc.)'
    inputBinding:
      position: 102
      prefix: --data-provider
  - id: data_version
    type:
      - 'null'
      - string
    doc: "The version of the data (itself) being downloaded and processed (EX: dbsnp-127).
      Use 'metarecipe' for a metarecipe"
    inputBinding:
      position: 102
      prefix: --data-version
  - id: dependency
    type:
      - 'null'
      - type: array
        items: string
    doc: any software dependencies (in bioconda, conda-forge) or data-dependency
      (in ggd). May be as many times as needed.
    inputBinding:
      position: 102
      prefix: --dependency
  - id: extra_scripts
    type:
      - 'null'
      - type: array
        items: File
    doc: Any additional scripts used for the metarecipe that are not the main 
      bash script
    inputBinding:
      position: 102
      prefix: --extra-scripts
  - id: genome_build
    type:
      - 'null'
      - string
    doc: The genome build the recipe is for. Use 'metarecipe' for a metarecipe 
      file
    inputBinding:
      position: 102
      prefix: --genome-build
  - id: keyword
    type:
      type: array
      items: string
    doc: A keyword to associate with the recipe. May be specified more that 
      once. Please add enough keywords to better describe and distinguish the 
      recipe
    inputBinding:
      position: 102
      prefix: --keyword
  - id: name
    type: string
    doc: The sub-name of the recipe being created. (e.g. cpg-islands, 
      pfam-domains, gaps, etc.) This will not be the final name of the recipe, 
      but will specific to the data gathered and processed by the recipe
    inputBinding:
      position: 102
      prefix: --name
  - id: package_version
    type: int
    doc: The version of the ggd package. (First time package = 1, updated 
      package > 1)
    inputBinding:
      position: 102
      prefix: --package-version
  - id: platform
    type:
      - 'null'
      - string
    doc: Whether to use noarch as the platform or the system platform. If set to
      'none' the system platform will be used. (Default = noarch. Noarch means 
      no architecture and is platform agnostic.)
    inputBinding:
      position: 102
      prefix: --platform
  - id: species
    type:
      - 'null'
      - string
    doc: The species recipe is for. Use 'meta-recipe` for a metarecipe file
    inputBinding:
      position: 102
      prefix: --species
  - id: summary
    type: string
    doc: A detailed comment describing the recipe
    inputBinding:
      position: 102
      prefix: --summary
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_make-meta-recipe.out
