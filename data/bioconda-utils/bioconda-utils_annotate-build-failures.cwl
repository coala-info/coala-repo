cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconda-utils
  - annotate-build-failures
label: bioconda-utils_annotate-build-failures
doc: "Annotate build failures for recipes.\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipes
    type:
      type: array
      items: string
    doc: Paths to recipes that shall be skiplisted
    inputBinding:
      position: 1
  - id: category
    type:
      - 'null'
      - string
    doc: Category of build failure. If omitted, will fail if there is no 
      existing build failure record with a log entry.
    default: '-'
    inputBinding:
      position: 102
      prefix: --category
  - id: existing_only
    type:
      - 'null'
      - boolean
    doc: Only annotate already existing build failure records. The platform 
      setting is ignored in this case.
    default: false
    inputBinding:
      position: 102
      prefix: --existing-only
  - id: platforms
    type:
      - 'null'
      - type: array
        items: string
    doc: Platforms to annotate
    default:
      - linux-64
      - osx-64
    inputBinding:
      position: 102
      prefix: --platforms
  - id: reason
    type:
      - 'null'
      - string
    doc: Reason for skiplisting. If omitted, will fail if there is no existing 
      build failure record with a log entry.
    default: '-'
    inputBinding:
      position: 102
      prefix: --reason
  - id: skiplist
    type:
      - 'null'
      - boolean
    doc: Skiplist recipes.
    default: false
    inputBinding:
      position: 102
      prefix: --skiplist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_annotate-build-failures.out
