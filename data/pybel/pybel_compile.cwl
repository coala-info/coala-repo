cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - compile
label: pybel_compile
doc: "Compile a BEL script to a graph.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: "Path to the BEL script (a writable copy is staged because the compiled pickle is written beside it)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: allow_naked_names
    type:
      - 'null'
      - boolean
    doc: "Enable lenient parsing for naked names"
    inputBinding:
      position: 10
      prefix: --allow-naked-names
  - id: allow_nested
    type:
      - 'null'
      - boolean
    doc: "Enable lenient parsing for nested statements"
    inputBinding:
      position: 10
      prefix: --allow-nested
  - id: disallow_unqualified_translocations
    type:
      - 'null'
      - boolean
    doc: "Disallow unqualified translocations"
    inputBinding:
      position: 10
      prefix: --disallow-unqualified-translocations
  - id: no_identifier_validation
    type:
      - 'null'
      - boolean
    doc: "Turn off identifier validation"
    inputBinding:
      position: 10
      prefix: --no-identifier-validation
  - id: no_citation_clearing
    type:
      - 'null'
      - boolean
    doc: "Turn off citation clearing"
    inputBinding:
      position: 10
      prefix: --no-citation-clearing
  - id: required_annotations
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --required-annotations
    doc: Specify multiple required annotations (the option is repeated per value)
    inputBinding:
      position: 10
  - id: skip_tqdm
    type:
      - 'null'
      - boolean
    doc: "Skip the tqdm progress bar"
    inputBinding:
      position: 10
      prefix: --skip-tqdm
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose output"
    inputBinding:
      position: 10
      prefix: --verbose
outputs:
  - id: graph_pickle
    type: File
    doc: Compiled graph (BEL script path plus .pickle)
    outputBinding:
      glob: $(inputs.path.basename).pickle
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_compile.out
