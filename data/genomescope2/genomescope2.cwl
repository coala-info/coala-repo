cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomescope2
label: genomescope2
doc: "Reference-free profiling of polyploid genomes from k-mer frequencies.\n\nTool homepage: https://github.com/tbenavi1/genomescope2.0"
inputs:
  - id: input
    type: File
    doc: "input histogram file"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: "output directory name"
    inputBinding:
      position: 101
      prefix: --output
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "ploidy (1, 2, 3, 4, 5, or 6) for model to use [default 2]"
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "kmer length used to calculate kmer spectra [default 21]"
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: name_prefix
    type:
      - 'null'
      - string
    doc: "optional name_prefix for output files"
    inputBinding:
      position: 101
      prefix: --name_prefix
  - id: lambda
    type:
      - 'null'
      - float
    doc: "optional initial kmercov estimate for model to use"
    inputBinding:
      position: 101
      prefix: --lambda
  - id: max_kmercov
    type:
      - 'null'
      - int
    doc: "optional maximum kmer coverage threshold (kmers with coverage greater than max_kmercov are ignored by the model)"
    inputBinding:
      position: 101
      prefix: --max_kmercov
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "optional flag to print messages during execution"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_unique_sequence
    type:
      - 'null'
      - boolean
    doc: "optional flag to turn off yellow unique sequence line in plots"
    inputBinding:
      position: 101
      prefix: --no_unique_sequence
  - id: json_report
    type:
      - 'null'
      - boolean
    doc: "write a JSON format report file in addition to the text summary"
    inputBinding:
      position: 101
      prefix: --json_report
  - id: topology
    type:
      - 'null'
      - string
    doc: "ADVANCED: flag for topology for model to use"
    inputBinding:
      position: 101
      prefix: --topology
  - id: initial_repetitiveness
    type:
      - 'null'
      - float
    doc: "ADVANCED: flag to set initial value for repetitiveness"
    inputBinding:
      position: 101
      prefix: --initial_repetitiveness
  - id: initial_heterozygosities
    type:
      - 'null'
      - string
    doc: "ADVANCED: flag to set initial values for nucleotide heterozygosity rates"
    inputBinding:
      position: 101
      prefix: --initial_heterozygosities
  - id: transform_exp
    type:
      - 'null'
      - float
    doc: "ADVANCED: parameter for the exponent when fitting a transformed (x**transform_exp*y vs. x) kmer histogram [default 1]"
    inputBinding:
      position: 101
      prefix: --transform_exp
  - id: testing
    type:
      - 'null'
      - boolean
    doc: "ADVANCED: flag to create testing.tsv file with model parameters"
    inputBinding:
      position: 101
      prefix: --testing
  - id: true_params
    type:
      - 'null'
      - string
    doc: "ADVANCED: flag to state true simulated parameters for testing mode"
    inputBinding:
      position: 101
      prefix: --true_params
  - id: trace_flag
    type:
      - 'null'
      - boolean
    doc: "ADVANCED: flag to turn on printing of iteration progress of nlsLM function"
    inputBinding:
      position: 101
      prefix: --trace_flag
  - id: num_rounds
    type:
      - 'null'
      - int
    doc: "ADVANCED: parameter for the number of optimization rounds"
    inputBinding:
      position: 101
      prefix: --num_rounds
  - id: fitted_hist
    type:
      - 'null'
      - boolean
    doc: "ADVANCED: generates a fitted histogram for kmer multiplicity 0-4 and a lookup table of probabilities"
    inputBinding:
      position: 101
      prefix: --fitted_hist
  - id: start_shift
    type:
      - 'null'
      - int
    doc: "ADVANCED: coverage shifts to exclude between fitting rounds"
    inputBinding:
      position: 101
      prefix: --start_shift
  - id: typical_error
    type:
      - 'null'
      - float
    doc: "ADVANCED: typical level of sequencing error"
    inputBinding:
      position: 101
      prefix: --typical_error
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomescope2:2.1.0--py313r44hdfd78af_0
stdout: genomescope2.out
