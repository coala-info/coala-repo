cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - genomesim
label: rtg-tools_rtg_genomesim
doc: 'Simulates a reference genome. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output
    type: string
    doc: 'output SDF'
    inputBinding:
      position: 101
      prefix: --output
  - id: comment
    type:
      - 'null'
      - string
    doc: 'comment to include in the generated SDF'
    inputBinding:
      position: 101
      prefix: --comment
  - id: freq
    type:
      - 'null'
      - string
    doc: 'relative frequencies of A,C,G,T in the generated sequence (Default is 1,1,1,1)'
    inputBinding:
      position: 101
      prefix: --freq
  - id: length
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --length
    doc: 'length of generated sequence. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'maximum sequence length'
    inputBinding:
      position: 101
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'minimum sequence length'
    inputBinding:
      position: 101
      prefix: --min-length
  - id: num_contigs
    type:
      - 'null'
      - int
    doc: 'number of sequences to generate'
    inputBinding:
      position: 101
      prefix: --num-contigs
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'sequence name prefix (Default is simulatedSequence)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for random number generator'
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sdf
    type: Directory
    doc: Output SDF directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_genomesim.out
