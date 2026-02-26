cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustybam
  - liftover
label: rustybam_liftover
doc: "Liftover target sequence coordinates onto query sequence using a PAF.\n\nTool
  homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: PAF file from minimap2 or unimap run with -c and --eqx [i.e. the PAF 
      file must have the cg tag and use extended CIGAR opts (=/X)]
    default: '-'
    inputBinding:
      position: 1
  - id: bed_file
    type: File
    doc: BED file of reference regions to liftover to the query
    inputBinding:
      position: 102
      prefix: --bed
  - id: largest
    type:
      - 'null'
      - boolean
    doc: "If multiple records overlap the same region in the <bed> return only the
      largest\n            liftover. The default is to return all liftovers"
    inputBinding:
      position: 102
      prefix: --largest
  - id: query_bed
    type:
      - 'null'
      - boolean
    doc: "Specifies that the BED file contains query coordinates to be lifted onto
      the reference (reverses direction of liftover).\n            \n            Note,
      that this will make the query in the input `PAF` the target in the output `PAF`."
    inputBinding:
      position: 102
      prefix: --qbed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_liftover.out
