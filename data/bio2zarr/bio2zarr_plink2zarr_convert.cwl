cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plink2zarr
  - convert
label: bio2zarr_plink2zarr_convert
doc: "Convert plink fileset to VCF Zarr. Results are equivalent to `plink1.9 --bfile prefix --keep-allele-order --recode vcf-iid --out tmp` then running `vcf2zarr convert tmp.vcf zarr_path`\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: bed
    type: File
    doc: PLINK .bed file; the .bim and .fam files with the same prefix are 
      staged with it. The fileset prefix (IN_PATH) is passed to the tool.
    secondaryFiles:
      - pattern: ^.bim
      - pattern: ^.fam
    inputBinding:
      position: 10
      valueFrom: $(self.dirname)/$(self.nameroot)
  - id: zarr_path
    type: string
    doc: 'Output VCF Zarr directory'
    default: output.vcz
    inputBinding:
      position: 11
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwriting of existing directories'
    inputBinding:
      position: 1
      prefix: --force
  - id: worker_processes
    type:
      - 'null'
      - int
    doc: 'Number of worker processes  [default: 0]'
    inputBinding:
      position: 1
      prefix: --worker-processes
  - id: progress
    type:
      - 'null'
      - boolean
    doc: 'Show progress bars (default: show)'
    inputBinding:
      position: 1
      prefix: --progress
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: 'Do not show progress bars'
    inputBinding:
      position: 1
      prefix: --no-progress
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
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
outputs:
  - id: zarr
    type: Directory
    doc: 'Output VCF Zarr store'
    outputBinding:
      glob: $(inputs.zarr_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
