cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - predict_haplo
label: haphpipe_predict_haplo
doc: "Predict haplotypes for a given region.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    inputBinding:
      position: 101
      prefix: --debug
  - id: fq1
    type: File
    doc: Fastq file with read 1
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type: File
    doc: Fastq file with read 2
    inputBinding:
      position: 101
      prefix: --fq2
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary directory
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: min_readlength
    type:
      - 'null'
      - int
    doc: Minimum readlength passed to PredictHaplo
    inputBinding:
      position: 101
      prefix: --min_readlength
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref_fa
    type: File
    doc: Reference sequence used to align reads (fasta)
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: region_txt
    type:
      - 'null'
      - File
    doc: 'File with regions to perform haplotype reconstruction. Regions should be
      specified using the samtools region specification format: RNAME[:STARTPOS[-ENDPOS]]'
    inputBinding:
      position: 101
      prefix: --region_txt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_predict_haplo.out
