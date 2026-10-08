cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2-purge
label: glam2_glam2-purge
doc: "Remove sequences from a set so that no two sequences have a local alignment score above a cutoff\n\nTool homepage: https://github.com/LELEGOBOO/Glam2"
inputs:
  - id: sequence_file
    type: File
    doc: "Input sequence file (staged in the working directory; the output is named <file>.e<score> (exhaustive) or <file>.b<score> (blast))"
    inputBinding:
      position: 10
  - id: score
    type: int
    doc: "Maximum allowed local alignment score between two sequences"
    inputBinding:
      position: 11
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "sequences are DNA (default: protein)"
    inputBinding:
      position: 12
      prefix: -n
  - id: blast
    type:
      - 'null'
      - boolean
    doc: "use blast heuristic method (default for protein)"
    inputBinding:
      position: 12
      prefix: -b
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: "use an exhaustive method (default for DNA)"
    inputBinding:
      position: 12
      prefix: -e
  - id: keep_first
    type:
      - 'null'
      - boolean
    doc: "keep first sequence in the set"
    inputBinding:
      position: 12
      prefix: -q
  - id: xnu
    type:
      - 'null'
      - boolean
    doc: "use xnu to mask protein tandem repeats"
    inputBinding:
      position: 12
      prefix: -x
outputs:
  - id: output
    type: File
    doc: "Purged sequence file"
    outputBinding:
      glob: $(inputs.sequence_file.basename).[be]$(inputs.score)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sequence_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
