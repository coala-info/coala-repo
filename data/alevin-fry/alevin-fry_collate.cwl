cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - collate
label: alevin-fry_collate
doc: "Collate a RAD file by corrected cell barcode\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: compress the output collated RAD file
    inputBinding:
      position: 101
      prefix: --compress
  - id: input_dir
    type: Directory
    doc: input directory made by generate-permit-list
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: max_records
    type:
      - 'null'
      - int
    doc: the maximum number of read records to keep in memory at once
    inputBinding:
      position: 101
      prefix: --max-records
  - id: rad_dir
    type: Directory
    doc: the directory containing the RAD file to be collated
    inputBinding:
      position: 101
      prefix: --rad-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: The generate-permit-list directory, now holding the collated RAD file
      (map.collated.rad) and collate.json
    outputBinding:
      glob: $(inputs.input_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
stdout: alevin-fry_collate.out
