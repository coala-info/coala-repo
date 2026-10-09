cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - contrast-fel
label: hyphy_contrast-fel
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
  - id: branch_set
    type:
      type: array
      items: string
      inputBinding:
        prefix: --branch-set
    doc: The set of branches to use for testing
    inputBinding:
      position: 101
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
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
  - id: limit_to_sites
    type:
      - 'null'
      - string
    doc: Only analyze sites whose 1-based indices match the following list (null
      to skip)
    inputBinding:
      position: 101
      prefix: --limit-to-sites
  - id: p_value
    type:
      - 'null'
      - float
    doc: Significance value for site-tests
    inputBinding:
      position: 101
      prefix: --p-value
  - id: permutations
    type:
      - 'null'
      - string
    doc: Perform permutation significance tests
    inputBinding:
      position: 101
      prefix: --permutations
  - id: q_value
    type:
      - 'null'
      - float
    doc: Significance value for FDR reporting
    inputBinding:
      position: 101
      prefix: --q-value
  - id: save_lf_for_sites
    type:
      - 'null'
      - string
    doc: For sites whose 1-based indices match the following list, write out 
      likelihood function snapshots (null to skip)
    inputBinding:
      position: 101
      prefix: --save-lf-for-sites
  - id: srv
    type:
      - 'null'
      - string
    doc: Include synonymous rate variation in the model
    inputBinding:
      position: 101
      prefix: --srv
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
      path as the alignment file + 'FEL.json')
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
