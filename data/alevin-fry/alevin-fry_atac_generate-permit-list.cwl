cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - atac
  - generate-permit-list
label: alevin-fry_atac_generate-permit-list
doc: "Generate a permit list of barcodes from a whitelist file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: input
    type: Directory
    doc: input directory containing the map.rad file
    inputBinding:
      position: 1
      prefix: --input
  - id: output_dir
    type: string
    doc: output directory
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: threads
    type: ['null', int]
    doc: 'number of threads to use for the first phase of permit-list generation [default: 8]'
    inputBinding:
      position: 1
      prefix: --threads
  - id: unfiltered_pl
    type: File
    doc: uses an unfiltered external permit list
    inputBinding:
      position: 1
      prefix: --unfiltered-pl
  - id: min_reads
    type: ['null', int]
    doc: 'minimum read count threshold; only used with --unfiltered-pl [default: 10]'
    inputBinding:
      position: 1
      prefix: --min-reads
  - id: permit_bc_ori
    type: ['null', {type: enum, symbols: [fw, rc]}]
    doc: 'the expected orientation of barcodes in the permit list [default: rc]'
    inputBinding:
      position: 1
      prefix: --permit-bc-ori
outputs:
  - id: permit_list_dir
    type: Directory
    doc: Output directory with the permit list (permit_freq.bin, permit_map.bin, bin_recs.bin, bin_lens.bin, generate_permit_list.json)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
