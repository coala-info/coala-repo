cwlVersion: v1.2
class: CommandLineTool
baseCommand: fineRADstructure
label: fineradstructure
doc: "Inference of population structure from RADseq data using fineRADstructure.\n\
  \nTool homepage: http://cichlid.gurdon.cam.ac.uk/fineRADstructure.html"
inputs:
  - id: input_file
    type: File
    doc: Input haplotype data file (e.g., in RADpainter format)
    inputBinding:
      position: 1
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Number of burn-in iterations
    inputBinding:
      position: 102
      prefix: -b
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the MCMC
    inputBinding:
      position: 102
      prefix: -m
  - id: thinning
    type:
      - 'null'
      - int
    doc: Thinning interval for MCMC
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
