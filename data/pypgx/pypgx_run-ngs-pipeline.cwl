cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - run-ngs-pipeline
label: pypgx_run-ngs-pipeline
doc: "Run genotyping pipeline for NGS data.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 103
      prefix: --assembly
  - id: cnv_caller
    type:
      - 'null'
      - File
    doc: Archive file with the semantic type Model[CNV]. By default, a 
      pre-trained CNV caller in the pypgx-bundle directory will be used.
    inputBinding:
      position: 103
      prefix: --cnv-caller
  - id: control_statistics
    type:
      - 'null'
      - File
    doc: Archive file with the semantic type SampleTable[Statistics].
    inputBinding:
      position: 103
      prefix: --control-statistics
  - id: depth_of_coverage
    type:
      - 'null'
      - File
    doc: Archive file with the semantic type CovFrame[DepthOfCoverage].
    inputBinding:
      position: 103
      prefix: --depth-of-coverage
  - id: do_not_plot_allele_fraction
    type:
      - 'null'
      - boolean
    doc: Do not plot allele fraction profile.
    inputBinding:
      position: 103
      prefix: --do-not-plot-allele-fraction
  - id: do_not_plot_copy_number
    type:
      - 'null'
      - boolean
    doc: Do not plot copy number profile.
    inputBinding:
      position: 103
      prefix: --do-not-plot-copy-number
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 103
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it already exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: panel
    type:
      - 'null'
      - File
    doc: VCF file corresponding to a reference haplotype panel (compressed or 
      uncompressed). By default, the 1KGP panel in the pypgx-bundle directory 
      will be used.
    inputBinding:
      position: 103
      prefix: --panel
  - id: platform
    type:
      - 'null'
      - string
    doc: "Genotyping platform (default: 'WGS') (choices: 'WGS', 'Targeted')"
    inputBinding:
      position: 103
      prefix: --platform
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 103
      prefix: --samples
  - id: samples_without_sv
    type:
      - 'null'
      - type: array
        items: string
    doc: List of known samples without SV.
    inputBinding:
      position: 103
      prefix: --samples-without-sv
  - id: variants
    type:
      - 'null'
      - File
    doc: Input VCF file must be already BGZF compressed (.gz) and indexed (.tbi)
      to allow random access. Statistical haplotype phasing will be skipped if 
      input VCF is already fully phased.
    inputBinding:
      position: 103
      prefix: --variants
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_run-ngs-pipeline.out
