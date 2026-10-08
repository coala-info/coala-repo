cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - vcf_concatenate
label: graphtyper_vcf_concatenate
doc: "Concatenate VCF files.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: "VCFs to concatenate"
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: "Set to skip sorting the variants."
    inputBinding:
      position: 10
      prefix: "--no_sort"
  - id: output
    type: string
    default: concatenated.vcf.gz
    doc: "Output VCF file name (a name ending in .vcf.gz writes a bgzipped file)."
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: sites_only
    type:
      - 'null'
      - boolean
    doc: "Set to write only variant site information."
    inputBinding:
      position: 10
      prefix: "--sites_only"
  - id: sv
    type:
      - 'null'
      - boolean
    doc: "Set if the input VCFs were generated from genotype_sv."
    inputBinding:
      position: 10
      prefix: "--sv"
  - id: region
    type:
      - 'null'
      - string
    doc: "Region to print variant in."
    inputBinding:
      position: 10
      prefix: "--region="
      separate: false
  - id: write_tbi
    type:
      - 'null'
      - boolean
    doc: "Set to write TBI index."
    inputBinding:
      position: 10
      prefix: "--write_tbi"
outputs:
  - id: concatenated_vcf
    type: File
    doc: Concatenated VCF
    secondaryFiles:
      - pattern: .tbi
        required: false
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_vcf_concatenate.out
