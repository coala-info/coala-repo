cwlVersion: v1.2
class: CommandLineTool
baseCommand: validateManifest
label: ucsc-validatemanifest
doc: "Validates the ENCODE3 manifest.txt file. Calls validateFiles on each file in
  the manifest. Exits with a zero status for no errors detected and non-zero for errors.
  Writes the results to validated.txt in the working directory.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: manifest.txt
        entry: $(inputs.manifest)
      - $(inputs.data_files)
      - entryname: validated.txt
        entry: $(inputs.previous_validated)
        writable: true
      - entryname: '$(inputs.enc_val_data_dir ? inputs.enc_val_data_dir : "encValData")'
        entry: $(inputs.enc_val_data)
inputs:
  - id: manifest
    type: File
    doc: Input manifest file; it is staged as manifest.txt in the working directory.
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The data files named in the manifest, staged in the working directory.
  - id: previous_validated
    type:
      - 'null'
      - File
    doc: Output of a previous run of validateManifest; it is staged as validated.txt.
  - id: enc_val_data
    type:
      - 'null'
      - Directory
    doc: ENCODE validation data directory (chrom sizes, as files, 2bit); staged under the name given by enc_val_data_dir.
  - id: working_dir
    type:
      - 'null'
      - string
    doc: Working directory, defaults to the current directory.
    inputBinding:
      position: 1
      prefix: -dir=
      separate: false
  - id: enc_val_data_dir
    type:
      - 'null'
      - string
    doc: Name of the encValData directory, relative to the working directory, defaults to encValData.
    inputBinding:
      position: 1
      prefix: -encValData=
      separate: false
outputs:
  - id: log
    type: stdout
    doc: Messages about each manifest line.
  - id: validated
    type:
      - 'null'
      - File
    doc: Results of the validated input (validated.txt).
    outputBinding:
      glob: validated.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-validatemanifest:482--h0b57e2e_0
stdout: ucsc-validatemanifest.out
