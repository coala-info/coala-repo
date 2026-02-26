cwlVersion: v1.2
class: CommandLineTool
baseCommand: index
label: mimodd_index
doc: "Index generation tool for various formats.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: index_type
    type: string
    doc: the type of index to be generated; use "snap" to create a reference 
      genome index for the snap alignment tool, "fai" to produce a 
      samtools-style reference index, "bai" for a bam file index that can be 
      used, e.g., with the varcall tool and is required by third-party tools 
      like IGV.
    inputBinding:
      position: 1
  - id: file_to_index
    type: File
    doc: the fasta (reference genome) or bam (aligned reads) input file to index
    inputBinding:
      position: 2
  - id: overflow_factor
    type:
      - 'null'
      - int
    doc: factor (between 1 and 1000) to set the size of the index build overflow
      space
    default: 40
    inputBinding:
      position: 103
      prefix: --overflow
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress original messages from underlying tools
    inputBinding:
      position: 103
      prefix: --quiet
  - id: seedsize
    type:
      - 'null'
      - int
    doc: Seed size used in building the index
    default: 20
    inputBinding:
      position: 103
      prefix: --seedsize
  - id: slack
    type:
      - 'null'
      - float
    doc: Hash table slack for indexing
    default: 0.3
    inputBinding:
      position: 103
      prefix: --slack
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum number of threads to use (overrides config setting)
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: 'specifies the location at which to save the index (default: save the index
      alongside the input file as <input file>.<INDEX_TYPE> for indices of type "fai"
      and "bai", or in a directory <input file>.snap_index)'
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
