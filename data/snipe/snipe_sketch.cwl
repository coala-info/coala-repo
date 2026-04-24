cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snipe
  - sketch
label: snipe_sketch
doc: "Sketch genomic data to generate signatures for QC.\n\nTool homepage: https://github.com/snipe-bio/snipe"
inputs:
  - id: amplicon
    type:
      - 'null'
      - File
    doc: Amplicon FASTA file.
    inputBinding:
      position: 101
      prefix: --amplicon
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for sample sketching.
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use.
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: ksize
    type:
      - 'null'
      - int
    doc: K-mer size.
    inputBinding:
      position: 101
      prefix: --ksize
  - id: name
    type: string
    doc: Signature name.
    inputBinding:
      position: 101
      prefix: --name
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample
    type:
      - 'null'
      - File
    doc: Sample FASTA file.
    inputBinding:
      position: 101
      prefix: --sample
  - id: scale
    type:
      - 'null'
      - int
    doc: Sourmash scale factor.
    inputBinding:
      position: 101
      prefix: --scale
  - id: ychr
    type:
      - 'null'
      - File
    doc: Y chromosome FASTA file (overrides the reference ychr).
    inputBinding:
      position: 101
      prefix: --ychr
outputs:
  - id: output_file
    type: File
    doc: Output file with .zip extension.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
