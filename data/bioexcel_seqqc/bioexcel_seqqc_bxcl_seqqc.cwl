cwlVersion: v1.2
class: CommandLineTool
baseCommand: bxcl_seqqc
label: bioexcel_seqqc_bxcl_seqqc
doc: "This script performs the Sequence Quality Control step of the Cancer Genome
  Variant pipeline.\n\nTool homepage: https://github.com/bioexcel/bioexcel_seqqc"
inputs:
  - id: adaptseq
    type:
      - 'null'
      - string
    doc: The adapter sequence to be trimmed from the FastQ file.
    inputBinding:
      position: 101
      prefix: --adaptseq
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Pair of input FastQ files.
    inputBinding:
      position: 101
      prefix: --files
  - id: printconfig
    type:
      - 'null'
      - boolean
    doc: Print example config files to current directory.
    inputBinding:
      position: 101
      prefix: --printconfig
  - id: qcconf
    type:
      - 'null'
      - File
    doc: Location of config file.
    inputBinding:
      position: 101
      prefix: --qcconf
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Max number of threads to use. NOTE: not allstages use all threads.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temp directory.
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: trim
    type:
      - 'null'
      - string
    doc: 'The type of trimming to be done on the paired sequences: [A]dapter or [Q]uality
      trimming, or [F]ull/both. WARNING: For standalone execution of runtrim only!'
    inputBinding:
      position: 101
      prefix: --trim
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioexcel_seqqc:0.6--py_0
