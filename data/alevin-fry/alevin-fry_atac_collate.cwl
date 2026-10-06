cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - atac
  - collate
label: alevin-fry_atac_collate
doc: "Collate a RAD file with corrected cell barcode\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: input_dir
    type: Directory
    doc: directory made by generate-permit-list (the result is written into it)
    inputBinding:
      position: 1
      prefix: --input-dir
  - id: rad_dir
    type: Directory
    doc: the directory containing the map.rad file which will be collated (typically produced as an output of the mapping)
    inputBinding:
      position: 1
      prefix: --rad-dir
  - id: threads
    type: ['null', int]
    doc: 'number of threads to use for processing [default: 16]'
    inputBinding:
      position: 1
      prefix: --threads
  - id: compress
    type: ['null', boolean]
    doc: compress the output collated RAD file
    inputBinding:
      position: 1
      prefix: --compress
  - id: max_records
    type: ['null', int]
    doc: 'the maximum number of read records to keep in memory at once [default: 30000000]'
    inputBinding:
      position: 1
      prefix: --max-records
outputs:
  - id: output_dir
    type: Directory
    doc: The generate-permit-list directory, now also holding map.collated.rad and collate.json
    outputBinding:
      glob: $(inputs.input_dir.basename)
  - id: collated_rad
    type: File
    doc: RAD file collated by corrected cell barcode
    outputBinding:
      glob: $(inputs.input_dir.basename)/map.collated.rad
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
