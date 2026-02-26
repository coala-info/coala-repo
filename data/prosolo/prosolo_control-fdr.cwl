cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prosolo
  - control-fdr
label: prosolo_control-fdr
doc: "Filter calls for controlling the false discovery rate (FDR) at given level.\n\
  \nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs:
  - id: bcf_file
    type: File
    doc: Calls as provided by prosolo single-cell-bulk.
    inputBinding:
      position: 1
  - id: events
    type:
      type: array
      items: string
    doc: "Comma-separated list of Events to consider jointly (e.g. `--events\n   \
      \                                    Event1,Event2`)."
    inputBinding:
      position: 102
      prefix: --events
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR to control for.
    default: 0.05
    inputBinding:
      position: 102
      prefix: --fdr
  - id: max_indel_length
    type:
      - 'null'
      - int
    doc: Maximum indel length to consider (exclusive).
    inputBinding:
      position: 102
      prefix: --max-len
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: Minimum indel length to consider.
    inputBinding:
      position: 102
      prefix: --min-len
  - id: variant_type
    type: string
    doc: Variant type to consider (SNV, INS, DEL).
    inputBinding:
      position: 102
      prefix: --var
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: BCF file that contains the filtered results (if omitted, write to 
      STDOUT).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
