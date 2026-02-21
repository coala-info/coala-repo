cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - generate-permit-list
label: alevin-fry_generate-permit-list
doc: "Generate a permit list of barcodes from a RAD file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: expect_cells
    type:
      - 'null'
      - int
    doc: defines the expected number of cells to use in determining the (read, not
      UMI) based cutoff
    inputBinding:
      position: 101
      prefix: --expect-cells
  - id: expected_ori
    type: string
    doc: 'the expected orientation of alignments [possible values: fw, rc, both, either]'
    inputBinding:
      position: 101
      prefix: --expected-ori
  - id: force_cells
    type:
      - 'null'
      - int
    doc: select the top-k most-frequent barcodes, based on read count, as valid (true)
    inputBinding:
      position: 101
      prefix: --force-cells
  - id: input
    type: Directory
    doc: input directory containing the map.rad RAD file
    inputBinding:
      position: 101
      prefix: --input
  - id: knee_distance
    type:
      - 'null'
      - boolean
    doc: attempt to determine the number of barcodes to keep using the knee distance
      method.
    inputBinding:
      position: 101
      prefix: --knee-distance
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum read count threshold; only used with --unfiltered-pl
    default: 10
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for the first phase of permit-list generation
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
  - id: unfiltered_pl
    type:
      - 'null'
      - File
    doc: uses an unfiltered external permit list
    inputBinding:
      position: 101
      prefix: --unfiltered-pl
  - id: valid_bc
    type:
      - 'null'
      - File
    doc: uses true barcode collected from a provided file
    inputBinding:
      position: 101
      prefix: --valid-bc
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
