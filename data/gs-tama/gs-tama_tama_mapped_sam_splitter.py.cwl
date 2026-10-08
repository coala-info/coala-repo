cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_mapped_sam_splitter.py
label: gs-tama_tama_mapped_sam_splitter.py
doc: "This script splits mapped sam files by chromosome\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: sam_file
    type: File
    doc: Mapped sam (or bam) file; the file name must end in sam or bam
    inputBinding:
      position: 1
  - id: number_of_files
    type: int
    doc: "Number of files to split into; reads of one chromosome stay in one file"
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    doc: Output prefix; the pieces are named prefix_1.sam, prefix_2.sam, ...
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: split_sam_files
    type:
      type: array
      items: File
    doc: Split sam files (prefix_N.sam)
    outputBinding:
      glob: $(inputs.output_prefix)_*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_mapped_sam_splitter.py.out
