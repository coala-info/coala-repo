cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhpl8r filter
label: microhapulator_mhpl8r filter
doc: "Apply static and/or dynamic thresholds to distinguish true and false haplotypes.
  Thresholds are applied to the haplotype read counts of a raw typing result. Static
  integer thresholds are commonly used as detection thresholds, below which any haplotype
  count is considered noise. Dynamic thresholds are commonly used as analytical thresholds
  and represent a percentage of the total read count at the marker, after any haplotypes
  failing a static threshold are discarded.\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: result
    type: File
    doc: MicroHapulator typing result in JSON format
    inputBinding:
      position: 1
  - id: config_csv
    type:
      - 'null'
      - File
    doc: "CSV file specifying marker-specific thresholds to override global thresholds;
      three required columns: 'Marker' for the marker name; 'Static' and 'Dynamic'
      for marker-specific thresholds"
    inputBinding:
      position: 102
      prefix: --config
  - id: dynamic_threshold
    type:
      - 'null'
      - float
    doc: global percentage of total read count threshold; e.g. use 
      --dynamic=0.02 to apply a 2% analytical threshold
    inputBinding:
      position: 102
      prefix: --dynamic
  - id: static_threshold
    type:
      - 'null'
      - int
    doc: global fixed read count threshold
    inputBinding:
      position: 102
      prefix: --static
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output to FILE; by default, output is written to the terminal 
      (standard output)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
