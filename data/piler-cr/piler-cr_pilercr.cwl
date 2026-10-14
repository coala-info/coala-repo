cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilercr
label: piler-cr_pilercr
doc: "A tool for finding CRISPR repeats in DNA sequences.\n\nTool homepage: http://www.drive5.com/pilercr/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: 'Sequence file to analyze (FASTA format)'
    inputBinding:
      position: 101
      prefix: -in
  - id: seq_name
    type:
      - 'null'
      - string
    doc: 'Save consensus sequences to this FASTA file'
    inputBinding:
      position: 101
      prefix: -seq
  - id: trimseqs
    type:
      - 'null'
      - boolean
    doc: 'Eliminate similar seqs from the -seq file'
    inputBinding:
      position: 101
      prefix: -trimseqs
  - id: noinfo
    type:
      - 'null'
      - boolean
    doc: 'Do not write help to the report file'
    inputBinding:
      position: 101
      prefix: -noinfo
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not write progress messages to stderr'
    inputBinding:
      position: 101
      prefix: -quiet
  - id: minarray
    type:
      - 'null'
      - int
    doc: 'Minimum number of repeats in an array (3)'
    inputBinding:
      position: 101
      prefix: -minarray
  - id: mincons
    type:
      - 'null'
      - float
    doc: 'Minimum conservation of repeats with the consensus, 0 to 1 (0.9)'
    inputBinding:
      position: 101
      prefix: -mincons
  - id: minrepeat
    type:
      - 'null'
      - int
    doc: 'Minimum repeat length (16)'
    inputBinding:
      position: 101
      prefix: -minrepeat
  - id: maxrepeat
    type:
      - 'null'
      - int
    doc: 'Maximum repeat length (64)'
    inputBinding:
      position: 101
      prefix: -maxrepeat
  - id: minspacer
    type:
      - 'null'
      - int
    doc: 'Minimum spacer length (8)'
    inputBinding:
      position: 101
      prefix: -minspacer
  - id: maxspacer
    type:
      - 'null'
      - int
    doc: 'Maximum spacer length (64)'
    inputBinding:
      position: 101
      prefix: -maxspacer
  - id: minrepeatratio
    type:
      - 'null'
      - float
    doc: 'Minimum repeat ratio, minlength / maxlength (0.9)'
    inputBinding:
      position: 101
      prefix: -minrepeatratio
  - id: minspacerratio
    type:
      - 'null'
      - float
    doc: 'Minimum spacer ratio (0.75)'
    inputBinding:
      position: 101
      prefix: -minspacerratio
  - id: minhitlength
    type:
      - 'null'
      - int
    doc: 'Minimum alignment length (16)'
    inputBinding:
      position: 101
      prefix: -minhitlength
  - id: minid
    type:
      - 'null'
      - float
    doc: 'Minimum identity (0.94)'
    inputBinding:
      position: 101
      prefix: -minid
  - id: output_file_path
    type: string
    doc: 'Report file name (plain text)'
    inputBinding:
      position: 102
      prefix: -out
outputs:
  - id: output_file
    type: File
    doc: 'Report file'
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: consensus_seqs
    type:
      - 'null'
      - File
    doc: 'Consensus sequences when -seq is used'
    outputBinding:
      glob: $(inputs.seq_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piler-cr:1.06--h9948957_6
