cwlVersion: v1.2
class: CommandLineTool
baseCommand: msoma_mle
label: msoma_mle
doc: "Calculate p-values for each locus using maximum likelihood estimation from counts
  file\n\nTool homepage: https://github.com/AkeyLab/mSOMA"
inputs:
  - id: input_counts
    type: File
    doc: counts file
    inputBinding:
      position: 1
  - id: min_depth
    type: int
    doc: Minimum read depth to consider locus for p-value calculation
    inputBinding:
      position: 102
      prefix: --min-depth
outputs:
  - id: output_path
    type: File
    doc: Path to write p-value output file
    outputBinding:
      glob: $(inputs.output_path)
  - id: alpha_beta_output
    type: File
    doc: Output file to write alpha and beta parameter estimates
    outputBinding:
      glob: $(inputs.alpha_beta_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msoma:0.1.2--pyhdfd78af_0
