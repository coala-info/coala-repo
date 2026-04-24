cwlVersion: v1.2
class: CommandLineTool
baseCommand: solote_SoloTE_RepeatMasker_to_BED.py
label: solote_SoloTE_RepeatMasker_to_BED.py
doc: "Converts RepeatMasker output to BED format.\n\nTool homepage: https://github.com/bvaldebenitom/SoloTE"
inputs:
  - id: input_rm_file
    type: File
    doc: Input RepeatMasker output file.
    inputBinding:
      position: 1
  - id: include_dna_transposons
    type:
      - 'null'
      - boolean
    doc: Include DNA transposons in the output BED file. By default, they are 
      not included.
    inputBinding:
      position: 102
      prefix: --include_dna_transposons
  - id: include_interspersed
    type:
      - 'null'
      - boolean
    doc: Include interspersed repeats in the output BED file. By default, only 
      "TE" and "SINE/LINE" are included.
    inputBinding:
      position: 102
      prefix: --include_interspersed
  - id: include_sines_lines
    type:
      - 'null'
      - boolean
    doc: Include SINE/LINE repeats in the output BED file. By default, they are 
      included.
    inputBinding:
      position: 102
      prefix: --include_sines_lines
  - id: include_unclassified
    type:
      - 'null'
      - boolean
    doc: Include unclassified repeats in the output BED file. By default, they 
      are not included.
    inputBinding:
      position: 102
      prefix: --include_unclassified
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of repeats to include in the output BED file. Default is
      100.
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum score of repeats to include in the output BED file. Default is 
      0.
    inputBinding:
      position: 102
      prefix: --min_score
outputs:
  - id: output_bed_file
    type: File
    doc: Output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solote:1.09--hdfd78af_0
