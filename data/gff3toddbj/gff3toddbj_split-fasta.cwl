cwlVersion: v1.2
class: CommandLineTool
baseCommand: split-fasta
label: gff3toddbj_split-fasta
doc: "Split the FASTA block (after ##FASTA) from a GFF3 file and save both the FASTA and the slimmed GFF3.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Suffix added to the output filenames (default _splitted)"
    inputBinding:
      position: 1
      prefix: --suffix
  - id: gff3
    type: File
    doc: "Input GFF3 with an embedded FASTA block"
    inputBinding:
      position: 2
outputs:
  - id: split_files
    type: File[]
    doc: "The GFF3 without FASTA and the FASTA file, written next to the input"
    outputBinding:
      glob: "$(inputs.gff3.nameroot)$(inputs.suffix || '_splitted')*"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gff3)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_split-fasta.out
