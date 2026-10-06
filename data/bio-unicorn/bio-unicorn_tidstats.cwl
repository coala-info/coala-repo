cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicorn
  - tidstats
label: bio-unicorn_tidstats
doc: "Compute per taxid statistics.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs:
  - id: input_bam
    type:
      - 'null'
      - File
    doc: input bam|sam|cram
    inputBinding:
      position: 1
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix; writes <prefix>.stats.txt (statistics go to stdout when
      not set)
    inputBinding:
      position: 1
      prefix: -o
  - id: acc2tax
    type: File
    doc: Accession to taxid mapping file or .khash file. Providing a .khash 
      file is much faster.
    inputBinding:
      position: 1
      prefix: -a
  - id: names
    type: File
    doc: Taxonomy names file.
    inputBinding:
      position: 1
      prefix: -n
  - id: nodes
    type: File
    doc: Taxonomy nodes file
    inputBinding:
      position: 1
      prefix: -d
  - id: filelist
    type:
      - 'null'
      - File
    doc: File containing input file paths. One per line. Give the files in 
      list_files so that the names resolve.
    inputBinding:
      position: 1
      prefix: --filelist
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM/SAM/CRAM files named in the file list, staged in the working 
      directory
  - id: dumpacc2tax
    type:
      - 'null'
      - string
    doc: Write the accession to taxid map to <str>.khash (version 2.0.0 writes 
      the file named exactly <str>).
    inputBinding:
      position: 1
      prefix: --dumpacc2tax
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints libunicorn's messages.
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: stats_stdout
    type: stdout
    doc: Per-taxid statistics table (when no output prefix is given)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Per-taxid statistics table <prefix>.stats.txt
    outputBinding:
      glob: "${ return inputs.output_prefix ? inputs.output_prefix + '.stats.txt' : []; }"
  - id: acc2tax_khash
    type:
      - 'null'
      - File
    doc: Accession to taxid map written with --dumpacc2tax (the file named by 
      dumpacc2tax)
    outputBinding:
      glob: "${ return inputs.dumpacc2tax ? inputs.dumpacc2tax : []; }"
stdout: bio-unicorn_tidstats.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.list_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
