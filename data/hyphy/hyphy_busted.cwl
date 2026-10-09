cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - busted
label: hyphy_busted
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
  - id: branches
    type:
      - 'null'
      - string
    doc: Branches to test
    inputBinding:
      position: 101
      prefix: --branches
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
  - id: error_sink
    type:
      - 'null'
      - string
    doc: Include a rate class to capture misalignment artifacts
    inputBinding:
      position: 101
      prefix: --error-sink
  - id: error_sink_bound
    type:
      - 'null'
      - float
    doc: '[Advanced setting] Set the lower bound for error-class dN/dS'
    inputBinding:
      position: 101
      prefix: --error-sink-bound
  - id: error_sink_weight
    type:
      - 'null'
      - float
    doc: '[Advanced setting] Set the maximum weight for error-class dN/dS'
    inputBinding:
      position: 101
      prefix: --error-sink-weight
  - id: grid_size
    type:
      - 'null'
      - int
    doc: The number of points in the initial distributional guess for likelihood
      fitting
    inputBinding:
      position: 101
      prefix: --grid-size
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
  - id: mss
    type:
      - 'null'
      - string
    doc: Include support for multiple synonymous rate class substitutions
    inputBinding:
      position: 101
      prefix: --mss
  - id: mss_classes
    type:
      - 'null'
      - int
    doc: How many codon rate classes
    inputBinding:
      position: 101
      prefix: --mss-classes
  - id: mss_file
    type:
      - 'null'
      - File
    doc: File defining the model partition
    inputBinding:
      position: 101
      prefix: --mss-file
  - id: mss_neutral
    type:
      - 'null'
      - string
    doc: Designation for the neutral substitution rate
    inputBinding:
      position: 101
      prefix: --mss-neutral
  - id: mss_reference_rate
    type:
      - 'null'
      - string
    doc: Normalize relative to these rates
    inputBinding:
      position: 101
      prefix: --mss-reference-rate
  - id: mss_type
    type:
      - 'null'
      - string
    doc: How to partition synonymous codons into classes
    inputBinding:
      position: 101
      prefix: --mss-type
  - id: multiple_hits
    type:
      - 'null'
      - string
    doc: Include support for multiple nucleotide substitutions
    inputBinding:
      position: 101
      prefix: --multiple-hits
  - id: rates
    type:
      - 'null'
      - int
    doc: The number omega rate classes to include in the model [1-10, default 3]
    inputBinding:
      position: 101
      prefix: --rates
  - id: save_fit
    type:
      - 'null'
      - string
    doc: Save BUSTED model fit to this file (default is not to save)
    inputBinding:
      position: 101
      prefix: --save-fit
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
  - id: srv
    type:
      - 'null'
      - string
    doc: Include synonymous rate variation in the model
    inputBinding:
      position: 101
      prefix: --srv
  - id: starting_points
    type:
      - 'null'
      - int
    doc: The number of initial random guesses to seed rate values optimization
    inputBinding:
      position: 101
      prefix: --starting-points
  - id: syn_rates
    type:
      - 'null'
      - int
    doc: The number alpha rate classes to include in the model [1-10, default 3]
    inputBinding:
      position: 101
      prefix: --syn-rates
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
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'BUSTED.json')
    outputBinding:
      glob: $(inputs.output_path)
  - id: intermediate_fits_file
    type:
      - 'null'
      - File
    doc: Parameter estimates from the initial-guess model fits (written to the 
      --intermediate-fits path)
    outputBinding:
      glob: $(inputs.intermediate_fits)
  - id: save_fit_file
    type:
      - 'null'
      - File
    doc: Saved model fit (written to the --save-fit path)
    outputBinding:
      glob: $(inputs.save_fit)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
