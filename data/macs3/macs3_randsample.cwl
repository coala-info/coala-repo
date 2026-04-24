cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - randsample
label: macs3_randsample
doc: Randomly sample tags from alignment files to a specified percentage or 
  number.
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
    doc: Alignment file. If multiple files are given as '-t A B C', then they 
      will all be read and combined.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: number
    type: float
    doc: Number of tags you want to keep. Input 8000000 or 8e+6 for 8 million. 
      This option can't be used at the same time with -p/--percent.
    inputBinding:
      position: 101
      prefix: --number
  - id: outdir
    type: string
    doc: If specified all output files will be written to that directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outputfile
    type: string
    doc: Output BED file name. If not specified, will write to standard output.
    inputBinding:
      position: 101
      prefix: --ofile
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
  - id: output_outputfile
    type:
      - 'null'
      - File
    doc: Output BED file name. If not specified, will write to standard output.
    outputBinding:
      glob: $(inputs.outputfile)
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
