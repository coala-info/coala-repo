cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch conffilt
label: msstitch_conffilt
doc: "Applies confidence filtering to PSM data.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: confcolpattern
    type:
      - 'null'
      - string
    doc: Text pattern to identify column in table on which confidence filtering 
      should be done. Use in case of not using standard {} column
    inputBinding:
      position: 101
      prefix: --confcolpattern
  - id: confidence_better
    type: string
    doc: Confidence type to define if higher or lower score is better. One of 
      [higher, lower]
    inputBinding:
      position: 101
      prefix: --confidence-better
  - id: confidence_col
    type:
      - 'null'
      - string
    doc: Confidence column number or name in the tsv file. First column has 
      number 1.
    inputBinding:
      position: 101
      prefix: --confidence-col
  - id: confidence_lvl
    type: float
    doc: Confidence cutoff level as a floating point number
    inputBinding:
      position: 101
      prefix: --confidence-lvl
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    inputBinding:
      position: 101
      prefix: -d
  - id: unroll
    type:
      - 'null'
      - boolean
    doc: PSM table from Mzid2TSV contains either one PSM per line with all the 
      proteins of that shared peptide on the same line (not unrolled, default), 
      or one PSM/protein match per line where each protein from that shared 
      peptide gets its own line (unrolled).
    inputBinding:
      position: 101
      prefix: --unroll
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
