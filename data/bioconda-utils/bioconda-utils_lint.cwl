cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-utils lint
label: bioconda-utils_lint
doc: "Lint recipes\n\nTool homepage: http://bioconda.github.io/build-system.html"
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
  - id: cache
    type:
      - 'null'
      - File
    doc: To speed up debugging, use repodata cached locally in the provided 
      filename. If the file does not exist, it will be created the first time.
    inputBinding:
      position: 103
      prefix: --cache
  - id: commit
    type:
      - 'null'
      - string
    doc: Commit on github on which to update status
    inputBinding:
      position: 103
      prefix: --commit
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude this linting function. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --exclude
  - id: full_report
    type:
      - 'null'
      - boolean
    doc: Default behavior is to summarize the linting results; use this argument
      to get the full results as a TSV printed to stdout.
    inputBinding:
      position: 103
      prefix: --full-report
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
  - id: list_checks
    type:
      - 'null'
      - boolean
    doc: List the linting functions to be used and then exit
    inputBinding:
      position: 103
      prefix: --list-checks
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
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob for package[s] to build. Default is to build all packages. Can be 
      specified more than once
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
  - id: pull_request
    type:
      - 'null'
      - string
    doc: Pull request id on github on which to post a comment.
    inputBinding:
      position: 103
      prefix: --pull-request
  - id: push_comment
    type:
      - 'null'
      - boolean
    doc: If set, the lint status will be posted as a comment in the 
      corresponding pull request (given by --pull-request). Also needs --user 
      and --repo to be set. Requires the env var GITHUB_TOKEN to be set.
    inputBinding:
      position: 103
      prefix: --push-comment
  - id: push_status
    type:
      - 'null'
      - boolean
    doc: If set, the lint status will be sent to the current commit on github. 
      Also needs --user and --repo to be set. Requires the env var GITHUB_TOKEN 
      to be set. Note that pull requests from forks will not have access to 
      encrypted variables on ci, so this feature may be of limited use.
    inputBinding:
      position: 103
      prefix: --push-status
  - id: repo
    type:
      - 'null'
      - string
    doc: Github repo
    inputBinding:
      position: 103
      prefix: --repo
  - id: try_fix
    type:
      - 'null'
      - boolean
    doc: Attempt to fix problems where found
    inputBinding:
      position: 103
      prefix: --try-fix
  - id: user
    type:
      - 'null'
      - string
    doc: Github user
    inputBinding:
      position: 103
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_lint.out
