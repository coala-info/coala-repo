cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - gard
label: hyphy_gard
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
    doc: Sequence alignment to screen for recombination
    inputBinding:
      position: 101
      prefix: --alignment
  - id: code
    type:
      - 'null'
      - string
    doc: Genetic code to use (for codon alignments)
    inputBinding:
      position: 101
      prefix: --code
  - id: env
    type:
      - 'null'
      - string
    doc: Set HyPhy environment variables via explicit statements (HyPhy ENV= 
      argument), for example 'TOLERATE_NUMERICAL_ERRORS=1;'. GARD may stop with 
      an internal numerical error without it.
    inputBinding:
      position: 100
      prefix: ENV=
      separate: false
  - id: max_breakpoints
    type:
      - 'null'
      - int
    doc: Maximum number of breakpoints to consider
    inputBinding:
      position: 101
      prefix: --max-breakpoints
  - id: mode
    type:
      - 'null'
      - string
    doc: Run mode (Normal or Faster)
    inputBinding:
      position: 101
      prefix: --mode
  - id: model
    type:
      - 'null'
      - string
    doc: The substitution model to use
    inputBinding:
      position: 101
      prefix: --model
  - id: output_lf
    type:
      - 'null'
      - string
    doc: Write the best fitting HyPhy analysis snapshot to (default is to save 
      to the same path as the alignment file + 'best-gard')
    inputBinding:
      position: 101
      prefix: --output-lf
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
    default: gard.best-gard
  - id: rate_classes
    type:
      - 'null'
      - int
    doc: How many site rate classes to use
    inputBinding:
      position: 101
      prefix: --rate-classes
  - id: rv
    type:
      - 'null'
      - string
    doc: Site to site rate variation
    inputBinding:
      position: 101
      prefix: --rv
  - id: type
    type:
      - 'null'
      - string
    doc: The type of data to perform screening on
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
      path as the alignment file + 'GARD.json')
    outputBinding:
      glob: $(inputs.output_path)
  - id: output_lf_file
    type:
      - 'null'
      - File
    doc: Best fitting HyPhy analysis snapshot (written to the --output-lf path)
    outputBinding:
      glob: $(inputs.output_lf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
