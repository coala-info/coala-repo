cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fmsi
  - union
label: fmsi_union
doc: "Compute the union of k-mers from several FMSI indices (experimental).\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: input_sets
    type:
      type: array
      items: File
      inputBinding:
        prefix: -p
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
    doc: Masked superstring files with their FMS indices beside them; at least two are required
    inputBinding:
      position: 1
  - id: result_path
    type: string
    doc: The path (prefix) where the resulting index is stored
    inputBinding:
      position: 2
      prefix: -r
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of queried k-mers (only used to check against the index one)
    inputBinding:
      position: 3
      prefix: -k
outputs:
  - id: result
    type: File
    doc: Empty placeholder file named like the result with the resulting FMS index files (<result>.fmsi.*) as secondary files; use it as the index input of the other fmsi commands
    outputBinding:
      glob: $(inputs.result_path)
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
      - entryname: $(inputs.result_path)
        entry: ""
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
