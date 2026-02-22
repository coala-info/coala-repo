cwlVersion: v1.2
class: CommandLineTool
baseCommand: AC
label: ac_AC
doc: "Compression of amino acid sequences.\n\nTool homepage: https://github.com/cobilab/ac"
inputs:
  - id: input_files
    type:
      type: array
      items: string
    doc: File to compress (last argument). For more files use splitting ":" 
      characters.
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: level of compression [1;7] (lazy -tm setup)
    inputBinding:
      position: 102
      prefix: -l
  - id: compression_levels
    type:
      - 'null'
      - boolean
    doc: show AC compression levels
    inputBinding:
      position: 102
      prefix: -s
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: force overwrite of output
    inputBinding:
      position: 102
      prefix: -f
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference file ("-rm" are loaded here)
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_model
    type:
      - 'null'
      - type: array
        items: string
    doc: reference model (<c>:<d>:<g>/<m>:<e>:<a>). <c> context-order size, <d> 
      alpha (1/<d>), <g> gamma [0;1), <m> max mutations, <e> estimator, <a> 
      gamma [0;1)
    inputBinding:
      position: 102
      prefix: -rm
  - id: target_model
    type:
      - 'null'
      - type: array
        items: string
    doc: target model (<c>:<d>:<g>/<m>:<e>:<a>). <c> context-order size, <d> 
      alpha (1/<d>), <g> gamma [0;1), <m> max mutations, <e> estimator, <a> 
      gamma [0;1)
    inputBinding:
      position: 102
      prefix: -tm
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold frequency to discard from alphabet
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (more information)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: create_iae_file
    type:
      - 'null'
      - File
    doc: it creates a file with the extension ".iae" with the respective 
      information content.
    outputBinding:
      glob: $(inputs.create_iae_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac:1.1--h503566f_6
