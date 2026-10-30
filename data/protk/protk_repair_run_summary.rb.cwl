cwlVersion: v1.2
class: CommandLineTool
baseCommand: repair_run_summary.rb
label: protk_repair_run_summary.rb
doc: 'Repair msms_run_summary tag in a pepXML file.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: pepxml_file
    type: File
    doc: Input pepXML file (edited in place on a staged copy)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: base_name
    type:
      - 'null'
      - string
    doc: Original MSMS spectrum file used for search
    inputBinding:
      position: 102
      prefix: --base-name
  - id: raw_type
    type:
      - 'null'
      - string
    doc: Raw data type used for search
    inputBinding:
      position: 102
      prefix: --raw-type
  - id: omssa_itol
    type:
      - 'null'
      - string
    doc: Add a fragment ion tolerance parameter to the omssa search summary
    inputBinding:
      position: 102
      prefix: --omssa-itol
outputs:
  - id: repaired_pepxml
    type: File
    doc: The repaired pepXML file
    outputBinding:
      glob: $(inputs.pepxml_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.pepxml_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
