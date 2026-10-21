cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - samplereplay
label: rtg-tools_rtg_samplereplay
doc: 'Generates the genome corresponding to a sample genotype. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'input VCF containing the sample genotype'
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'name for output SDF'
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type: Directory
    doc: 'SDF containing the reference genome'
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample
    type: string
    doc: 'name of the sample to select from the VCF'
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sdf
    type: Directory
    doc: Output SDF directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_samplereplay.out
