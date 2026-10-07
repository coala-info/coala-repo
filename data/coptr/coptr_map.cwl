cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coptr
  - map
label: coptr_map
doc: "Map reads to a database index.\n\nTool homepage: https://github.com/tyjo/coptr"
inputs:
  - id: index
    type: File
    doc: Name of database index. Give the index_out.1.bt2 file from coptr 
      index; the other bowtie2 index files must sit beside it.
    secondaryFiles:
      - ^^.2.bt2
      - ^^.3.bt2
      - ^^.4.bt2
      - ^^.rev.1.bt2
      - ^^.rev.2.bt2
    inputBinding:
      position: 1
      valueFrom: $(self.path.replace(/\.1\.bt2$/, ''))
  - id: input
    type:
      - File
      - Directory
    doc: File or folder containing fastq reads to map. If a folder, the 
      extension for each fastq must be one of [.fastq, .fq, .fastq.gz, fq.gz]
    inputBinding:
      position: 2
  - id: out_folder
    type: string
    doc: Folder to save mapped reads. BAM files are output here.
    inputBinding:
      position: 3
  - id: bt2_k
    type:
      - 'null'
      - int
    doc: (Default 10). Number of alignments to report. Passed to -k flag of 
      bowtie2.
    inputBinding:
      position: 103
      prefix: --bt2-k
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Set for paired end reads. Assumes fastq files end in _1.* and _2.*
    inputBinding:
      position: 103
      prefix: --paired
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie2 mapping.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_out_folder
    type: Directory
    doc: Folder to save mapped reads. BAM files are output here.
    outputBinding:
      glob: '$(inputs.out_folder)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.out_folder, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coptr:1.1.4--pyhdfd78af_3
