cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa-aln-interactive
  - fa2pac
label: bwa-aln-interactive_fa2pac
doc: "Convert FASTA to PAC format for BWA indexing\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for the .pac, .ann and .amb files [same as the FASTA name]
    inputBinding:
      position: 2
  - id: f_flag
    type:
      - 'null'
      - boolean
    doc: write the forward strand only (no reverse complement) to the .pac file
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: pac
    type: File
    doc: Packed sequence (.pac) file
    outputBinding:
      glob: '$(inputs.out_prefix ? inputs.out_prefix : inputs.input_fasta.basename).pac'
  - id: ann
    type: File
    doc: Sequence annotation (.ann) file
    outputBinding:
      glob: '$(inputs.out_prefix ? inputs.out_prefix : inputs.input_fasta.basename).ann'
  - id: amb
    type: File
    doc: Ambiguous base (.amb) file
    outputBinding:
      glob: '$(inputs.out_prefix ? inputs.out_prefix : inputs.input_fasta.basename).amb'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
