cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - modify_contig
label: viral-ngs_assembly_modify_contig
doc: "Modifies an input contig. Depending on the options selected, can replace N calls with reference calls, replace ambiguous calls with reference calls, trim to the length of the reference, replace contig ends with reference calls, and trim leading and trailing Ns. Author: rsealfon.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: input
    type: File
    doc: "input alignment of reference and contig (should contain exactly 2 sequences)"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Destination file for modified contigs"
    inputBinding:
      position: 2
  - id: ref
    type: string
    doc: "reference sequence name (exact match required)"
    inputBinding:
      position: 3
  - id: name
    type:
      - 'null'
      - string
    doc: "fasta header output name (default: existing header)"
    inputBinding:
      position: 20
      prefix: --name
  - id: call_reference_ns
    type:
      - 'null'
      - boolean
    doc: "should the reference sequence be called if there is an N in the contig and a more specific base in the reference (default: False)"
    inputBinding:
      position: 20
      prefix: --call-reference-ns
  - id: trim_ends
    type:
      - 'null'
      - boolean
    doc: "should ends of contig.fasta be trimmed to length of reference (default: False)"
    inputBinding:
      position: 20
      prefix: --trim-ends
  - id: replace_5ends
    type:
      - 'null'
      - boolean
    doc: "should the 5'-end of contig.fasta be replaced by reference (default: False)"
    inputBinding:
      position: 20
      prefix: --replace-5ends
  - id: replace_3ends
    type:
      - 'null'
      - boolean
    doc: "should the 3'-end of contig.fasta be replaced by reference (default: False)"
    inputBinding:
      position: 20
      prefix: --replace-3ends
  - id: replace_length
    type:
      - 'null'
      - int
    doc: "length of ends to be replaced (if replace-ends is yes) (default: 10)"
    inputBinding:
      position: 20
      prefix: --replace-length
  - id: format
    type:
      - 'null'
      - string
    doc: "Format for input alignment (default: fasta)"
    inputBinding:
      position: 20
      prefix: --format
  - id: replace_end_gaps
    type:
      - 'null'
      - boolean
    doc: "Replace gaps at the beginning and end of the sequence with reference sequence (default: False)"
    inputBinding:
      position: 20
      prefix: --replace-end-gaps
  - id: remove_end_ns
    type:
      - 'null'
      - boolean
    doc: "Remove leading and trailing N's in the contig (default: False)"
    inputBinding:
      position: 20
      prefix: --remove-end-ns
  - id: call_reference_ambiguous
    type:
      - 'null'
      - boolean
    doc: "should the reference sequence be called if the contig seq is ambiguous and the reference sequence is more informative & consistant with the ambiguous base (ie Y->C) (default: False)"
    inputBinding:
      position: 20
      prefix: --call-reference-ambiguous
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: output_file
    type: File
    doc: "Output file written to output"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
