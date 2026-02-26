cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - bioconductor-skeleton
label: bioconda-utils_bioconductor-skeleton
doc: "Build a Bioconductor recipe. The recipe will be created in the 'recipes' directory
  and will be prefixed by \"bioconductor-\". If --recursive is set, then any R dependency
  recipes will be prefixed by \"r-\".\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: 'Path to folder containing recipes (default: recipes/)'
    default: recipes/
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to Bioconda config (default: config.yml)'
    default: config.yml
    inputBinding:
      position: 2
  - id: package
    type: string
    doc: Bioconductor package name. This is case-sensitive, and must match the 
      package name on the Bioconductor site. If "update-all-packages" is 
      specified, then all packages in a given bioconductor release will be 
      created/updated (--force is then implied).
    inputBinding:
      position: 3
  - id: bioc_data_packages
    type:
      - 'null'
      - Directory
    doc: 'Path to folder containing the recipe for the bioconductor-data-packages
      (default: recipes/bioconductor-data-packages)'
    default: recipes/bioconductor-data-packages
    inputBinding:
      position: 4
  - id: bioc_version
    type:
      - 'null'
      - string
    doc: Version of Bioconductor to target. If not specified, then automatically
      finds the latest version of Bioconductor with the specified version in 
      --pkg- version, or if --pkg-version not specified, then finds the the 
      latest package version in the latest Bioconductor version
    default: '-'
    inputBinding:
      position: 105
      prefix: --bioc-version
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the contents of an existing recipe. If --recursive is also 
      used, then overwrite *all* recipes created.
    default: false
    inputBinding:
      position: 105
      prefix: --force
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    default: '-'
    inputBinding:
      position: 105
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write log to file
    default: '-'
    inputBinding:
      position: 105
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    default: debug
    inputBinding:
      position: 105
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    default: debug
    inputBinding:
      position: 105
      prefix: --loglevel
  - id: pkg_version
    type:
      - 'null'
      - string
    doc: Package version to use instead of the current one
    default: '-'
    inputBinding:
      position: 105
      prefix: --pkg-version
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Creates the recipes for all Bioconductor and CRAN dependencies of the 
      specified package.
    default: false
    inputBinding:
      position: 105
      prefix: --recursive
  - id: skip_if_in_channels
    type:
      - 'null'
      - type: array
        items: string
    doc: When --recursive is used, it will build *all* recipes. Use this 
      argument to skip recursive building for packages that already exist in the
      packages listed here.
    default:
      - conda-forge
      - bioconda
    inputBinding:
      position: 105
      prefix: --skip-if-in-channels
  - id: versioned
    type:
      - 'null'
      - boolean
    doc: If specified, recipe will be created in RECIPES/<package>/<version>
    default: false
    inputBinding:
      position: 105
      prefix: --versioned
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_bioconductor-skeleton.out
