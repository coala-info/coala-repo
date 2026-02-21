cwlVersion: v1.2
class: CommandLineTool
baseCommand: AminoExtract
label: aminoextract
doc: "A quick tool to extract amino acid sequences from a FASTA file.\n\nTool homepage:
  https://pypi.org/project/AminoExtract/"
inputs:
  - id: feature_type
    type:
      - 'null'
      - type: array
        items: string
    doc: Defines which feature types in the input GFF will be processed to AA sequences.
      Defaults to 'CDS'. You can provide multiple types (space-separated), e.g. -ft
      CDS gene exon
    default: CDS
    inputBinding:
      position: 101
      prefix: --feature-type
  - id: features_file
    type: File
    doc: GFF file containing the information of the amino acid sequences to extract.
    inputBinding:
      position: 101
      prefix: --features
  - id: input_file
    type: File
    doc: Input FASTA file with nucleotide sequences.
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_gaps
    type:
      - 'null'
      - boolean
    doc: If this flag is set then the AA translation will be done including gaps in
      the nucleotide sequence. This results in an "X" on gapped positions in the AA
      sequence as gap characters ("-") will be replaced by "N" in the nucleotide sequence.
      By default, gaps are removed before translation.
    inputBinding:
      position: 101
      prefix: --keep-gaps
  - id: sample_name
    type: string
    doc: Name of the sample that is being processed. This will be used to create the
      fasta headers when all amino acid sequences are written to a single file, or
      as a prefix for individual files.
    inputBinding:
      position: 101
      prefix: --name
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information during the process.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_path
    type: File
    doc: Output path, either a file or directory. If a file path is given, then all
      amino acid sequences will be written to this file. If a directory path is given,
      then each amino acid sequence will be written to a separate file in this directory.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aminoextract:0.4.1--pyhdfd78af_0
