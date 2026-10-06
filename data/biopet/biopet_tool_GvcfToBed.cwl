cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - GvcfToBed
label: biopet_tool_GvcfToBed
doc: "Write the regions of a gVCF that pass a genome quality cutoff as BED.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_vcf
    type: File
    doc: Input vcf file
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: output_bed
    type: string
    doc: Output bed file
    inputBinding:
      position: 101
      prefix: --outputBed
  - id: inverted_output_bed
    type:
      - 'null'
      - string
    doc: Output bed file of the regions that fail
    inputBinding:
      position: 101
      prefix: --invertedOutputBed
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample to consider. Will take first sample on alphabetical order by default
    inputBinding:
      position: 101
      prefix: --sample
  - id: min_genome_quality
    type:
      - 'null'
      - int
    doc: Minimum genome quality to consider
    inputBinding:
      position: 101
      prefix: --minGenomeQuality
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: bed
    type: File
    doc: Output bed file
    outputBinding:
      glob: $(inputs.output_bed)
  - id: inverted_bed
    type:
      - 'null'
      - File
    doc: Inverted output bed file
    outputBinding:
      glob: '$(inputs.inverted_output_bed ? inputs.inverted_output_bed : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
