cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - pileup
label: macs3_pileup
doc: "Create a pileup bedGraph file from alignment files.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: barcodes
    type:
      - 'null'
      - File
    doc: A plain text file containing the barcodes for the fragment file while 
      the format is 'FRAG'.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: both_direction
    type:
      - 'null'
      - boolean
    doc: If this option is set as on, aligned reads will be extended in both 
      upstream and downstream directions by extension size.
    default: false
    inputBinding:
      position: 101
      prefix: --both-direction
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
  - id: extsize
    type:
      - 'null'
      - int
    doc: The extension size in bps. Each alignment read will become a EXTSIZE of
      fragment, then be piled up.
    default: 200
    inputBinding:
      position: 101
      prefix: --extsize
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED", "ELAND", "ELANDMULTI", 
      "ELANDEXPORT", "SAM", "BAM", "BOWTIE", "BAMPE", "BEDPE", or "FRAG".
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: Alignment file. If multiple files are given as '-t A B C', then they 
      will all be read and combined.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: max_count
    type:
      - 'null'
      - int
    doc: In the FRAG format file, the fifth column indicates the count of 
      fragments found at the exact same location from the same barcode.
    inputBinding:
      position: 101
      prefix: --max-count
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level. 0: only show critical message, 1: show additional warning
      message, 2: show process information, 3: show debug messages.'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outputfile
    type: File
    doc: Output bedGraph file name. If not specified, will write to standard 
      output.
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
