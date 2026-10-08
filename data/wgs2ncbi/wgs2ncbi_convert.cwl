cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgs2ncbi
  - convert
label: wgs2ncbi_convert
doc: "Converts the masked contigs and feature tables into ASN.1 using tbl2asn. tbl2asn returned exit status 1 in tests even though it wrote the files, so exit status 1 counts as success here.\n\nTool homepage: https://github.com/naturalis/wgs2ncbi"
inputs:
  - id: config_file
    type: File
    doc: "Configuration file (INI format). The files and directories it names are
      looked up relative to the working directory, so give plain names (for
      example template=template.sbt) and pass those files in input_files and
      input_dirs"
    inputBinding:
      position: 101
      prefix: -conf
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (template, info, products, masks,
      sequence file, annotation file, validation file); staged in the working
      directory under their own names
  - id: input_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories produced by earlier steps and named in the configuration
      file (for example tblfasta, gff3, asn1val); staged writable in the working
      directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: tblfasta_dir
    type:
      - 'null'
      - Directory
    doc: Sequence and feature table directory (datadir tblfasta in the example
      configuration)
    outputBinding:
      glob: tblfasta
  - id: gff3_dir
    type:
      - 'null'
      - Directory
    doc: Per-sequence annotation directory (gff3dir gff3 in the example
      configuration)
    outputBinding:
      glob: gff3
  - id: asn1val_dir
    type:
      - 'null'
      - Directory
    doc: ASN.1 and validation files directory (outdir asn1val in the example
      configuration)
    outputBinding:
      glob: asn1val
  - id: discrepancy_report
    type:
      - 'null'
      - File
    doc: Discrepancy report (discrep discrep.txt in the example configuration)
    outputBinding:
      glob: discrep.txt
  - id: archive
    type:
      - 'null'
      - File
    doc: Archive to upload to NCBI (archive out.tar.gz in the example
      configuration)
    outputBinding:
      glob: "*.tar.gz"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
      - entry: $(inputs.input_dirs)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
stdout: wgs2ncbi_convert.out
successCodes:
  - 0
  - 1
