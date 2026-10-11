cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncoils
label: ncoils
doc: A program that predicts coiled-coil secondary structure in proteins. Reads
  the sequences from standard input.
inputs:
  - id: input_file
    type: File
    doc: Input sequence file (FASTA), read from standard input
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Fasta output, coils shown as 'x'
    inputBinding:
      position: 1
      prefix: -f
  - id: concise
    type:
      - 'null'
      - boolean
    doc: Concise mode, report which sequences have any coils (and how many)
    inputBinding:
      position: 1
      prefix: -c
  - id: min_seg
    type:
      - 'null'
      - int
    doc: For concise mode, only report sequence if >= min coil segments
    inputBinding:
      position: 1
      prefix: -min_seg
  - id: min_p
    type:
      - 'null'
      - float
    doc: Minimum P to define coil segment (default 0.5)
    inputBinding:
      position: 1
      prefix: -min_P
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (default is 21)
    inputBinding:
      position: 1
      prefix: -win
  - id: weight_hydrophobics
    type:
      - 'null'
      - boolean
    doc: Weight heptad positions a and d the same as b, c, e, f and g
    inputBinding:
      position: 1
      prefix: -w
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose/debug mode, print extra output
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncoils:v2002-7-deb_cv1
stdin: $(inputs.input_file.path)
stdout: ncoils.out
