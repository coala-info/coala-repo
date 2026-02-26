cwlVersion: v1.2
class: CommandLineTool
baseCommand: smaca
label: smaca
doc: "Spinal Muscular Atrophy Carrier Analysis tool. Detect putative SMA carriers
  and estimate the absolute SMN1 copy-number in a population.\n\nTool homepage: https://github.com/babelomics/SMAca"
inputs:
  - id: bam_list
    type:
      type: array
      items: File
    doc: List of BAM files
    inputBinding:
      position: 1
  - id: ncpus
    type:
      - 'null'
      - int
    doc: number of cores to use
    inputBinding:
      position: 102
      prefix: --ncpus
  - id: profile
    type:
      - 'null'
      - boolean
    doc: execution statistics (only for debug purposes)
    inputBinding:
      position: 102
      prefix: --profile
  - id: reference
    type:
      - 'null'
      - string
    doc: reference genome that was used for alignment
    default: '[hg19|hg38]'
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smaca:1.2.3--py311hc1104ee_6
