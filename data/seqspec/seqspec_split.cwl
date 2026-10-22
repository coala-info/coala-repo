cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqspec
  - split
label: seqspec_split
doc: "Split seqspec file into one file per modality.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Path to output files
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory with one spec file per modality (<output>.<modality>.yaml)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
