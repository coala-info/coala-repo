cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - convert_alphabet.py
label: wub_convert_alphabet.py
doc: 'Convert between DNA and RNA alphabets.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fastx
    type: File
    doc: 'Input file (default: stdin).'
    inputBinding:
      position: 1
  - id: output_fastx
    type:
      - 'null'
      - string
    doc: 'Output file (default: stdout).'
    default: convert_alphabet.out.fastq
    inputBinding:
      position: 2
  - id: in_format
    type:
      - 'null'
      - string
    doc: Input format (fastq).
    inputBinding:
      position: 103
      prefix: -i
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format (fastq).
    inputBinding:
      position: 103
      prefix: -o
  - id: rna_to_dna
    type:
      - 'null'
      - boolean
    doc: RNA->DNA alphabet conversion.
    inputBinding:
      position: 103
      prefix: -D
  - id: dna_to_rna
    type:
      - 'null'
      - boolean
    doc: DNA->RNA alphabet conversion.
    inputBinding:
      position: 103
      prefix: -R
outputs:
  - id: output_fastx_file
    type: File
    doc: Sequence file with the converted alphabet.
    outputBinding:
      glob: $(inputs.output_fastx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
