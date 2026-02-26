cwlVersion: v1.2
class: CommandLineTool
baseCommand: clove
label: clove
doc: "CLOVE: Structural variant classification tool\n\nTool homepage: https://github.com/PapenfussLab/clove"
inputs:
  - id: bam_file
    type: File
    doc: BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: coverage_info
    type:
      type: array
      items: float
    doc: Mean coverage and coverage values
    inputBinding:
      position: 101
      prefix: -c
  - id: input_breakpoints
    type:
      type: array
      items: File
    doc: List of breakpoints and algorithm 
      (Socrates/Delly/Delly2/Crest/Gustaf/BEDPE/GRIDSS). Can be specified more 
      than once.
    inputBinding:
      position: 101
      prefix: -i
  - id: skip_read_depth_check
    type:
      - 'null'
      - boolean
    doc: Do not perform read depth check. This option will lead all deletions 
      and tandem duplications to fail, but runs a lot faster. Use to get an idea
      about complex variants only.
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_filename
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clove:0.17--hdfd78af_2
