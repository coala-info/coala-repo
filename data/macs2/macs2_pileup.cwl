cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - pileup
label: macs2_pileup
doc: "Create a pileup bedGraph file from alignment files\n\nTool homepage: https://pypi.org/project/MACS2/"
inputs:
  - id: both_direction
    type:
      - 'null'
      - boolean
    doc: If this option is set as on, aligned reads will be extended in both 
      upstream and downstream directions by extension size. It means 
      [-size,size] where 0 is the 5' end of a aligned read.
    default: false
    inputBinding:
      position: 101
      prefix: --both-direction
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information. Recommended to specify a smaller buffer size 
      if there are large number of chromosomes to decrease memory usage.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: extsize
    type:
      - 'null'
      - int
    doc: The extension size in bps. Each alignment read will become a EXTSIZE of
      fragment, then be piled up. Check description for -B for detail.
    default: 200
    inputBinding:
      position: 101
      prefix: --extsize
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED", "ELAND", "ELANDMULTI", 
      "ELANDEXPORT", "SAM", "BAM", "BOWTIE", "BAMPE", or "BEDPE". The default 
      AUTO option will let 'macs2 pileup' decide which format the file is.
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: Alignment file. If multiple files are given as '-t A B C', then they 
      will all be read and combined. Note that pair-end data is not supposed to 
      work with this command.
    inputBinding:
      position: 101
      prefix: --ifile
outputs:
  - id: output_file
    type: File
    doc: Output bedGraph file name. If not specified, will write to standard 
      output.
    outputBinding:
      glob: $(inputs.output_file)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
