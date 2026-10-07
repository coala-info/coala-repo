cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - cload
  - hiclib
label: cooler_cload_hiclib
doc: "Bin a hiclib HDF5 contact list (frag) file.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: bins
    type: File
    doc: 'One of the following: <TEXT:INTEGER> : 1. Path to a chromsizes file, 2.
      Bin size in bp, or <TEXT> : Path to BED file defining the genomic bin segmentation.
      Give a chromsizes file together with bin_size, or a BED file alone.'
    inputBinding:
      position: 1
      valueFrom: "$(inputs.bin_size ? self.path + ':' + inputs.bin_size : self.path)"
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size in bp, used when bins is a chromsizes file.
  - id: pairs_path
    type: File
    doc: hiclib HDF5 contact list (frag) file.
    inputBinding:
      position: 2
  - id: cool_path
    type: string
    doc: Output COOL file path or URI.
    inputBinding:
      position: 3
  - id: metadata
    type:
      - 'null'
      - File
    doc: Path to JSON file containing user metadata.
    inputBinding:
      position: 104
      prefix: --metadata
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10)
    inputBinding:
      position: 104
      prefix: --assembly
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Control the number of pixels handled by each worker process at a time.
    inputBinding:
      position: 104
      prefix: --chunksize
outputs:
  - id: cool
    type: File
    doc: Output COOL file
    outputBinding:
      glob: $(inputs.cool_path.split('::')[0])
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
