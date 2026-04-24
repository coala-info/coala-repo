cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtk
  - sr-test
label: svtk_sr-test
doc: "Calculate enrichment of clipped reads at SV breakpoints.\n\nTool homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: VCF of variant calls. Standardized to include CHR2, END, SVTYPE, 
      STRANDS in INFO.
    inputBinding:
      position: 1
  - id: countfile
    type: File
    doc: 'Tabix indexed file of split counts. Columns: chrom,pos,clip,count,sample'
    inputBinding:
      position: 2
  - id: background
    type:
      - 'null'
      - int
    doc: Number of background samples to choose for comparison in t-test.
    inputBinding:
      position: 103
      prefix: --background
  - id: index
    type:
      - 'null'
      - File
    doc: Tabix index of discordant pair file. Required if discordant pair file 
      is hosted remotely.
    inputBinding:
      position: 103
      prefix: --index
  - id: log
    type:
      - 'null'
      - boolean
    doc: Print progress log to stderr.
    inputBinding:
      position: 103
      prefix: --log
  - id: medianfile
    type:
      - 'null'
      - File
    doc: Median coverage statistics for each library (optional). If provided, 
      each sample's split counts will be normalized accordingly. Same format as 
      RdTest, one column per sample.
    inputBinding:
      position: 103
      prefix: --medianfile
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Whitelist of samples to restrict testing to.
    inputBinding:
      position: 103
      prefix: --samples
  - id: window
    type:
      - 'null'
      - int
    doc: Window around variant start/end to consider for split read support.
    inputBinding:
      position: 103
      prefix: --window
outputs:
  - id: fout
    type: File
    doc: Output table of most significant start/endpositions.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
