cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd make-recipe
label: ggd_make-recipe
doc: "Make a ggd data recipe from a bash script\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: script
    type: string
    doc: bash script that contains the commands to obtain and process the data
    inputBinding:
      position: 1
  - id: authors
    type: string
    doc: The author(s) of the data recipe being created, (This recipe)
    inputBinding:
      position: 102
      prefix: --authors
  - id: channel
    type:
      - 'null'
      - string
    doc: the ggd channel to use.
    default: genomics
    inputBinding:
      position: 102
      prefix: --channel
  - id: coordinate_base
    type: string
    doc: The genomic coordinate basing for the file(s) in the recipe. That is, 
      the coordinates start at genomic coordinate 0 or 1, and the end coordinate
      is either inclusive (everything up to and including the end coordinate) or
      exclusive (everything up to but not including the end coordinate) Files 
      that do not have coordinate basing, like fasta files, specify NA for not 
      applicable.
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
    type: string
    doc: "The version of the data (itself) being downloaded and processed (EX: dbsnp-127)
      If there is no data version apparent we recommend you use the date associated
      with the files or something else that can uniquely identify the 'version' of
      the data"
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
  - id: extra_file
    type:
      - 'null'
      - type: array
        items: File
    doc: any files that the recipe creates that are not a *.gz and *.gz.tbi pair
      or *.fa and *.fai pair. May be used more than once
    inputBinding:
      position: 102
      prefix: --extra-file
  - id: genome_build
    type: string
    doc: The genome build the recipe is for
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
    doc: The sub-name of the recipe being created. (e.g. cpg- islands, 
      pfam-domains, gaps, etc.) This will not be the final name of the recipe, 
      but will specific to the data gathered and processed by the recipe
    inputBinding:
      position: 102
      prefix: --name
  - id: package_version
    type: string
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
    default: noarch
    inputBinding:
      position: 102
      prefix: --platform
  - id: species
    type: string
    doc: The species recipe is for
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
stdout: ggd_make-recipe.out
