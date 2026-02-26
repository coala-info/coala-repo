cwlVersion: v1.2
class: CommandLineTool
baseCommand: reheader
label: mimodd_reheader
doc: "Reheader a BAM file using a template SAM file.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
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
  - id: co_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the comments (CO lines) of the new header; ignore: do not
      use template comments -> keep original comments, update: append template comment
      lines to original comments, replace: use only template comments -> discard original
      (default: replace if a general template is specified, ignore if not); the optional
      CO_TEMPLATE is used instead of the general template to provide the template
      comments'
    inputBinding:
      position: 103
      prefix: --co
  - id: co_template
    type:
      - 'null'
      - type: array
        items: File
    doc: optional CO_TEMPLATE is used instead of the general template to provide
      the template comments
    inputBinding:
      position: 103
      prefix: --co
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: output only the resulting header
    inputBinding:
      position: 103
      prefix: -H
  - id: rg_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional RG_MAPPING between old and new ID values can be provided in the
      format old_id : new_id'
    inputBinding:
      position: 103
      prefix: --rg
  - id: rg_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the read group section of the new header; ignore: do not
      use template information -> keep original read groups, update: use template
      information to update original header content, replace: use only template read
      group information -> discard original (default: replace if a general template
      is specified, ignore if not); the optional RG_TEMPLATE is used instead of the
      general template to provide the template read group information; by default,
      update mode uses template information about read-groups to add to / overwrite
      the original information of read-groups with the same ID, keeps all read-groups
      found only in the original header and adds read-groups found only in the template;
      replace overwrites all original information about a read-group if a read-group
      with the same ID is found in the template, discards all read-groups found only
      in the original header and adds read-groups found only in the template; to update
      or replace the information of a read group with that of a template read-group
      with a different ID, a RG_MAPPING between old and new ID values can be provided
      in the format old_id : new_id [old_id : new_id, ..]'
    inputBinding:
      position: 103
      prefix: --rg
  - id: rg_template
    type:
      - 'null'
      - File
    doc: optional RG_TEMPLATE is used instead of the general template to provide
      the template read group information
    inputBinding:
      position: 103
      prefix: --rg
  - id: rgm_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional mapping between read group ID values in the format old_id : new_id
      [old_id : new_id, ..]; used to rename read groups and applied AFTER any other
      modifications to the read group section (i.e., every old_id must exist in the
      modified header)'
    inputBinding:
      position: 103
      prefix: --rgm
  - id: sq_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional SQ_MAPPING between old and new sequence names (SN values) can be
      provided in the format old_sn : new_sn'
    inputBinding:
      position: 103
      prefix: --sq
  - id: sq_mode
    type:
      - 'null'
      - string
    doc: 'how to compile the sequence dictionary of the new header; ignore: do not
      use template information -> keep original sequence dictionary, update: use template
      information to update original header content, replace: use only template sequence
      information -> discard original (default: replace if a general template is specified,
      ignore if not); the optional SQ_TEMPLATE is used instead of the general template
      to provide the template sequence dictionary; by default, update mode uses template
      sequence information to add to / overwrite the original information of sequences
      with the same name (SN tag value), keeps all sequences found only in the original
      header and adds sequences found only in the template; replace overwrites all
      original information about a sequence if a sequence with the same name is found
      in the template, discards all sequences found only in the original header and
      adds sequences found only in the template; to update or replace the information
      about a sequence with that of a template sequence with a different name, a SQ_MAPPING
      between old and new sequence names (SN values) can be provided in the format
      old_sn : new_sn [old_sn : new_sn, ..]; to protect against file format corruption,
      the tool will NEVER modify the recorded LENGTH (LN tag) nor the MD5 checksum
      (M5 tag) of any sequence'
    inputBinding:
      position: 103
      prefix: --sq
  - id: sq_template
    type:
      - 'null'
      - File
    doc: optional SQ_TEMPLATE is used instead of the general template to provide
      the template sequence dictionary
    inputBinding:
      position: 103
      prefix: --sq
  - id: sqm_mapping
    type:
      - 'null'
      - type: array
        items: string
    doc: 'optional mapping between sequence names (SN field values) in the format
      old_sn : new_sn [old_sn : new_sn, ..]; used to rename sequences in the sequence
      dictionary and applied AFTER any other modifications to the sequence dictionary
      (i.e., every old_sn must exist in the modified header)'
    inputBinding:
      position: 103
      prefix: --sqm
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'redirect the output to the specified file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
