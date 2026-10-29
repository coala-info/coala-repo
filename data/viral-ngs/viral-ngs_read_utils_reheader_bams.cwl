cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - reheader_bams
label: viral-ngs_read_utils_reheader_bams
doc: "Copy BAM files while renaming elements of the BAM header. The mapping file specifies which (key, old value, new value) mappings. For example: LB lib1 lib_one SM sample1 Sample_1 SM sample2 Sample_2 SM sample3 Sample_3 CN broad BI FN in1.bam out1.bam FN in2.bam out2.bam\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: rg_map
    type: File
    doc: "Tabular file containing three columns: field, old, new. FN rows name the input and output bam files."
    inputBinding:
      position: 1
  - id: in_bams
    type:
      type: array
      items: File
    doc: "Input bam files named in the FN rows of rgMap, staged in the working directory so that the names resolve."
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_bams
    type:
      type: array
      items: File
    doc: Renamed output bam files (the new names listed in the FN rows of rgMap)
    outputBinding:
      glob: '*.bam'
      outputEval: |
        ${
          var ins = inputs.in_bams.map(function(f) { return f.basename; });
          return self.filter(function(f) { return ins.indexOf(f.basename) < 0; });
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_bams)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_reheader_bams.out
