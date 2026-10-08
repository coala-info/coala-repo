cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hlso
  - convert
label: haplotype-lso_convert
doc: "Convert sequence files (FASTA, FASTQ, AB1, SCF) into FASTA files.\n\nTool homepage: https://github.com/holtgrewe/haplotype-lso"
inputs:
  - id: file_name_as_seq_name
    type:
      - 'null'
      - boolean
    doc: "Set file name to sample name"
    inputBinding:
      position: 1
      prefix: --file-name-as-seq-name
  - id: out_dir
    type: string
    doc: "Path to output directory."
    inputBinding:
      position: 2
  - id: seq_files
    type:
      type: array
      items: File
    doc: "Sequence files to convert"
    inputBinding:
      position: 3
outputs:
  - id: converted
    type: Directory
    doc: "Directory with the converted FASTA files"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplotype-lso:0.4.4--pyhdfd78af_4
