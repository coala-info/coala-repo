cwlVersion: v1.2
class: CommandLineTool
baseCommand: bstats
label: consan_bstats
doc: "Bootstrap summary statistics (mean, variance and standard deviation of base-pair
  sensitivity, PPV and alignment accuracy) from a table of per-pair comparison results
  (made from comppair output with bsinputTOT.pl, or from compstruct output with bsinput.pl).\n\nTool
  homepage: http://eddylab.org/software/consan/"
inputs:
  - id: input_file
    type: File
    doc: 'bootstrap input table, one line per comparison: correct pairs, trusted pairs,
      predicted pairs, correct alignment symbols, total alignment symbols'
    inputBinding:
      position: 201
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 103
      prefix: -v
  - id: iterations
    type:
      - 'null'
      - int
    doc: Sampling iterations
    inputBinding:
      position: 103
      prefix: -i
  - id: diff_output
    type:
      - 'null'
      - string
    doc: Output diff data to <file>
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: original dataset statistics and bootstrap results
  - id: diff_data
    type:
      - 'null'
      - File
    doc: diff data file (with -d)
    outputBinding:
      glob: $(inputs.diff_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
stdout: consan_bstats.out
