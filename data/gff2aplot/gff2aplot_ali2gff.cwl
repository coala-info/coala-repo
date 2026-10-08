cwlVersion: v1.2
class: CommandLineTool
baseCommand: ali2gff
label: gff2aplot_ali2gff
doc: "Translate alignment output files (MUMmer or SIM) into GFF records for gff2aplot.\n\nTool homepage: http://genome.imim.es/software/gfftools/GFF2APLOT.html"
inputs:
  - id: interchange_sequences
    type:
      - 'null'
      - boolean
    doc: "interchange the order of sequences (sequence 1 on y-axis, sequence 2 on x-axis)"
    inputBinding:
      position: 1
      prefix: -r
  - id: frame_label
    type:
      - 'null'
      - string
    doc: "put label 'frame' in gff output: one of . 0 1 2"
    inputBinding:
      position: 1
      prefix: -t
  - id: x_name
    type:
      - 'null'
      - string
    doc: "species name for species 1 (default: Seq1)"
    inputBinding:
      position: 1
      prefix: -x
  - id: y_name
    type:
      - 'null'
      - string
    doc: "species name for species 2 (default: Seq2)"
    inputBinding:
      position: 1
      prefix: -y
  - id: ignore_full_identities
    type:
      - 'null'
      - boolean
    doc: "ignore full sequence identities"
    inputBinding:
      position: 1
      prefix: -i
  - id: write_file
    type:
      - 'null'
      - boolean
    doc: "write output to a file next to the input"
    inputBinding:
      position: 1
      prefix: -f
  - id: alignment_file
    type: File
    doc: "alignment output file"
    inputBinding:
      position: 2
outputs:
  - id: gff_stdout
    type: stdout
    doc: "GFF records on standard output"
  - id: gff_file
    type: File?
    doc: "GFF file written next to the input when -f is used"
    outputBinding:
      glob: "$(inputs.alignment_file.basename).gff"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.alignment_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2aplot:v2.0-11-deb_cv1
stdout: gff2aplot_ali2gff.gff
