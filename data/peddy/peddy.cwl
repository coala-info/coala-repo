cwlVersion: v1.2
class: CommandLineTool
baseCommand: peddy
label: peddy
doc: "Pleasingly pythonic pedigree manipulation: check relatedness, sex and ancestry\n
  of samples in a VCF against a PED file.\n\nTool homepage: https://github.com/brentp/peddy"
inputs:
  - id: vcf
    type: File
    doc: Multi-sample VCF (bgzipped and tabix-indexed)
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 1
  - id: ped
    type: File
    doc: Pedigree (PED) file
    inputBinding:
      position: 2
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Make plots
    inputBinding:
      position: 101
      prefix: --plot
  - id: procs
    type:
      - 'null'
      - int
    doc: number of processors to use
    inputBinding:
      position: 101
      prefix: --procs
  - id: prefix
    type: string
    default: peddy
    doc: prefix for output files (default is basename of vcf; here peddy)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: each
    type:
      - 'null'
      - int
    doc: sample every nth value from the selected sites instead of every value to
      speed processing.
    inputBinding:
      position: 101
      prefix: --each
  - id: sites
    type:
      - 'null'
      - File
    doc: "The path to a file with alternative sites to use for calculating relatedness
      in format 1:234234 1:45345345... with chrom:pos[:ref:alt] on each line. The
      special-case of 'hg38' for this will use hg38 sites shipped with peddy."
    inputBinding:
      position: 101
      prefix: --sites
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
    doc: Set the level of log output.
    inputBinding:
      position: 101
      prefix: --loglevel
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files (<prefix>.peddy.ped, <prefix>.*_check.csv, <prefix>.html, plots)
    outputBinding:
      glob: $(inputs.prefix).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peddy:0.4.8--pyh5e36f6f_0
