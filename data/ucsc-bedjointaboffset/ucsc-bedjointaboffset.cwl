cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-bedjointaboffset
label: ucsc-bedjointaboffset
doc: "Joins two BED files, aligning them by tab and offset.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: file1
    type: File
    doc: The first BED file.
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: The second BED file.
    inputBinding:
      position: 2
  - id: offset
    type:
      - 'null'
      - int
    doc: The offset to apply to the second file's coordinates. A positive offset
      shifts the second file's regions to the right, and a negative offset 
      shifts them to the left. Defaults to 0.
    inputBinding:
      position: 103
      prefix: --offset
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The output file to write the joined BED data to. If not specified, the 
      output will be written to standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0
