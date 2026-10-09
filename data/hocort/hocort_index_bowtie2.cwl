cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hocort
  - index
  - bowtie2
label: hocort_index_bowtie2
doc: "build a Bowtie2 index for host read removal\n\nTool homepage: https://github.com/ignasrum/hocort"
inputs:
  - id: input
    type: File
    doc: 'path to sequence files (fasta)'
    inputBinding:
      position: 101
      prefix: --input
  - id: output_dir
    type: string
    doc: 'Name of the (new, empty) output directory the index is written to'
  - id: index_name
    type: string
    doc: 'Base name of the index inside the output directory'
    inputBinding:
      position: 102
      prefix: --output
      valueFrom: $(inputs.output_dir)/$(inputs.index_name)
outputs:
  - id: index_dir
    type: Directory
    doc: Directory with the index files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: |-
          ${
            return {"class": "Directory", "basename": inputs.output_dir, "listing": []};
          }
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hocort:1.2.2--py39hdfd78af_0
