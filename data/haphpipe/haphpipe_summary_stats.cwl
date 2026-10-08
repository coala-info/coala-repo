cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - summary_stats
label: haphpipe_summary_stats
doc: "Calculate summary statistics for Haplotype Pipeline results.\n\nTool homepage:
  https://github.com/gwcbi/haphpipe"
inputs:
  - id: amplicons
    type:
      - 'null'
      - boolean
    doc: Amplicons used in assembly
    inputBinding:
      position: 101
      prefix: --amplicons
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    inputBinding:
      position: 101
      prefix: --debug
  - id: dir_list
    type:
      - 'null'
      - File
    doc: List of directories which include the required files, one on each line
    inputBinding:
      position: 101
      prefix: --dir_list
  - id: ph_list
    type:
      - 'null'
      - File
    doc: List of directories which include haplotype summary files, one on each 
      line
    inputBinding:
      position: 101
      prefix: --ph_list
  - id: sample_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories named in the dir_list file; staged writable by name because the
      tool indexes the BAM and writes depth files inside them
  - id: ph_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories named in the ph_list file (each holds ph_summary.txt)
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: Append console output to this file
    inputBinding:
      position: 102
      prefix: --logfile
  - id: outdir_path
    type: string
    doc: Output directory (must be given; the tool fails without it)
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name for log file (output)
    outputBinding:
      glob: $(inputs.logfile_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$([{entryname: inputs.outdir_path, entry: {class: 'Directory', listing: []}, writable: true}].concat((inputs.sample_dirs || []).concat(inputs.ph_dirs || []).map(function(d) { return {entry: d, writable: true}; })))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
