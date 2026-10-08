cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_ligate
label: glimpse-bio_GLIMPSE2_ligate
doc: "Ligate multiple output files into chromosome-wide files\n\nTool homepage: https://github.com/odelaneau/GLIMPSE"
inputs:
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed of the random number generator"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: input
    type: File
    doc: "Text file containing all VCF/BCF to ligate, one file per line"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: "Output ligated (phased) file in VCF/BCF format"
    inputBinding:
      position: 102
      prefix: --output
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: "If specified, the ligated VCF/BCF is not indexed by GLIMPSE2 for random access to genomic regions"
    inputBinding:
      position: 101
      prefix: --no-index
  - id: chunk_files
    type:
      type: array
      items: File
    doc: The VCF/BCF files (with their indexes) named in the --input list, staged in the working directory
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
outputs:
  - id: output
    type: File
    doc: Output ligated (phased) file in VCF/BCF format
    secondaryFiles:
      - pattern: '.csi'
        required: false
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.chunk_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
