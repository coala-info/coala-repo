cwlVersion: v1.2
class: CommandLineTool
baseCommand: bleties_insert
label: bleties_insert
doc: "Insert - Insert/Remove IESs to/from MAC reference sequence\n\nTool homepage:
  https://github.com/Swart-lab/bleties"
inputs:
  - id: addsuffix
    type:
      - 'null'
      - boolean
    doc: 'Optional: If feature is split because IES is inserted within it, number
      the segments with ID suffix .seg_0, .seg_1, et seq. in the GFF output file.
      Only relevant if --featuregff is specified.'
    default: false
    inputBinding:
      position: 101
      prefix: --addsuffix
  - id: featuregff
    type:
      - 'null'
      - File
    doc: 'Optional: GFF file of features annotated on the MAC reference genome. Coordinates
      will be updated after addition of IESs. Not applicable when run in delete mode.'
    default: None
    inputBinding:
      position: 101
      prefix: --featuregff
  - id: ies
    type:
      - 'null'
      - File
    doc: GFF file of IES features to be added to reference
    default: None
    inputBinding:
      position: 101
      prefix: --ies
  - id: iesfasta
    type:
      - 'null'
      - File
    doc: FASTA file containing sequences of IES features to be added. Sequence 
      IDs must correspond to IDs in GFF file
    default: None
    inputBinding:
      position: 101
      prefix: --iesfasta
  - id: mode
    type:
      - 'null'
      - string
    doc: "Insert or delete mode? Options: 'insert', 'delete'"
    default: insert
    inputBinding:
      position: 101
      prefix: --mode
  - id: out
    type:
      - 'null'
      - string
    doc: Output filename prefix
    default: insert.test
    inputBinding:
      position: 101
      prefix: --out
  - id: ref
    type:
      - 'null'
      - File
    doc: FASTA file of MAC genome containing reference to be modified
    default: None
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_insert.out
