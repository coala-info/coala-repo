cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, contacts, downsample]
label: pore-c_contacts_downsample
doc: "Downsample a contact table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: downsample_unit
    type:
      - 'null'
      - string
    doc: "Unit of the increments: Gb, Mb or Kb"
    inputBinding:
      position: 1
      prefix: --downsample-unit
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed"
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: tol
    type:
      - 'null'
      - float
    doc: "Check if the difference between the sampled amount and the target amount is greater than this proportion"
    inputBinding:
      position: 1
      prefix: --tol
  - id: warn
    type:
      - 'null'
      - boolean
    doc: "If a sample fails the --tol check print a warning rather than exiting"
    inputBinding:
      position: 1
      prefix: --warn
  - id: max_attempts
    type:
      - 'null'
      - int
    doc: "The number of times to try and find a set of subsamples all within --tol"
    inputBinding:
      position: 1
      prefix: --max-attempts
  - id: src_contact_table
    type: File
    doc: "Source contact table (parquet)"
    inputBinding:
      position: 10
  - id: dest_contact_table_prefix
    type: string
    doc: "Output prefix for the downsampled tables"
    inputBinding:
      position: 11
  - id: downsample_increments
    type:
      - 'null'
      - type: array
        items: int
    doc: "Amounts to sample, in the downsample unit"
    inputBinding:
      position: 12
outputs:
  - id: downsampled
    type:
      type: array
      items: File
    doc: "Downsampled contact tables"
    outputBinding:
      glob: "$(inputs.dest_contact_table_prefix)*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
