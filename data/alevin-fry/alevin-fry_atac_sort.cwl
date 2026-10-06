cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - atac
  - sort
label: alevin-fry_atac_sort
doc: "Produce coordinate sorted bed file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: input_dir
    type: Directory
    doc: directory made by generate-permit-list (the result is written into it)
    inputBinding:
      position: 1
      prefix: --input-dir
  - id: rad_dir
    type: Directory
    doc: the directory containing the map.rad file which will be sorted (typically produced as an output of the mapping)
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
    doc: compress the output of the sorted RAD file
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
    doc: The generate-permit-list directory, now also holding the sorted map.bed and sort.json
    outputBinding:
      glob: $(inputs.input_dir.basename)
  - id: bed
    type: File
    doc: Coordinate sorted BED file of fragments (chrom, start, end, barcode, count)
    outputBinding:
      glob: $(inputs.input_dir.basename)/map.bed*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
