cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfasta
  - flatten
label: pyfasta_flatten
doc: "Flatten a fasta file inplace so all later access by pyfasta will use that flattened (but still viable) fasta file.\n\nTool homepage: https://github.com/brentp/pyfasta"
inputs:
  - id: fasta
    type: File
    doc: "path to the fasta file"
    inputBinding:
      valueFrom: $(self.basename)
      position: 20
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: flattened_fasta
    type: File
    doc: The flattened fasta file (rewritten in place).
    outputBinding:
      glob: $(inputs.fasta.basename)
    secondaryFiles:
      - pattern: .gdx
        required: false
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_flatten.out
