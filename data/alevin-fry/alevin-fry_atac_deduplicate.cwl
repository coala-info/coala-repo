cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - atac
  - deduplicate
label: alevin-fry_atac_deduplicate
doc: "Deduplicate the RAD file and output a BED file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: input_dir
    type: Directory
    doc: input directory made by generate-permit-list that also contains the output of collate
    inputBinding:
      position: 1
      prefix: --input-dir
  - id: threads
    type: ['null', int]
    doc: 'number of threads to use for processing [default: 20]'
    inputBinding:
      position: 1
      prefix: --threads
  - id: permit_bc_ori
    type: ['null', {type: enum, symbols: [fw, rc]}]
    doc: 'the expected orientation of barcodes in the permit list [default: rc]'
    inputBinding:
      position: 1
      prefix: --permit-bc-ori
outputs:
  - id: output_dir
    type: Directory
    doc: The input directory, now also holding the deduplicated map.bed
    outputBinding:
      glob: $(inputs.input_dir.basename)
  - id: bed
    type: File
    doc: Deduplicated BED file of fragments
    outputBinding:
      glob: $(inputs.input_dir.basename)/map.bed
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
