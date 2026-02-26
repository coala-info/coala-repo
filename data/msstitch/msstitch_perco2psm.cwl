cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch perco2psm
label: msstitch_perco2psm
doc: "Converts Percolator output to PSM table format.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Multiple input files of {} format
    inputBinding:
      position: 1
  - id: mzids
    type:
      - 'null'
      - type: array
        items: File
    doc: MzIdentML output files belonging to PSM table TSV files, use same order
      as for TSVs. Must be included when using MSGF+.
    inputBinding:
      position: 2
  - id: filtpep
    type:
      - 'null'
      - float
    doc: Peptide q-value cutoff level as a floating point number
    inputBinding:
      position: 103
      prefix: --filtpep
  - id: filtpsm
    type:
      - 'null'
      - float
    doc: PSM q-value cutoff level as a floating point number
    inputBinding:
      position: 103
      prefix: --filtpsm
  - id: perco
    type: File
    doc: Percolator XML output file
    inputBinding:
      position: 103
      prefix: --perco
  - id: qvalitypeps
    type:
      - 'null'
      - File
    doc: Qvality tab separated output containing targets and decoys (i.e. 
      prepared with qvality -d) for peptide scores
    inputBinding:
      position: 103
      prefix: --qvalitypeps
  - id: qvalitypsms
    type:
      - 'null'
      - File
    doc: Qvality tab separated output containing targets and decoys (i.e. 
      prepared with qvality -d) for PSM scores
    inputBinding:
      position: 103
      prefix: --qvalitypsms
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_dir)
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
