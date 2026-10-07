cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crisprbact
  - predict
  - from-seq
label: crisprbact_predict_from-seq
doc: "Outputs candidate guide RNAs for the S. pyogenes dCas9 with predicted on-target
  activity from a target gene.\n\nTool homepage: https://gitlab.pasteur.fr/dbikard/crisprbact"
inputs:
  - id: target
    type: File
    doc: Sequence file to target
    inputBinding:
      position: 1
      prefix: --target
  - id: seq_format
    type:
      - 'null'
      - string
    doc: 'Sequence file to target format (fasta|gb|genbank); default: fasta'
    inputBinding:
      position: 1
      prefix: --seq-format
  - id: off_target_sequence
    type:
      - 'null'
      - File
    doc: Sequence in which you want to find off-targets
    inputBinding:
      position: 1
      prefix: --off-target-sequence
  - id: off_target_sequence_format
    type:
      - 'null'
      - string
    doc: 'Sequence in which you want to find off-targets format (fasta|gb|genbank);
      default: genbank'
    inputBinding:
      position: 1
      prefix: --off-target-sequence-format
  - id: output_file
    type:
      - 'null'
      - string
    doc: File where the candidate guide RNAs are saved. Default = stdout
    inputBinding:
      position: 2
outputs:
  - id: guides
    type:
      - 'null'
      - File
    doc: Candidate guide RNAs table (when output_file is given)
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Candidate guide RNAs table (when no output_file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprbact:0.3.11--py_0
stdout: crisprbact_predict_from-seq.out
