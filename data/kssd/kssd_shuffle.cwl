cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kssd
  - shuffle
label: kssd_shuffle
doc: "Shuffle/sample the k-mer substring space and write a .shuf file.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: half_kmer_len
    type:
      - 'null'
      - int
    doc: "a half of the length of k-mer; for prokaryote genomes k = 8 is suggested; for mammals k = 10 or 11 [8]"
    inputBinding:
      position: 101
      prefix: --halfKmerLen
  - id: half_substr_len
    type:
      - 'null'
      - int
    doc: "a half of the length of k-mer substring [5]"
    inputBinding:
      position: 101
      prefix: --halfSubstrLen
  - id: level
    type:
      - 'null'
      - int
    doc: "the level of dimensionality reduction; the expected reduction rate is 16^n if set -l = n [2]"
    inputBinding:
      position: 101
      prefix: --level
  - id: outfile
    type:
      - 'null'
      - string
    doc: "specify the output file name prefix; default shuffle file is 'default.shuf'"
    inputBinding:
      position: 101
      prefix: --outfile
  - id: use_default
    type:
      - 'null'
      - boolean
    doc: "All options use default value (prokaryote genomes: k=8, s=5, l=2)"
    inputBinding:
      position: 101
      prefix: --usedefault
outputs:
  - id: shuf_file
    type: File
    doc: "The shuffled k-mer substring space file"
    outputBinding:
      glob: "*.shuf"
  - id: stdout_out
    type: stdout
    doc: "Standard output"
stdout: kssd_shuffle.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
