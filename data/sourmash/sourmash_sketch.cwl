cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash sketch
label: sourmash_sketch
doc: "Create signatures\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: dna
    type:
      - 'null'
      - boolean
    doc: create DNA signatures
    inputBinding:
      position: 101
      prefix: dna
  - id: fromfile
    type:
      - 'null'
      - boolean
    doc: create signatures from a CSV file
    inputBinding:
      position: 101
      prefix: fromfile
  - id: protein
    type:
      - 'null'
      - boolean
    doc: create protein signatures
    inputBinding:
      position: 101
      prefix: protein
  - id: translate
    type:
      - 'null'
      - boolean
    doc: create protein signature from DNA/RNA sequence
    inputBinding:
      position: 101
      prefix: translate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash_sketch.out
