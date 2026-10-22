cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, sequence, rename]
label: segul_sequence_rename
doc: "Batch renaming sequence IDs across multiple alignments\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input path(s) (wildcards are expanded by the tool, so give files)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: input_format
    type: ['null', string]
    doc: "Input format: auto, fasta, nexus, phylip (default auto)"
    inputBinding:
      position: 1
      prefix: "--input-format"
  - id: datatype
    type: ['null', string]
    doc: "Sequence datatype: dna, aa, ignore (default dna)"
    inputBinding:
      position: 1
      prefix: "--datatype"
  - id: output_format
    type: ['null', string]
    doc: "Output format: fasta, nexus, phylip, fasta-int, nexus-int, phylip-int (default nexus)"
    inputBinding:
      position: 1
      prefix: "--output-format"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: output
    type: string
    default: "Sequence-Rename"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: dry_run
    type: ['null', boolean]
    doc: "Dry run"
    inputBinding:
      position: 1
      prefix: "--dry-run"
  - id: replace_id
    type: ['null', File]
    doc: "Rename using input IDs in a file"
    inputBinding:
      position: 1
      prefix: "--replace-id"
  - id: remove
    type: ['null', string]
    doc: "Remove matching input string"
    inputBinding:
      position: 1
      prefix: "--remove"
  - id: remove_re
    type: ['null', string]
    doc: "Remove first found matching input regular expression"
    inputBinding:
      position: 1
      prefix: "--remove-re="
      separate: false
  - id: replace_from
    type: ['null', string]
    doc: "Replace matching input string with the output string"
    inputBinding:
      position: 1
      prefix: "--replace-from="
      separate: false
  - id: remove_re_all
    type: ['null', string]
    doc: "Remove all found matching input regular expression"
    inputBinding:
      position: 1
      prefix: "--remove-re-all="
      separate: false
  - id: replace_from_re
    type: ['null', string]
    doc: "Replace first found matching input regular expression with the output string"
    inputBinding:
      position: 1
      prefix: "--replace-from-re="
      separate: false
  - id: replace_from_re_all
    type: ['null', string]
    doc: "Replace all found matching input regular expression with the output string"
    inputBinding:
      position: 1
      prefix: "--replace-from-re-all="
      separate: false
  - id: replace_to
    type: ['null', string]
    doc: "Output string for the replace options"
    inputBinding:
      position: 1
      prefix: "--replace-to="
      separate: false
outputs:
  - id: output_path
    type: [File, Directory]
    doc: Output file or directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_sequence_rename.out
