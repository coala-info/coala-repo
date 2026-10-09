cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - fade
label: hyphy_fade
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
    doc: Protein alignment to screen for directional selection
    inputBinding:
      position: 101
      prefix: --alignment
  - id: branches
    type:
      - 'null'
      - string
    doc: The branches to test
    inputBinding:
      position: 101
      prefix: --branches
  - id: burn_in
    type:
      - 'null'
      - int
    doc: MCMC chain burn in
    inputBinding:
      position: 101
      prefix: --burn-in
  - id: cache
    type:
      - 'null'
      - string
    doc: Save FADE cache to [default is alignment+.FADE.cache]
    inputBinding:
      position: 101
      prefix: --cache
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
    default: fade.cache
  - id: chain_length
    type:
      - 'null'
      - int
    doc: MCMC chain length
    inputBinding:
      position: 101
      prefix: --chain-length
  - id: chains
    type:
      - 'null'
      - int
    doc: How many MCMC chains to run
    inputBinding:
      position: 101
      prefix: --chains
  - id: concentration_parameter
    type:
      - 'null'
      - float
    doc: The concentration parameter of the Dirichlet prior
    inputBinding:
      position: 101
      prefix: --concentration_parameter
  - id: grid
    type:
      - 'null'
      - int
    doc: The number of grid points
    inputBinding:
      position: 101
      prefix: --grid
  - id: method
    type:
      - 'null'
      - string
    doc: Inference method to use
    inputBinding:
      position: 101
      prefix: --method
  - id: model
    type:
      - 'null'
      - string
    doc: The substitution model to use
    inputBinding:
      position: 101
      prefix: --model
  - id: samples
    type:
      - 'null'
      - int
    doc: MCMC samples to draw
    inputBinding:
      position: 101
      prefix: --samples
  - id: tree
    type:
      - 'null'
      - File
    doc: A rooted phylogenetic tree
    inputBinding:
      position: 101
      prefix: --tree
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
    doc: Save FADE results (JSON) to [default is alignment+.FADE.json]
    outputBinding:
      glob: $(inputs.output_path)
  - id: cache_file
    type:
      - 'null'
      - File
    doc: FUBAR/FADE cache file (written to the --cache path)
    outputBinding:
      glob: $(inputs.cache)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
