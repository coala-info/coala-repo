cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - happy
  - coverage
label: happy-python_coverage
doc: "Compute coverage histogram for a mapping file.\n\nTool homepage: https://github.com/AntoineHo/HapPy"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of parallel threads allocated for sambamba [default: 1]."
    inputBinding:
      position: 1
      prefix: --threads
  - id: outdir
    type: string
    doc: "Path where the .cov and .hist files are written."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: mapping_bam
    type: File
    secondaryFiles:
      - .bai
    doc: "Sorted BAM file after mapping reads to the assembly."
    inputBinding:
      position: 2
outputs:
  - id: outdir_out
    type: Directory
    doc: "Directory with the .cov and .hist files"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
