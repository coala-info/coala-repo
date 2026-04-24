cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - randsample
label: macs2_randsample
doc: "Randomly sample alignment files to a specific number or percentage of tags.\n\
  \nTool homepage: https://pypi.org/project/MACS2/"
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
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE" or "BAMPE" or "BEDPE".
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: Alignment file. If multiple files are given, then they will all be read
      and combined. Note that pair-end data is not supposed to work with this 
      command.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: number
    type:
      - 'null'
      - float
    doc: Number of tags you want to keep. Input 8000000 or 8e+6 for 8 million. 
      This option can't be used at the same time with -p/--percent.
    inputBinding:
      position: 101
      prefix: --number
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of tags you want to keep. Input 80.0 for 80%. This option 
      can't be used at the same time with -n/--num.
    inputBinding:
      position: 101
      prefix: --percentage
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed while down sampling data. Must be a non-negative 
      integer in order to be effective.
    inputBinding:
      position: 101
      prefix: --seed
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
outputs:
  - id: outputfile
    type:
      - 'null'
      - File
    doc: Output BED file name. If not specified, will write to standard output. 
      Note, if the input format is BAMPE or BEDPE, the output will be in BEDPE 
      format.
    outputBinding:
      glob: $(inputs.outputfile)
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
