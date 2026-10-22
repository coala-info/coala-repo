cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_svdss
label: svdss_run_svdss
doc: "Run SVDSS for structural variant detection.\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs:
  - id: reference_fa
    type: File
    secondaryFiles:
      - .fai
    doc: reference file in FASTA format (with its .fai index; the script cannot write one next to a staged reference)
    inputBinding:
      position: 201
  - id: alignments_bam
    type: File
    secondaryFiles:
      - .bai?
    doc: alignments in BAM format
    inputBinding:
      position: 202
  - id: accuracy_percentile
    type:
      - 'null'
      - float
    doc: accuracy percentile
    inputBinding:
      position: 103
      prefix: -p
  - id: fmd_index
    type:
      - 'null'
      - File
      - string
    doc: use this FMD index/store it here (give an existing File to reuse it, or a
      new file name to build and store the index there; by default the index is
      written next to the reference)
    inputBinding:
      position: 103
      prefix: -i
  - id: kanpig_binary
    type:
      - 'null'
      - File
    doc: path to kanpig binary
    inputBinding:
      position: 103
      prefix: -k
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality
    inputBinding:
      position: 103
      prefix: -q
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum support for calling
    inputBinding:
      position: 103
      prefix: -s
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: minimum length for SV
    inputBinding:
      position: 103
      prefix: -l
  - id: no_haplotagging
    type:
      - 'null'
      - boolean
    doc: do not consider haplotagging information
    inputBinding:
      position: 103
      prefix: -t
  - id: output_dir
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 103
      prefix: -w
  - id: svdss_binary
    type:
      - 'null'
      - File
    doc: path to SVDSS binary
    inputBinding:
      position: 103
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -@
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: final_vcf
    type:
      - 'null'
      - File
    doc: Final genotyped SV calls (variations-final.vcf.gz), when no output directory is given.
    secondaryFiles:
      - .tbi?
    outputBinding:
      glob: variations-final.vcf.gz
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: svdss_run_svdss.out
