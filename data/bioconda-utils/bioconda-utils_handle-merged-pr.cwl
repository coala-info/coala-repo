cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - handle-merged-pr
label: bioconda-utils_handle-merged-pr
doc: "Handle merged pull requests for Bioconda recipes.\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: Path to folder containing recipes
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to Bioconda config
    inputBinding:
      position: 2
  - id: artifact_source
    type:
      - 'null'
      - string
    doc: Application hosting build artifacts (e.g., Azure, Circle CI, or GitHub 
      Actions).
    inputBinding:
      position: 103
      prefix: --artifact-source
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not actually upload anything.
    inputBinding:
      position: 103
      prefix: --dryrun
  - id: fallback
    type:
      - 'null'
      - string
    doc: What to do if no artifacts are found in the PR.
    inputBinding:
      position: 103
      prefix: --fallback
  - id: git_range
    type:
      - 'null'
      - type: array
        items: string
    doc: Git range (e.g. commits or something like "master HEAD" to check 
      commits in HEAD vs master, or just "HEAD" to include uncommitted changes).
      All recipes modified within this range will be built if not present in the
      channel.
    inputBinding:
      position: 103
      prefix: --git-range
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
      - File
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
  - id: quay_upload_target
    type:
      - 'null'
      - string
    doc: Provide a quay.io target to push docker images to.
    inputBinding:
      position: 103
      prefix: --quay-upload-target
  - id: repo
    type:
      - 'null'
      - string
    doc: Name of the github repository to check (e.g. 
      bioconda/bioconda-recipes).
    inputBinding:
      position: 103
      prefix: --repo
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_handle-merged-pr.out
