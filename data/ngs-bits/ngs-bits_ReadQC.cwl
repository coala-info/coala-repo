cwlVersion: v1.2
class: CommandLineTool
baseCommand: ReadQC
label: ngs-bits_ReadQC
doc: "Calculates QC metrics on unprocessed NGS reads.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Output FASTQ compression level from 1 (fastest) to 9 (best 
      compression).
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: in1
    type:
      type: array
      items: File
    doc: Forward input gzipped FASTQ file(s).
    inputBinding:
      position: 101
      prefix: -in1
  - id: in2
    type:
      - 'null'
      - type: array
        items: File
    doc: Reverse input gzipped FASTQ file(s) for paired-end mode (same number of
      cycles/reads as 'in1').
    inputBinding:
      position: 101
      prefix: -in2
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: Support long reads (> 1kb).
    inputBinding:
      position: 101
      prefix: -long_read
  - id: settings
    type:
      - 'null'
      - File
    doc: Settings override file (no other settings files are used).
    inputBinding:
      position: 101
      prefix: --settings
  - id: tdx
    type:
      - 'null'
      - boolean
    doc: Writes a Tool Definition Xml file. The file name is the application 
      name with the suffix '.tdx'.
    inputBinding:
      position: 101
      prefix: --tdx
  - id: txt
    type:
      - 'null'
      - boolean
    doc: Writes TXT format instead of qcML.
    inputBinding:
      position: 101
      prefix: -txt
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output qcML file. If unset, writes to STDOUT.
    outputBinding:
      glob: $(inputs.out)
  - id: out1
    type:
      - 'null'
      - File
    doc: If set, writes merged forward FASTQs to this file (gzipped).
    outputBinding:
      glob: $(inputs.out1)
  - id: out2
    type:
      - 'null'
      - File
    doc: If set, writes merged reverse FASTQs to this file (gzipped)
    outputBinding:
      glob: $(inputs.out2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
