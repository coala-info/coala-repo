cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fmsi
  - index
label: fmsi_index
doc: "Index a masked superstring for fmsi.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: masked_superstring_input
    type: File
    doc: Path to the masked superstring
    inputBinding:
      position: 200
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of k-mers
    inputBinding:
      position: 102
      prefix: -k
  - id: no_klcp
    type:
      - 'null'
      - boolean
    doc: do not compute the kLCP array used for faster streaming queries.
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index
    type: File
    doc: The masked superstring with its FMS index files (<file>.fmsi.*) as secondary files
    outputBinding:
      glob: $(inputs.masked_superstring_input.basename)
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.masked_superstring_input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_index.out
