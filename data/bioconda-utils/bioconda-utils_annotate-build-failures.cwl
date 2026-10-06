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
      items: Directory
    doc: Recipe folders that shall be skiplisted (staged writable; the 
      build_failure.<platform>.yaml record is written inside each folder)
    inputBinding:
      position: 1
      valueFrom: '$(self.map(function(d){ return d.basename; }))'
  - id: category
    type:
      - 'null'
      - string
    doc: Category of build failure. If omitted, will fail if there is no 
      existing build failure record with a log entry.
    inputBinding:
      position: 102
      prefix: --category
  - id: existing_only
    type:
      - 'null'
      - boolean
    doc: Only annotate already existing build failure records. The platform 
      setting is ignored in this case.
    inputBinding:
      position: 102
      prefix: --existing-only
  - id: platforms
    type:
      - 'null'
      - type: array
        items: string
    doc: Platforms to annotate
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
    inputBinding:
      position: 102
      prefix: --reason
  - id: skiplist
    type:
      - 'null'
      - boolean
    doc: Skiplist recipes.
    inputBinding:
      position: 102
      prefix: --skiplist
outputs:
  - id: annotated_recipes
    type:
      type: array
      items: Directory
    doc: Recipe folders with their build failure records
    outputBinding:
      glob: '$(inputs.recipes.map(function(d){ return d.basename; }))'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.recipes)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_annotate-build-failures.out
