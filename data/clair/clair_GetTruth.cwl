cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - GetTruth
label: clair_GetTruth
doc: "Extract variant type and allele from a Truth dataset\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: vcf_fn
    type: File
    doc: "Truth vcf file input (gzip-compressed: the busybox gzip in the image cannot pass plain text through)"
    inputBinding:
      position: 101
      prefix: --vcf_fn
  - id: var_fn
    type: string
    doc: "Truth variants output file name (gzip-compressed text)"
    inputBinding:
      position: 101
      prefix: --var_fn
  - id: ref_fn
    type:
      - 'null'
      - File
    doc: "Reference file input, must be provided if the vcf contains '*' in ALT field."
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: ctgName
    type:
      - 'null'
      - string
    doc: "The name of sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgName
  - id: ctgStart
    type:
      - 'null'
      - int
    doc: "The 1-based starting position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgStart
  - id: ctgEnd
    type:
      - 'null'
      - int
    doc: "The 1-based inclusive ending position of the sequence to be processed"
    inputBinding:
      position: 101
      prefix: --ctgEnd
outputs:
  - id: truth_variants
    type: File
    doc: "Truth variants (gzip-compressed text)"
    outputBinding:
      glob: "$(inputs.var_fn)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
