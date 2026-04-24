cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - predictd
label: macs2_predictd
doc: "Predict fragment size from ChIP-seq alignment files using MACS2\n\nTool homepage:
  https://pypi.org/project/MACS2/"
inputs:
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: bw
    type:
      - 'null'
      - int
    doc: Band width for picking regions to compute fragment size. This value is 
      only used while building the shifting model.
    inputBinding:
      position: 101
      prefix: --bw
  - id: d_min
    type:
      - 'null'
      - int
    doc: Minimum fragment size in basepair. Any predicted fragment size less 
      than this will be excluded.
    inputBinding:
      position: 101
      prefix: --d-min
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE" or "BAMPE" or "BEDPE". The 
      default AUTO option will let MACS decide which format the file is.
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. It can be 1.0e+9 or 1000000000, or 
      shortcuts:'hs' for human (2.7e9), 'mm' for mouse (1.87e9), 'ce' for C. 
      elegans (9e7) and 'dm' for fruitfly (1.2e8)
    inputBinding:
      position: 101
      prefix: --gsize
  - id: ifile
    type:
      type: array
      items: File
    doc: ChIP-seq alignment file. If multiple files are given as '-t A B C', 
      then they will all be read and combined. Note that pair-end data is not 
      supposed to work with this command.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: mfold
    type:
      - 'null'
      - type: array
        items: int
    doc: Select the regions within MFOLD range of high-confidence enrichment 
      ratio against background to build model. Fold-enrichment in regions must 
      be lower than upper limit, and higher than the lower limit. Use as "-m 10 
      30".
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
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: rfile
    type:
      - 'null'
      - File
    doc: PREFIX of filename of R script for drawing X-correlation figure. 
      DEFAULT:'predictd' and R file will be predicted_model.R
    outputBinding:
      glob: $(inputs.rfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
