cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToPslx
label: ucsc-psltopslx
doc: "Convert from psl to pslx format, which includes sequences. qSeqSpec and tSeqSpec
  can be a nib directory, a 2bit file, or a FASTA file. FASTA files should end in .fa,
  .fa.gz, .fa.Z or .fa.bz2 and are read into memory.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: q_seq_spec
    type: File
    doc: Query sequence, a 2bit file or a FASTA file (nib directory also accepted).
    inputBinding:
      position: 11
  - id: t_seq_spec
    type: File
    doc: Target sequence, a 2bit file or a FASTA file (nib directory also accepted).
    inputBinding:
      position: 12
  - id: out_pslx
    type: string
    doc: Output PSLX file name.
    inputBinding:
      position: 13
  - id: masked
    type:
      - 'null'
      - boolean
    doc: If specified, repeats are in lower case, otherwise the entire sequence is
      in lower case.
    inputBinding:
      position: 1
      prefix: -masked
outputs:
  - id: out_pslx_file
    type: File
    doc: Output PSLX file.
    outputBinding:
      glob: $(inputs.out_pslx)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltopslx:482--h0b57e2e_0
