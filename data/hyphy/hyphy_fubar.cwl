cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - fubar
label: hyphy_fubar
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
    doc: Save FUBAR cache to [default is alignment+.FUBAR.cache]
    inputBinding:
      position: 101
      prefix: --cache
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
    default: fubar.cache
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
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
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
  - id: intermediate_fits
    type:
      - 'null'
      - string
    doc: Use/save parameter estimates from 'initial-guess' model fits to a JSON 
      file (default is not to save)
    inputBinding:
      position: 101
      prefix: --intermediate-fits
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
  - id: kill_zero_lengths
    type:
      - 'null'
      - string
    doc: Automatically delete internal zero-length branches for computational 
      efficiency (will not affect results otherwise)
    inputBinding:
      position: 101
      prefix: --kill-zero-lengths
  - id: method
    type:
      - 'null'
      - string
    doc: Inference method to use
    inputBinding:
      position: 101
      prefix: --method
  - id: non_zero
    type:
      - 'null'
      - string
    doc: Enforce non-zero synonymous rates on the grid to enable dN/dS 
      calculations
    inputBinding:
      position: 101
      prefix: --non-zero
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
    doc: A phylogenetic tree (optionally annotated with {})
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
    doc: Save FUBAR results (JSON) to [default is alignment+.FUBAR.json]
    outputBinding:
      glob: $(inputs.output_path)
  - id: cache_file
    type:
      - 'null'
      - File
    doc: FUBAR/FADE cache file (written to the --cache path)
    outputBinding:
      glob: $(inputs.cache)
  - id: intermediate_fits_file
    type:
      - 'null'
      - File
    doc: Parameter estimates from the initial-guess model fits (written to the 
      --intermediate-fits path)
    outputBinding:
      glob: $(inputs.intermediate_fits)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
