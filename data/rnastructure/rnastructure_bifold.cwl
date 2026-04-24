cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifold
label: rnastructure_bifold
doc: "Calculates the secondary structure of two RNA or DNA sequences.\n\nTool homepage:
  http://rna.urmc.rochester.edu/RNAstructure.html"
inputs:
  - id: seq_file_1
    type: File
    doc: The name of a file containing a first input sequence.
    inputBinding:
      position: 1
  - id: seq_file_2
    type: File
    doc: The name of a file containing a second input sequence.
    inputBinding:
      position: 2
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Specify the name of a folding alphabet and associated nearest neighbor 
      parameters. The alphabet is the prefix for the thermodynamic parameter 
      files, e.g. "rna" for RNA parameters or "dna" for DNA parameters or a 
      custom extended/modified alphabet. The thermodynamic parameters need to 
      reside in the at the location indicated by environment variable DATAPATH. 
      The default is "rna" (i.e. use RNA parameters). This option overrides the 
      --DNA flag.
    inputBinding:
      position: 103
      prefix: --alphabet
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Specify that the sequence is DNA, and DNA parameters are to be used. 
      Default is to use RNA parameters.
    inputBinding:
      position: 103
      prefix: --DNA
  - id: intramolecular
    type:
      - 'null'
      - boolean
    doc: Forbid intramolecular pairs (pairs within the same strand). Default is 
      to allow intramolecular pairs.
    inputBinding:
      position: 103
      prefix: --intramolecular
  - id: list
    type:
      - 'null'
      - boolean
    doc: Specify that the input is a list, rather than two sequences.
    inputBinding:
      position: 103
      prefix: --list
  - id: max_loop_size
    type:
      - 'null'
      - int
    doc: Specify a maximum internal/bulge loop size.
    inputBinding:
      position: 103
      prefix: --loop
  - id: max_percent_energy_diff
    type:
      - 'null'
      - int
    doc: Specify a maximum percent energy difference. Default is 10 percent 
      (specified as 10, not 0.1).
    inputBinding:
      position: 103
      prefix: --percent
  - id: max_structures
    type:
      - 'null'
      - int
    doc: Specify a maximum number of structures.
    inputBinding:
      position: 103
      prefix: --maximum
  - id: save_file
    type:
      - 'null'
      - File
    doc: Specify the name of a save file, needed for dotplots and refolding. 
      Default is not to generate a save file.
    inputBinding:
      position: 103
      prefix: --save
  - id: temperature
    type:
      - 'null'
      - float
    doc: Specify the temperature at which calculation takes place in Kelvin. 
      Default is 310.15 K, which is 37 degrees C.
    inputBinding:
      position: 103
      prefix: --temperature
  - id: window_size
    type:
      - 'null'
      - int
    doc: Specify a window size.
    inputBinding:
      position: 103
      prefix: --window
outputs:
  - id: ct_file
    type: File
    doc: The name of a CT file to which output will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
