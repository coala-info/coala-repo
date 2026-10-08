cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CHROMEISTER
label: chromeister_CHROMEISTER
doc: "Ultra-fast pairwise genome comparison: writes a comparison matrix (dotplot
  of unique k-mer hits) and a .csv file with the sequence names and lengths of each
  axis. The reverse complementary is calculated for the query.\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs:
  - id: query
    type: File
    doc: query sequence (FASTA)
    inputBinding:
      position: 101
      prefix: -query
  - id: db
    type: File
    doc: database sequence (FASTA)
    inputBinding:
      position: 101
      prefix: -db
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'k-mer size, k>1 (default 32)'
    inputBinding:
      position: 101
      prefix: -kmer
  - id: diffuse
    type:
      - 'null'
      - int
    doc: 'diffuse value, z>0 (default 4)'
    inputBinding:
      position: 101
      prefix: -diffuse
  - id: dimension
    type:
      - 'null'
      - int
    doc: 'Size of the output, d>0 (default 1000)'
    inputBinding:
      position: 101
      prefix: -dimension
  - id: out_path
    type: string
    doc: output comparison matrix file path
    inputBinding:
      position: 102
      prefix: -out
outputs:
  - id: out
    type: File
    doc: comparison matrix (first two lines are the sequence lengths), with the
      .csv axis label file beside it
    secondaryFiles:
      - .csv
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
