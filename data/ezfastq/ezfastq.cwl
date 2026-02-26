cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezfastq
label: ezfastq
doc: "Copy FASTQ files and use sample names to make filenames consistent\n\nTool homepage:
  https://github.com/bioforensics/ezfastq/"
inputs:
  - id: seq_path
    type: Directory
    doc: path to directory containing sequences in FASTQ format; subdirectories 
      will be searched recursively
    inputBinding:
      position: 1
  - id: samples
    type:
      type: array
      items: string
    doc: name of one or more samples to process; samples can optionally be 
      renamed by appending a colon and new name to each sample name; 
      alternatively, sample names can be provided as a file with one sample name
      per line, or two tab-separated values to rename samples
    inputBinding:
      position: 2
  - id: link
    type:
      - 'null'
      - boolean
    doc: symbolically link files rather than copying; only supported for 
      gzip-compressed files
    inputBinding:
      position: 103
      prefix: --link
  - id: pair_mode
    type:
      - 'null'
      - int
    doc: specify 1 to indicate that all samples are single-end, or 2 to indicate
      that all samples are paired-end; by default, read layout is inferred 
      automatically on a per-sample basis
    inputBinding:
      position: 103
      prefix: --pair-mode
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to prepend to sample names; resulting file path will be 
      '{workdir}/seq/{prefix}_{sample}_R{1,2}.fastq.gz'
    inputBinding:
      position: 103
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: include source and destination in copy log
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: project directory to which input files will be copied and renamed; 
      current directory is used by default
    outputBinding:
      glob: $(inputs.workdir)
  - id: subdir
    type:
      - 'null'
      - Directory
    doc: subdirectory path under --workdir to which sequence files will be 
      written; PATH=`seq` by default, but can contain nesting (e.g. `seq/study`)
    outputBinding:
      glob: $(inputs.subdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezfastq:0.2--pyhdfd78af_0
