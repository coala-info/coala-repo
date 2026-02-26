cwlVersion: v1.2
class: CommandLineTool
baseCommand: go get
label: go_get
doc: "Run 'go help get' for details.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: build flags
    inputBinding:
      position: 1
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: packages to get
    inputBinding:
      position: 2
  - id: download_only
    type:
      - 'null'
      - boolean
    doc: download packages but do not build or install them
    inputBinding:
      position: 103
      prefix: -d
  - id: fix
    type:
      - 'null'
      - boolean
    doc: download packages and run go fix on them
    inputBinding:
      position: 103
      prefix: -fix
  - id: force_download
    type:
      - 'null'
      - boolean
    doc: force the overwriting of existing code
    inputBinding:
      position: 103
      prefix: -f
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: allow fetching of repositories from insecure locations
    inputBinding:
      position: 103
      prefix: -insecure
  - id: only_build_tags
    type:
      - 'null'
      - boolean
    doc: download and build packages that are dependencies of the named 
      packages, even if they are already installed.
    inputBinding:
      position: 103
      prefix: -t
  - id: update_packages
    type:
      - 'null'
      - boolean
    doc: enable loading of all code from the network (even for dependencies that
      have already been downloaded)
    inputBinding:
      position: 103
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print additional information about what the command is doing
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_get.out
