cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - bgm
label: hyphy_bgm
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of threads to use (HyPhy CPU= argument).
    inputBinding:
      position: 100
      prefix: CPU=
      separate: false
  - id: alignment
    type: File
    doc: An in-frame codon alignment in one of the formats supported by HyPhy
    inputBinding:
      position: 101
      prefix: --alignment
  - id: baseline_model
    type:
      - 'null'
      - string
    doc: Which amino acid substitution model should be used
    inputBinding:
      position: 101
      prefix: --baseline_model
  - id: branches
    type:
      - 'null'
      - string
    doc: Branches to test
    inputBinding:
      position: 101
      prefix: --branches
  - id: burn_in
    type:
      - 'null'
      - int
    doc: The number of MCMC steps to discard as burn-in
    inputBinding:
      position: 101
      prefix: --burn-in
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
  - id: max_parents
    type:
      - 'null'
      - int
    doc: The maximum number of parents allowed per node
    inputBinding:
      position: 101
      prefix: --max-parents
  - id: min_subs
    type:
      - 'null'
      - int
    doc: The minimum number of substitutions per site to include it in the 
      analysis
    inputBinding:
      position: 101
      prefix: --min-subs
  - id: samples
    type:
      - 'null'
      - int
    doc: The number of steps to extract from the chain sample
    inputBinding:
      position: 101
      prefix: --samples
  - id: steps
    type:
      - 'null'
      - int
    doc: The number of MCMC steps to sample
    inputBinding:
      position: 101
      prefix: --steps
  - id: tree
    type:
      - 'null'
      - File
    doc: A phylogenetic tree (optionally annotated with {})
    inputBinding:
      position: 101
      prefix: --tree
  - id: type
    type:
      - 'null'
      - string
    doc: nucleotide, amino-acid or codon
    inputBinding:
      position: 101
      prefix: --type
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'FEL.json')
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
