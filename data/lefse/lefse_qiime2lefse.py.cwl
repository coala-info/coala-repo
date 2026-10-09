cwlVersion: v1.2
class: CommandLineTool
baseCommand: qiime2lefse.py
label: lefse_qiime2lefse.py
doc: "Convert a QIIME TSV BIOM table for use with LEfSe.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: 'the Qiime OTU table file (a QIIME TSV BIOM table with a Consensus Lineage column)'
    inputBinding:
      position: 1
      prefix: --in
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: 'the Qiime metadata file (only the OTU table without metadata if not present)'
    inputBinding:
      position: 2
      prefix: --md
  - id: output_file
    type: string
    doc: 'the output file'
    inputBinding:
      position: 3
      prefix: --out
  - id: class_attribute
    type:
      - 'null'
      - string
    doc: 'the attribute to use as class'
    inputBinding:
      position: 4
      prefix: -c
  - id: subclass_attribute
    type:
      - 'null'
      - string
    doc: 'the attribute to use as subclass'
    inputBinding:
      position: 5
      prefix: -s
  - id: subject_attribute
    type:
      - 'null'
      - string
    doc: 'the attribute to use as subject'
    inputBinding:
      position: 6
      prefix: -u
outputs:
  - id: output_file_out
    type: File
    doc: 'The LEfSe input file'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
