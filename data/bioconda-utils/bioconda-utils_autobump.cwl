cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - autobump
label: bioconda-utils_autobump
doc: "Updates recipes in recipe_folder\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: Path to folder containing recipes
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : self.basename)'
  - id: config
    type:
      - 'null'
      - File
    doc: Path to Bioconda config
    inputBinding:
      position: 2
      valueFrom: '$(self === null ? null : self.basename)'
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the config names by relative path (for example the files listed 
      under `blacklists:`); they are staged beside the config so the names 
      resolve
  - id: cache
    type:
      - 'null'
      - File
    doc: 'To speed up debugging, use repodata cached locally in the provided filename.
      If the file does not exist, it will be created the first time. Caution: The
      cache will not be updated if exclude-channels is changed'
    inputBinding:
      position: 103
      prefix: --cache
  - id: check_branch
    type:
      - 'null'
      - boolean
    doc: Check if recipe has active branch
    inputBinding:
      position: 103
      prefix: --check-branch
  - id: commit_as
    type:
      - 'null'
      - type: array
        items: string
    doc: Set user and email to use for committing. Takes exactly two arguments.
    inputBinding:
      position: 103
      prefix: --commit-as
  - id: create_branch
    type:
      - 'null'
      - boolean
    doc: Create branch for each update
    inputBinding:
      position: 103
      prefix: --create-branch
  - id: create_pr
    type:
      - 'null'
      - boolean
    doc: Create PR for each update. Implies create-branch.
    inputBinding:
      position: 103
      prefix: --create-pr
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't update remote git or github
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Globs for package[s] to exclude from scan. Can be specified more than 
      once
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_channels
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude recipes building packages present in other channels. Set to 
      'none' to disable check.
    inputBinding:
      position: 103
      prefix: --exclude-channels
  - id: exclude_subrecipes
    type:
      - 'null'
      - string
    doc: By default, only subrecipes explicitly enabled for watch in meta.yaml 
      are considered. Set to 'always' to exclude all subrecipes. Set to 'never' 
      to include all subrecipes
    inputBinding:
      position: 103
      prefix: --exclude-subrecipes
  - id: failed_urls
    type:
      - 'null'
      - string
    doc: Write urls with permanent failure to this file
    inputBinding:
      position: 103
      prefix: --failed-urls
  - id: fetch_requirements
    type:
      - 'null'
      - boolean
    doc: Try to fetch python requirements. Please note that this requires 
      downloading packages and executing setup.py, so presents a potential 
      security problem.
    inputBinding:
      position: 103
      prefix: --fetch-requirements
  - id: ignore_skiplists
    type:
      - 'null'
      - boolean
    doc: Do not exclude skiplisted recipes
    inputBinding:
      position: 103
      prefix: --ignore-skiplists
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    inputBinding:
      position: 103
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - string
    doc: Write log to file
    inputBinding:
      position: 103
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    inputBinding:
      position: 103
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: max_updates
    type:
      - 'null'
      - int
    doc: Exit after ARG updates
    inputBinding:
      position: 103
      prefix: --max-updates
  - id: no_check_pending_deps
    type:
      - 'null'
      - boolean
    doc: Don't check for recipes having a dependency with a pending update. 
      Update all recipes, including those having deps in need or rebuild.
    inputBinding:
      position: 103
      prefix: --no-check-pending-deps
  - id: no_check_pinnings
    type:
      - 'null'
      - boolean
    doc: Don't check for pinning updates
    inputBinding:
      position: 103
      prefix: --no-check-pinnings
  - id: no_check_version_update
    type:
      - 'null'
      - boolean
    doc: Don't check for version updates to recipes
    inputBinding:
      position: 103
      prefix: --no-check-version-update
  - id: no_follow_graph
    type:
      - 'null'
      - boolean
    doc: Don't process recipes in graph order or add dependent recipes to 
      checks. Implies --no-skip-pending-deps.
    inputBinding:
      position: 103
      prefix: --no-follow-graph
  - id: no_shuffle
    type:
      - 'null'
      - boolean
    doc: Do not shuffle recipe order
    inputBinding:
      position: 103
      prefix: --no-shuffle
  - id: only_active
    type:
      - 'null'
      - boolean
    doc: Check only recipes with active update
    inputBinding:
      position: 103
      prefix: --only-active
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob(s) for package[s] to scan. Can be specified more than once
    inputBinding:
      position: 103
      prefix: --packages
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on exception
    inputBinding:
      position: 103
      prefix: -P
  - id: recipe_status
    type:
      - 'null'
      - string
    doc: Write status for each recipe to this file
    inputBinding:
      position: 103
      prefix: --recipe-status
  - id: sign
    type:
      - 'null'
      - string
    doc: Enable signing. Optionally takes keyid.
    inputBinding:
      position: 103
      prefix: --sign
  - id: threads
    type:
      - 'null'
      - int
    doc: Limit maximum number of processes used.
    inputBinding:
      position: 103
      prefix: --threads
  - id: unparsed_urls
    type:
      - 'null'
      - string
    doc: Write unrecognized urls to this file
    inputBinding:
      position: 103
      prefix: --unparsed-urls
outputs:
  - id: failed_urls_out
    type:
      - 'null'
      - File
    doc: File written by --failed-urls
    outputBinding:
      glob: $(inputs.failed_urls)
  - id: recipe_status_out
    type:
      - 'null'
      - File
    doc: File written by --recipe-status
    outputBinding:
      glob: $(inputs.recipe_status)
  - id: unparsed_urls_out
    type:
      - 'null'
      - File
    doc: File written by --unparsed-urls
    outputBinding:
      glob: $(inputs.unparsed_urls)
  - id: recipes_out
    type:
      - 'null'
      - Directory
    doc: Recipe folder after the run (staged writable)
    outputBinding:
      glob: '$(inputs.recipe_folder === null ? "recipes" : inputs.recipe_folder.basename)'
  - id: logfile_out
    type:
      - 'null'
      - File
    doc: Log file written by --logfile
    outputBinding:
      glob: $(inputs.logfile)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.config_files)
      - entry: $(inputs.recipe_folder)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_autobump.out
