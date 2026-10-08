cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - prepare-polishing
label: polap_prepare-polishing
doc: "Prepare short-read polishing with FMLRC (builds the short-read index used by polish).\n\
  \nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: short_read1
    type: File
    doc: Short-read FASTQ file 1.
    inputBinding:
      position: 101
      prefix: -a
  - id: short_read2
    type:
      - 'null'
      - File
    doc: Short-read FASTQ file 2.
    inputBinding:
      position: 101
      prefix: -b
  - id: outdir
    type: string
    doc: Output folder name.
    default: o
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_prepare-polishing.out
