cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - unionbedg
label: bedtools_unionbedg
doc: "Combines multiple BedGraph files into a single file, allowing for direct comparison
  of coverage across multiple samples.\n\nTool homepage: http://bedtools.readthedocs.org/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: BedGraph file names to combine.
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_unionbedg.out
