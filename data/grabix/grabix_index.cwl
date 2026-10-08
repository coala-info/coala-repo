cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grabix
  - index
label: grabix_index
doc: "Create a grabix index (.gbi) for a bgzipped file. The index file is written next to the input file.\n\nTool homepage: https://github.com/arq5x/grabix"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bgzf_file)
        writable: true
inputs:
  - id: bgzf_file
    type: File
    doc: bgzipped file to index (for example big.vcf.gz)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: gbi_index
    type: File
    doc: grabix index (<bgzf_file>.gbi)
    outputBinding:
      glob: $(inputs.bgzf_file.basename).gbi
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix_index.out
