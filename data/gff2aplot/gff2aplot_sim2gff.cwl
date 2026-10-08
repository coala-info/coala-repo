cwlVersion: v1.2
class: CommandLineTool
baseCommand: sim2gff
label: gff2aplot_sim2gff
doc: "Convert SIM alignment files into GFF records for use with gff2aplot and gff2javaplot.\n\nTool homepage: http://genome.imim.es/software/gfftools/GFF2APLOT.html"
inputs:
  - id: write_file
    type:
      - 'null'
      - boolean
    doc: "output is written to a file named <sim_file>.gff"
    inputBinding:
      position: 1
      prefix: -f
  - id: interchange_sequences
    type:
      - 'null'
      - boolean
    doc: "interchange the order of sequences (Seq1 on y-axis, Seq2 on x-axis)"
    inputBinding:
      position: 1
      prefix: -r
  - id: x_name
    type:
      - 'null'
      - string
    doc: "species name for species1 (default: Seq1)"
    inputBinding:
      position: 1
      prefix: -x
  - id: y_name
    type:
      - 'null'
      - string
    doc: "species name for species2 (default: Seq2)"
    inputBinding:
      position: 1
      prefix: -y
  - id: use_fasta_headers
    type:
      - 'null'
      - boolean
    doc: "use the fasta file headers for species labels"
    inputBinding:
      position: 1
      prefix: -H
  - id: sim_file
    type: File
    doc: "SIM alignment file"
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
      glob: "$(inputs.sim_file.basename).gff"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sim_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2aplot:v2.0-11-deb_cv1
stdout: gff2aplot_sim2gff.gff
