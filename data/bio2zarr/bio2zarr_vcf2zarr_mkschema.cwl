cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - mkschema
label: bio2zarr_vcf2zarr_mkschema
doc: "Generate a schema for zarr encoding\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: icf
    type: Directory
    doc: Intermediate columnar format (ICF) directory made by explode
    inputBinding:
      position: 10
  - id: variants_chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size in the variants dimension'
    inputBinding:
      position: 1
      prefix: --variants-chunk-size
  - id: samples_chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size in the samples dimension'
    inputBinding:
      position: 1
      prefix: --samples-chunk-size
  - id: local_alleles
    type:
      - 'null'
      - boolean
    doc: 'Use local allele fields to reduce the storage requirements of the output. [default: no-local-alleles]'
    inputBinding:
      position: 1
      prefix: --local-alleles
  - id: no_local_alleles
    type:
      - 'null'
      - boolean
    doc: 'Do not use local allele fields (default)'
    inputBinding:
      position: 1
      prefix: --no-local-alleles
outputs:
  - id: schema
    type: stdout
    doc: JSON schema for zarr encoding
stdout: $(inputs.icf.basename).schema.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
