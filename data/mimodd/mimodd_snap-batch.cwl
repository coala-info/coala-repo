cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mimodd, snap-batch]
label: mimodd_snap-batch
doc: "Run several snap jobs and pool the resulting alignments into a multi-sample\
  \ SAM/BAM file. The first command determines the name, format and sorting of the\
  \ merged file.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: commands
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more completely specified command line calls to the snap tool 
      (use "" to enclose individual lines; start each with the word snap); file names in them must be relative
      names of files given in referenced_files
    inputBinding:
      position: 101
      prefix: -s
  - id: input_file
    type:
      - 'null'
      - File
    doc: an input file of completely specified command line calls to the snap 
      tool
    inputBinding:
      position: 101
      prefix: -f
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: files (reads, headers, reference genomes) named in the snap command lines
  - id: referenced_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: snap index directories named in the snap command lines
  - id: merged_output
    type: string
    doc: name of the merged output file; must equal the --ofile value of the first
      snap command
outputs:
  - id: merged_alignments
    type: File
    doc: pooled multi-sample alignment file written by the first command's --ofile
    outputBinding:
      glob: $(inputs.merged_output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.referenced_files || [])
      - $(inputs.referenced_directories || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
stdout: mimodd_snap-batch.out
