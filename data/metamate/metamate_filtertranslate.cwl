cwlVersion: v1.2
class: CommandLineTool
baseCommand: filtertranslate
label: metamate_filtertranslate
doc: "Standalone tool for filtering the sequences in a multifasta according to whether
  their translation contains stop codons. All sequences must have the same reading
  frame relative to the start of the sequence and use the same translation table.\n\nTool
  homepage: https://github.com/tjcreedy/metamate"
inputs:
  - id: input
    type: File
    doc: input file path
    inputBinding:
      prefix: --input
  - id: table
    type: ['null', int]
    doc: the number referring to the translation table to use (NCBI numbering)
    inputBinding:
      prefix: -t
  - id: readingframe
    type: ['null', int]
    doc: coding frame of sequences, if known
    inputBinding:
      prefix: --readingframe
  - id: output
    type: string
    doc: if --outtype is 'pass', 'fail' or 'both', the output file name, or if --outtype
      is 'separate', the prefix of the output file name
    inputBinding:
      prefix: --output
  - id: outtype
    type: ['null', string]
    doc: "one of 'pass', 'fail', 'both' or 'separate', denoting whether to output only
      those that pass filtering, only those that fail filtering, all sequences in one
      file adding a ';translation=pass' or ';translation=fail' suffix in the headers,
      or as two separate files with _pass or _fail suffixes to the output file name
      (default pass)"
    inputBinding:
      prefix: --outtype
  - id: detectionconfidence
    type: ['null', float]
    doc: confidence level for detection of reading frame (default 0.95, usually no
      need to change)
    inputBinding:
      prefix: --detectionconfidence
  - id: detectionminstops
    type: ['null', int]
    doc: minimum number of stops to encounter for detection (default 50, may need to decrease for few sequences)
    inputBinding:
      prefix: --detectionminstops
outputs:
  - id: filtered
    type: 'File[]'
    doc: Filtered output file(s); with --outtype separate the names get _pass and _fail suffixes
    outputBinding:
      glob: "$(inputs.output)*"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
stdout: metamate_filtertranslate.out
