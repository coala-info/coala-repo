cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimpse-bio_GLIMPSE2_ligate
label: glimpse-bio_GLIMPSE2_ligate
doc: "Ligate multiple output files into chromosome-wide files\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs:
  - id: input
    type: File
    doc: Text file containing all VCF/BCF to ligate, one file per line
    inputBinding:
      position: 101
      prefix: --input
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: If specified, the ligated VCF/BCF is not indexed by GLIMPSE2 for random
      access to genomic regions
    inputBinding:
      position: 101
      prefix: --no-index
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Output ligated (phased) file in VCF/BCF format
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
