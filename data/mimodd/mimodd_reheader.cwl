cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mimodd, reheader]
label: mimodd_reheader
doc: "From a BAM file generate a new file with specified header sections modified\
  \ based on the header of a template SAM file.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: template
    type:
      - 'null'
      - File
    doc: template SAM file providing header information
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: input BAM file to reheader
    inputBinding:
      position: 2
  - id: rg_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the read group section of the new header: ignore, update
      or replace (default: replace if a general template is specified, ignore if
      not)'
    inputBinding:
      position: 10
      prefix: --rg
  - id: rg_template
    type:
      - 'null'
      - File
    doc: optional RG_TEMPLATE used instead of the general template to provide the
      template read group information (needs rg_mode)
    inputBinding:
      position: 11
  - id: rg_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional RG_MAPPING between old and new read group ID values in the format
      old_id : new_id [old_id : new_id, ..] (needs rg_mode)'
    inputBinding:
      position: 12
  - id: sq_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the sequence dictionary of the new header: ignore, update
      or replace (default: replace if a general template is specified, ignore if
      not)'
    inputBinding:
      position: 20
      prefix: --sq
  - id: sq_template
    type:
      - 'null'
      - File
    doc: optional SQ_TEMPLATE used instead of the general template to provide the
      template sequence dictionary (needs sq_mode)
    inputBinding:
      position: 21
  - id: sq_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional SQ_MAPPING between old and new sequence names (SN values) in the
      format old_sn : new_sn [old_sn : new_sn, ..] (needs sq_mode)'
    inputBinding:
      position: 22
  - id: co_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the comments (CO lines) of the new header: ignore, update
      or replace (default: replace if a general template is specified, ignore if
      not)'
    inputBinding:
      position: 30
      prefix: --co
  - id: co_template
    type:
      - 'null'
      - type: array
        items: File
    doc: optional CO_TEMPLATE used instead of the general template to provide the
      template comments (needs co_mode)
    inputBinding:
      position: 31
  - id: rgm_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional mapping between read group ID values in the format old_id : new_id
      [old_id : new_id, ..]; used to rename read groups and applied AFTER any other
      modifications to the read group section'
    inputBinding:
      position: 40
      prefix: --rgm
  - id: sqm_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional mapping between sequence names (SN field values) in the format
      old_sn : new_sn [old_sn : new_sn, ..]; used to rename sequences and applied
      AFTER any other modifications to the sequence dictionary'
    inputBinding:
      position: 41
      prefix: --sqm
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: output only the resulting header
    inputBinding:
      position: 50
      prefix: -H
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 51
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: 'redirect the output to the specified file (default: stdout)'
    inputBinding:
      position: 52
      prefix: --ofile
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
