cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_differential_primers_primersearch
label: find_differential_primers_primersearch
doc: "Search DNA sequences for matches with primer pairs\n\nTool homepage: https://github.com/widdowquinn/find_differential_primers"
inputs:
  - id: infile
    type: File
    doc: Primer pairs file
    inputBinding:
      position: 101
      prefix: -infile
  - id: mismatchpercent
    type:
      - 'null'
      - int
    doc: Allowed percent mismatch (Any integer value)
    default: 0
    inputBinding:
      position: 101
      prefix: -mismatchpercent
  - id: seqall
    type: File
    doc: Nucleotide sequence(s) filename and optional format, or reference 
      (input USA)
    inputBinding:
      position: 101
      prefix: -seqall
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Whitehead primer3_core program output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
