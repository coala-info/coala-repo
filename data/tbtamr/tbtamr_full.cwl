cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbtamr
  - full
label: tbtamr_full
doc: "Predict AMR results from reads or vcf\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: seq_id
    type:
      - 'null'
      - string
    doc: 'Sequence name (default tbtamr). The output folder has this name.'
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'VCF file generated using the H37rV v3 reference genome'
    inputBinding:
      position: 101
      prefix: --vcf
  - id: read1
    type:
      - 'null'
      - File
    doc: 'Path to read 1 - not required if vcf is supplied'
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Path to read 2 - not required if vcf is supplied'
    inputBinding:
      position: 101
      prefix: --read2
  - id: catalog
    type:
      - 'null'
      - File
    doc: 'csv variant catalog (default is the WHO v2 catalog in the image)'
    inputBinding:
      position: 101
      prefix: --catalog
  - id: catalog_config
    type:
      - 'null'
      - File
    doc: 'json file indicating the relevant column settings for interpretation of the catalog file'
    inputBinding:
      position: 101
      prefix: --catalog_config
  - id: interpretation_criteria
    type:
      - 'null'
      - File
    doc: 'csv file with rules for predicting resistance profiles from genomic data'
    inputBinding:
      position: 101
      prefix: --interpretation_criteria
  - id: barcode
    type:
      - 'null'
      - File
    doc: 'Barcode to use for lineage calling and speciation'
    inputBinding:
      position: 101
      prefix: --barcode
  - id: reference_file
    type:
      - 'null'
      - File
    doc: 'Reference file to use for calling lineage'
    inputBinding:
      position: 101
      prefix: --reference_file
  - id: classification_criteria
    type:
      - 'null'
      - File
    doc: 'csv file with rules for predicting resistance profiles from genomic data'
    inputBinding:
      position: 101
      prefix: --classification_criteria
  - id: call_lineage
    type:
      - 'null'
      - boolean
    doc: 'Use pathogen profiler to call lineage'
    inputBinding:
      position: 101
      prefix: --call_lineage
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum depth to call a variant - only required if reads supplied as input (default 20)'
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_frac
    type:
      - 'null'
      - float
    doc: 'Minimum proportion to call a variant (0-1) - only required if reads supplied as input (default 0.1)'
    inputBinding:
      position: 101
      prefix: --min_frac
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads to use for generation of vcf file (default 8)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: ram
    type:
      - 'null'
      - int
    doc: 'Max ram to use (default 8)'
    inputBinding:
      position: 101
      prefix: --ram
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Keep accessory files generated from alignment for further use.'
    inputBinding:
      position: 101
      prefix: --keep
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force replace an existing folder.'
    inputBinding:
      position: 101
      prefix: --force
  - id: cascade
    type:
      - 'null'
      - boolean
    doc: 'If you would like to apply cascade reporting structure.'
    inputBinding:
      position: 101
      prefix: --cascade
  - id: tmp
    type:
      - 'null'
      - string
    doc: 'temp directory to use (default /tmp)'
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: Output folder named after the sequence id (reports, variants, logs)
    outputBinding:
      glob: $(inputs.seq_id || 'tbtamr')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_full.out
