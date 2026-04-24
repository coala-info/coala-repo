cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - filterdup
label: macs2_filterdup
doc: "Filter duplicate reads from alignment files based on a binomial distribution
  test or a fixed threshold.\n\nTool homepage: https://pypi.org/project/MACS2/"
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
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: When set, filterdup will only output numbers instead of writing output 
      files.
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE" or "BAMPE" or "BEDPE".
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. It can be 1.0e+9 or 1000000000, or 
      shortcuts:'hs' for human (2.7e9), 'mm' for mouse (1.87e9), 'ce' for C. 
      elegans (9e7) and 'dm' for fruitfly (1.2e8).
    inputBinding:
      position: 101
      prefix: --gsize
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
  - id: keep_duplicates
    type:
      - 'null'
      - string
    doc: It controls the 'macs2 filterdup' behavior towards duplicate tags/pairs
      at the exact same location. 'auto' calculates max tags based on binomial 
      distribution; 'all' keeps every tag. If an integer is given, at most this 
      number of tags will be kept.
    inputBinding:
      position: 101
      prefix: --keep-dup
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pvalue
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for binomial distribution test.
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file name. If not specified, will write to standard output. 
      Note, if the input format is BAMPE or BEDPE, the output will be in BEDPE 
      format.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
