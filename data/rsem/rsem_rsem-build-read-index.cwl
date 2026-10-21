cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-build-read-index
label: rsem_rsem-build-read-index
doc: "Build a read index (.ridx file) for each read file, so that RSEM's EM step
  can jump to reads quickly. The index files are written next to the read
  files.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: gap
    type: int
    doc: Gap between indexed reads (rsem-calculate-expression uses 32).
    inputBinding:
      position: 1
  - id: has_quality
    type: int
    doc: hasQ, 1 if the read files are FASTQ (have quality scores), 0 if they are
      FASTA.
    inputBinding:
      position: 2
  - id: quiet
    type: int
    doc: 1 to run quietly, 0 to print progress.
    inputBinding:
      position: 3
  - id: read_files
    type:
      type: array
      items: File
    doc: The read files to index (readFile1, readFile2, ...). They are copied into
      the working directory and the .ridx files are written beside them.
    inputBinding:
      position: 4
      valueFrom: $(self.map(function(f) { return f.basename; }))
outputs:
  - id: read_index_files
    type:
      type: array
      items: File
    outputBinding:
      glob: '*.ridx'
    doc: One .ridx index file for each read file.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.read_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
