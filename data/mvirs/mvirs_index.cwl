cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mvirs
  - index
label: mvirs_index
doc: "Localisation of inducible prophages using NGS data\n\nTool homepage: https://github.com/SushiLab/mVIRs"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file. Can be gzipped. The bwa index files are written 
      beside it, so it is staged in the working directory.
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: indexed_reference
    type: File
    doc: The reference with its bwa index files, for mvirs oprs -db.
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
    outputBinding:
      glob: $(inputs.reference_fasta.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
stdout: mvirs_index.out
