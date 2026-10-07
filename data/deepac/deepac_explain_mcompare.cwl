cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - explain
  - mcompare
label: deepac_explain_mcompare
doc: "Compare motifs.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: in_file1
    type: File
    doc: "File containing all filter motifs in transfac format"
    inputBinding:
      position: 101
      prefix: --in-file1
  - id: in_file2
    type: File
    doc: "File containing all filter motifs in transfac format"
    inputBinding:
      position: 101
      prefix: --in-file2
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Training data (.npy), necessary to calculate background GC content"
    inputBinding:
      position: 101
      prefix: --train-data
  - id: extensively
    type:
      - 'null'
      - boolean
    doc: "Compare every motif from --in_file1 with every motif from --in_file2; default: compare only motifs with the same ID"
    inputBinding:
      position: 101
      prefix: --extensively
  - id: rc
    type:
      - 'null'
      - boolean
    doc: "Consider RC-complement of a motif"
    inputBinding:
      position: 101
      prefix: --rc
  - id: shift
    type:
      - 'null'
      - boolean
    doc: "Shift motifs to find best alignment"
    inputBinding:
      position: 101
      prefix: --shift
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: "Minimal overlap between two motifs if motifs are shifted to find the best alignment (--shift)"
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "motif_compare"
    inputBinding:
      position: 101
      prefix: --out-dir
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
