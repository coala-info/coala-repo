cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomedata-load
label: genomedata_genomedata-load
doc: "Create Genomedata archive named GENOMEDATAFILE by loading specified track data
  and sequences. If GENOMEDATAFILE already exists, it will be overwritten.\n\nTool
  homepage: http://genomedata.hoffmanlab.org"
inputs:
  - id: genomedatafile
    type: string
    doc: genomedata archive
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - boolean
    doc: sequence files contain assembly (AGP) files instead of sequence
    inputBinding:
      position: 102
      prefix: --assembly
  - id: assembly_report
    type:
      - 'null'
      - File
    doc: Tab-delimited file with columnar mappings between chromosome naming 
      styles.
    inputBinding:
      position: 102
      prefix: --assembly-report
  - id: directory_mode
    type:
      - 'null'
      - boolean
    doc: If specified, the Genomedata archive will be implemented as a 
      directory, with a separate file for each Chromosome. This is recommended 
      if there are a small number of Chromosomes. The default behavior is to use
      a directory if there are fewer than 100 Chromosomes being added.
    inputBinding:
      position: 102
      prefix: -d
  - id: file_mode
    type:
      - 'null'
      - boolean
    doc: If specified, the Genomedata archive will be implemented as a single 
      file, with a separate h5 group for each Chromosome. This is recommended if
      there are a large number of Chromosomes. The default behavior is to use a 
      single file if there are at least 100 Chromosomes being added.
    inputBinding:
      position: 102
      prefix: -f
  - id: maskfile
    type:
      - 'null'
      - File
    doc: A BED file containing regions to mask out from tracks before loading
    inputBinding:
      position: 102
      prefix: --maskfile
  - id: name_style
    type:
      - 'null'
      - string
    doc: Chromsome naming style to use based on ASSEMBLY-REPORT.
    inputBinding:
      position: 102
      prefix: --name-style
  - id: sequence
    type:
      - 'null'
      - type: array
        items: File
    doc: Add the sequence data in the specified file or files (may use UNIX glob
      wildcard syntax)
    inputBinding:
      position: 102
      prefix: --sequence
  - id: sizes
    type:
      - 'null'
      - boolean
    doc: sequence files contain list of sizes instead of sequence
    inputBinding:
      position: 102
      prefix: --sizes
  - id: track
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add data from FILE as the track NAME, such as: -t signal=signal.wig'
    inputBinding:
      position: 102
      prefix: --track
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print status updates and diagnostic messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomedata:1.7.4--py311h87bb1fd_0
stdout: genomedata_genomedata-load.out
