cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - commec
  - split
label: commec_split
doc: "Split a multi-record FASTA file into individual files, one for each record\n\
  \nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: fasta_file
    type: File
    doc: Input fasta file (staged in the working directory, because the 
      split files are written beside it)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: split_fasta
    type:
      type: array
      items: File
    doc: one FASTA file per input record (named from the cleaned record 
      description, or <input>-split-<n>.fasta)
    outputBinding:
      glob: '*.fasta'
      outputEval: '$(self.filter(function(f){ return f.basename != 
        inputs.fasta_file.basename; }))'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec_split.out
