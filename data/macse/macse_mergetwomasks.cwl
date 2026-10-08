cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - mergeTwoMasks
label: macse_mergetwomasks
doc: "indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability).\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: mask_file1
    type: File
    doc: "first mask file in FASTA format, masked nucleotides are in lower case while other nucleotides are in UPPER CASE"
    inputBinding:
      position: 102
      prefix: -mask_file1
  - id: mask_file2
    type: File
    doc: "second mask file in FASTA format, masked nucleotides are in lower case while other nucleotides are in UPPER CASE"
    inputBinding:
      position: 102
      prefix: -mask_file2
  - id: out_mask_detail
    type: string
    default: "macse_mask_detail.fasta"
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE (output file name)"
    inputBinding:
      position: 102
      prefix: -out_mask_detail
  - id: out_trim_info
    type: string
    default: "macse_trim_info.csv"
    doc: "output CSV file containing information about the triming/filtering process (output file name)"
    inputBinding:
      position: 102
      prefix: -out_trim_info
outputs:
  - id: out_mask_detail_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE"
    outputBinding:
      glob: $(inputs.out_mask_detail)
  - id: out_trim_info_file
    type:
      - 'null'
      - File
    doc: "output CSV file containing information about the triming/filtering process"
    outputBinding:
      glob: $(inputs.out_trim_info)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
