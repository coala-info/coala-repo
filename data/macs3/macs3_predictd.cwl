cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - predictd
label: macs3_predictd
doc: "Predict d or fragment size from alignment files\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: bw
    type:
      - 'null'
      - int
    doc: Band width for picking regions to compute fragment size. This value is 
      only used while building the shifting model.
    default: 300
    inputBinding:
      position: 101
      prefix: --bw
  - id: d_min
    type:
      - 'null'
      - int
    doc: Minimum fragment size in basepair. Any predicted fragment size less 
      than this will be excluded.
    default: 20
    inputBinding:
      position: 101
      prefix: --d-min
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE" or "BAMPE" or "BEDPE".
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. It can be 1.0e+9 or 1000000000, or 
      shortcuts:'hs' for human, 'mm' for mouse, 'ce' for C. elegans and 'dm' for
      fruitfly.
    default: hs
    inputBinding:
      position: 101
      prefix: --gsize
  - id: ifile
    type:
      type: array
      items: File
    doc: ChIP-seq alignment file. If multiple files are given as '-t A B C', 
      then they will all be read and combined.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: mfold
    type:
      - 'null'
      - type: array
        items: int
    doc: Select the regions within MFOLD range of high-confidence enrichment 
      ratio against background to build model. Use as "-m 10 30".
    default:
      - 5
      - 50
    inputBinding:
      position: 101
      prefix: --mfold
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
  - id: rfile
    type:
      - 'null'
      - File
    doc: PREFIX of filename of R script for drawing X-correlation figure.
    outputBinding:
      glob: $(inputs.rfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
