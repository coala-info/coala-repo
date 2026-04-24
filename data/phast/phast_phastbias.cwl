cwlVersion: v1.2
class: CommandLineTool
baseCommand: phastBias
label: phast_phastbias
doc: "Calculates the bias of each base in a sequence alignment.\n\nTool homepage:
  http://compgen.cshl.edu/phast/"
inputs:
  - id: input_file
    type: File
    doc: Input alignment file (e.g., MAF, FASTA)
    inputBinding:
      position: 1
  - id: bases
    type:
      - 'null'
      - string
    doc: Bases to consider for bias calculation (e.g., ACGT, AC)
    inputBinding:
      position: 102
      prefix: --bases
  - id: min_sites
    type:
      - 'null'
      - int
    doc: Minimum number of aligned sites required in a window to calculate bias
    inputBinding:
      position: 102
      prefix: --min-sites
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the sliding window
    inputBinding:
      position: 102
      prefix: --step
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the sliding window for calculating bias
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for bias scores
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
