cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpsbproc
label: rpsbproc
doc: "This utility processes domain hit data produced by local RPS-BLAST and generates
  domain family and/or superfamily annotations on the query sequences. Instead of
  retrieving domain data from database, this program processes dumped datafiles to
  obtain required information. All data files are downloadable from NCBI ftp site.
  Read README file for details\n\nTool homepage: https://ftp.ncbi.nih.gov/pub/mmdb/cdd/rpsbproc/README"
inputs:
  - id: conffile
    type:
      - 'null'
      - File
    doc: Program's configuration (registry) data file
    inputBinding:
      position: 101
  - id: data_mode
    type:
      - 'null'
      - string
    doc: Select redundancy level of domain hit data. Valid options are "rep" 
      (concise), "std"(standard) and "full" (all hits). Default to "rep"
    inputBinding:
      position: 101
      prefix: --data-mode
  - id: data_path
    type:
      - 'null'
      - string
    doc: Specify directory that contains data files. By default, the program 
      will look in 'data' directory in current directory and the directory where
      the program is located
    inputBinding:
      position: 101
      prefix: --data-path
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: 'Dry run the application: do nothing, only test all preconditions'
    inputBinding:
      position: 101
  - id: evalue
    type:
      - 'null'
      - float
    doc: EValue cut-off. Program will only process hits with evalues better than
      this value.
    inputBinding:
      position: 101
      prefix: --evalue
  - id: infile
    type:
      - 'null'
      - string
    doc: Input file(s) that holds asn data produced by rpsblast with "-outfmt 
      11" switch. If omitted, default to stdin.
    inputBinding:
      position: 101
      prefix: --infile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode -- do not display program information and progress on stderr
    inputBinding:
      position: 101
      prefix: -q
  - id: show_families
    type:
      - 'null'
      - boolean
    doc: When specified, show corresponding superfamily information for domain 
      hits.
    inputBinding:
      position: 101
      prefix: -f
  - id: target_data
    type:
      - 'null'
      - string
    doc: 'Target data: Select desired (target) data. Valid options are "doms", "feats"
      or "both". . If omitted, default to "both"'
    inputBinding:
      position: 101
      prefix: --target-data
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file to write the processed result. If omitted, default to 
      stdout.
    outputBinding:
      glob: $(inputs.outfile)
  - id: logfile
    type:
      - 'null'
      - File
    doc: File to which the program log should be redirected
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpsbproc:0.5.1--hd6d6fdc_0
