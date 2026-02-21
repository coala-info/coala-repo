cwlVersion: v1.2
class: CommandLineTool
baseCommand: scompare
label: consan_scompare
doc: "Given a MSA, calculate foldings for all pairs. Output two files -- predicted
  pairs to stdout and given pairs to a required -s file.\n\nTool homepage: http://eddylab.org/software/consan/"
inputs:
  - id: test_msa
    type: File
    doc: Input multiple sequence alignment (MSA) file
    inputBinding:
      position: 1
  - id: cyk_predicted_pins
    type:
      - 'null'
      - int
    doc: do CYK and use <int> predicted pins
    inputBinding:
      position: 102
      prefix: -P
  - id: cyk_trusted_pins
    type:
      - 'null'
      - int
    doc: do CYK and use <int> pins from trusted alignment
    inputBinding:
      position: 102
      prefix: -C
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: full_sankoff
    type:
      - 'null'
      - boolean
    doc: do full sankoff (no constraints)
    inputBinding:
      position: 102
      prefix: -f
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: Ensure that pin selection results in something near X Mbytes memory
    inputBinding:
      position: 102
      prefix: -M
  - id: suppress_output
    type:
      - 'null'
      - boolean
    doc: suppress extra output
    inputBinding:
      position: 102
      prefix: -S
  - id: traceback
    type:
      - 'null'
      - boolean
    doc: print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: given_structure_output
    type: File
    doc: Output of given structure in ordered pairs (needed for comppair)
    outputBinding:
      glob: $(inputs.given_structure_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
