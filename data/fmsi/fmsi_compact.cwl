cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fmsi
  - compact
label: fmsi_compact
doc: "Compact the masked superstring of an FMSI index (experimental).\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of queried k-mers
    inputBinding:
      position: 1
      prefix: -k
  - id: only_superstring
    type:
      - 'null'
      - boolean
    doc: Only print the compacted masked superstring and do not compact the index
    inputBinding:
      position: 1
      prefix: -s
  - id: demasking_function
    type:
      - 'null'
      - string
    doc: 'Demasking function to determine k-mer presence: or (default), all, and, xor, INT-INT'
    inputBinding:
      position: 1
      prefix: -f
  - id: index_prefix
    type: File
    doc: Masked superstring file that was indexed with fmsi index (the index files sit beside it as <file>.fmsi.*)
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: The compacted masked superstring when -s is used
  - id: compacted_index
    type: File
    doc: The compacted index (<file>.fmsi.*) as secondary files of the indexed file
    outputBinding:
      glob: $(inputs.index_prefix.basename)
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_prefix)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_compact.out
