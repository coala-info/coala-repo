cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-format-seq
label: parallel-meta-suite_PM-format-seq
doc: "Sequence format check and reformat for Parallel-Meta Suite\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: input_sequence
    type:
      - 'null'
      - File
    doc: "Input single sequence file in FASTA or FASTQ format (rewritten in place)"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: list_file
    type:
      - 'null'
      - File
    doc: "Input sequence files list"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: list_path_prefix
    type:
      - 'null'
      - string
    doc: "List file path prefix [Optional for -l]"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Files named in the list; staged in the working directory so that the names in the list resolve"
outputs:
  - id: reformatted_sequence
    type:
      - 'null'
      - File
    doc: "The input sequence file after the format check and reformat"
    outputBinding:
      glob: "$(inputs.input_sequence ? inputs.input_sequence.basename : [])"
  - id: reformatted_list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "The listed sequence files after the format check and reformat"
    outputBinding:
      glob: "$(inputs.list_members ? inputs.list_members.map(function(f){return f.basename;}) : [])"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ var l = []; if (inputs.input_sequence) l.push({"entry": inputs.input_sequence, "writable": true});
         (inputs.list_members ? inputs.list_members : []).forEach(function(f){ l.push({"entry": f, "writable": true}); });
         if (inputs.list_file) l.push(inputs.list_file); return l; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-format-seq.out
