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
    doc: Path to the BEL script
    inputBinding:
      position: 1
  - id: allow_naked_names
    type:
      - 'null'
      - boolean
    doc: Enable lenient parsing for naked names
    inputBinding:
      position: 102
      prefix: --allow-naked-names
  - id: allow_nested
    type:
      - 'null'
      - boolean
    doc: Enable lenient parsing for nested statements
    inputBinding:
      position: 102
      prefix: --allow-nested
  - id: disallow_unqualified_translocations
    type:
      - 'null'
      - boolean
    doc: Disallow unqualified translocations
    inputBinding:
      position: 102
      prefix: --disallow-unqualified-translocations
  - id: no_citation_clearing
    type:
      - 'null'
      - boolean
    doc: Turn off citation clearing
    inputBinding:
      position: 102
      prefix: --no-citation-clearing
  - id: no_identifier_validation
    type:
      - 'null'
      - boolean
    doc: Turn off identifier validation
    inputBinding:
      position: 102
      prefix: --no-identifier-validation
  - id: required_annotations
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify multiple required annotations
    inputBinding:
      position: 102
      prefix: --required-annotations
  - id: skip_tqdm
    type:
      - 'null'
      - boolean
    doc: Skip tqdm progress bar
    inputBinding:
      position: 102
      prefix: --skip-tqdm
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_compile.out
