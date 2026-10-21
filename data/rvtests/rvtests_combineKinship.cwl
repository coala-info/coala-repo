cwlVersion: v1.2
class: CommandLineTool
baseCommand: [combineKinship]
label: rvtests_combineKinship
doc: "Combine several kinship matrices (from vcf2kinship, same samples) into one, weighted by the number of variants each used.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: kinship_files
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: ^.vcf2kinship.log
        required: true
    doc: "Input kinship files (.kinship) made by vcf2kinship. The matching .vcf2kinship.log must be beside each file; it gives the variant count."
    inputBinding:
      position: 102
  - id: out
    type: string
    default: combined
    doc: "Output prefix for autosomal kinship calculation"
    inputBinding:
      position: 101
      prefix: --out
  - id: pca
    type:
      - 'null'
      - boolean
    doc: "Decomoposite calculated kinship matrix."
    inputBinding:
      position: 101
      prefix: --pca
  - id: thread
    type:
      - 'null'
      - int
    doc: "Specify number of parallel threads to speed up"
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: out_kinship
    type: File
    doc: "Combined kinship matrix"
    outputBinding:
      glob: "$(inputs.out).kinship"
  - id: out_log
    type: File
    doc: "Log file, also records the combined variant count for later combining"
    outputBinding:
      glob: "$(inputs.out).vcf2kinship.log"
  - id: out_pca
    type: File?
    doc: "Decomposed kinship (only with --pca)"
    outputBinding:
      glob: "$(inputs.out).pca"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
