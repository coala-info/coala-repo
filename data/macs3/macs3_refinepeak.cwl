cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - refinepeak
label: macs3_refinepeak
doc: "Refine peak summits and compute enrichment scores using MACS3\n\nTool homepage:
  https://pypi.org/project/MACS3/"
inputs:
  - id: bed_file
    type: File
    doc: Candidate peak file in BED format. REQUIRED.
    inputBinding:
      position: 101
      prefix: -b
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information. In most cases, you don't have to change this 
      parameter.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff. Regions with SPP wtd score lower than cutoff will not be 
      considerred.
    default: 5
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE". The default AUTO option will 
      let 'macs3 refinepeak' decide which format the file is.
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: ChIP-seq alignment file. If multiple files are given as '-t A B C', 
      then they will all be read and combined. Note that pair-end data is not 
      supposed to work with this command. REQUIRED.
    inputBinding:
      position: 101
      prefix: --ifile
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Scan window size on both side of the summit (default: 100bp)'
    default: 100
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: ofile
    type:
      - 'null'
      - File
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile)
  - id: o_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    outputBinding:
      glob: $(inputs.o_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
