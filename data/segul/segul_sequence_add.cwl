cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, sequence, add]
label: segul_sequence_add
doc: "Add sequences to alignments\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type: ['null', {type: array, items: File}]
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
    doc: "Output format: fasta, fasta-int (default fasta-int)"
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
    default: "Sequence-Addition"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: to_dir
    type: ['null', Directory]
    doc: "Add to matching files in a directory"
    inputBinding:
      position: 1
      prefix: "--to-dir"
  - id: to_input
    type: ['null', File]
    doc: "Add to matching files in standard input path (a single path; the tool allows a wildcard)"
    inputBinding:
      position: 1
      prefix: "--to-input"
  - id: to_fmt
    type: ['null', string]
    doc: "Specify format for finding target files: auto, fasta, nexus, phylip (default auto)"
    inputBinding:
      position: 1
      prefix: "--to-fmt"
  - id: to_file
    type: ['null', File]
    doc: "Add to a single file. Output will be in an interleaved FASTA file"
    inputBinding:
      position: 1
      prefix: "--to-file"
  - id: added_only
    type: ['null', boolean]
    doc: "Only produce output that have added sequences"
    inputBinding:
      position: 1
      prefix: "--added-only"
  - id: include_filename
    type: ['null', boolean]
    doc: "Include filename in sequence ID (for a single file output only)"
    inputBinding:
      position: 1
      prefix: "--include-filename"
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
stdout: segul_sequence_add.out
