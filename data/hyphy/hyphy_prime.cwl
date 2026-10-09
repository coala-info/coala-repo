cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - prime
label: hyphy_prime
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
  - id: impute_states
    type:
      - 'null'
      - string
    doc: Use site-level model fits to impute likely character states for each 
      sequence
    inputBinding:
      position: 101
      prefix: --impute-states
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
  - id: property_file
    type:
      - 'null'
      - File
    doc: JSON file which defines amino-acid properties
    inputBinding:
      position: 101
      prefix: --property-file
  - id: property_set
    type:
      - 'null'
      - string
    doc: How to partition synonymous codons into classes
    inputBinding:
      position: 101
      prefix: --property-set
  - id: pvalue
    type:
      - 'null'
      - float
    doc: The p-value threshold to use when testing for selection
    inputBinding:
      position: 101
      prefix: --pvalue
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
      path as the alignment file + 'prime.json')
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
