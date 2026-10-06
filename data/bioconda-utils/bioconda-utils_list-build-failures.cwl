cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - list-build-failures
label: bioconda-utils_list-build-failures
doc: "List recipes with build failure records\n\nTool homepage: http://bioconda.github.io/build-system.html"
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
      valueFrom: '$(self === null ? null : self.basename)'
  - id: config_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files the config names by relative path (for example the files listed 
      under `blacklists:`); they are staged beside the config so the names 
      resolve
  - id: channel
    type:
      - 'null'
      - string
    doc: Channel with packages to check
    inputBinding:
      position: 103
      prefix: --channel
  - id: git_range
    type:
      - 'null'
      - type: array
        items: string
    doc: Git range (e.g. commits or something like "master HEAD" to check 
      commits in HEAD vs master, or just "HEAD" to include uncommitted changes).
    inputBinding:
      position: 103
      prefix: --git-range
  - id: link_prefix
    type:
      - 'null'
      - string
    doc: Prefix for links to build failures
    inputBinding:
      position: 103
      prefix: --link-prefix
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 103
      prefix: --output-format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.config_files)
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_list-build-failures.out
