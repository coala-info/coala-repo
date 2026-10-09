cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - /usr/local/bin/longQC.py
  - runqc
label: longqc_runqc
doc: "LongQC runqc - quality control of a whole sequencing run from the raw data folder of a PacBio (rs2, sequel) or Nanopore (minion, gridion) run. The longQC.py script in the image has no shebang line, so it is run through python.\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs:
  - id: platform
    type: string
    doc: a platform to be evaluated. [rs2, sequel, minion, gridion]
    inputBinding:
      position: 100
  - id: raw_data_dir
    type: Directory
    doc: a path for a dir containing the raw data
    inputBinding:
      position: 101
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix for each output file.
    inputBinding:
      position: 1
      prefix: --suffix
  - id: output_dir
    type: string
    doc: path for output directory
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: Output directory with the run QC report.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc_runqc.out
