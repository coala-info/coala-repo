cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rhocall
  - viz
label: rhocall_viz
doc: "Plot binned zygosity and RHO-regions.\n\nTool homepage: https://github.com/dnil/rhocall"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: allele_frequency_tag
    type:
      - 'null'
      - string
    doc: The allele frequency tag to use.
    inputBinding:
      position: 102
      prefix: --aftag
  - id: filter_variants
    type:
      - 'null'
      - boolean
    doc: include variants, even if they are not labeled PASS
    inputBinding:
      position: 102
      prefix: --filter
  - id: include_mnv
    type:
      - 'null'
      - boolean
    doc: Include MNV
    inputBinding:
      position: 102
      prefix: --mnv
  - id: max_allele_frequency
    type:
      - 'null'
      - float
    doc: Maximum allele frequency
    inputBinding:
      position: 102
      prefix: --maxaf
  - id: max_snv
    type:
      - 'null'
      - int
    doc: Maximum number of snvs for each plotted bin
    inputBinding:
      position: 102
      prefix: --maxsnv
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: Minimum allele frequency. This variable must be set to 0 if the allele 
      frequency is not annotated.
    inputBinding:
      position: 102
      prefix: --minaf
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Do not add SNVs to a bin if their quality is less than this value.
    inputBinding:
      position: 102
      prefix: --minqual
  - id: min_snv
    type:
      - 'null'
      - int
    doc: Minimum number of snvs for each plotted bin
    inputBinding:
      position: 102
      prefix: --minsnv
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Do not include variants if they are not labeled PASS
    inputBinding:
      position: 102
      prefix: --no-filter
  - id: no_mnv
    type:
      - 'null'
      - boolean
    doc: Do not include MNV
    inputBinding:
      position: 102
      prefix: --no-mnv
  - id: no_rsid
    type:
      - 'null'
      - boolean
    doc: Do not skip variants not containing an rsid
    inputBinding:
      position: 102
      prefix: --no-rsid
  - id: no_wig
    type:
      - 'null'
      - boolean
    doc: Do not produce wig file.
    inputBinding:
      position: 102
      prefix: --no-wig
  - id: pointsize
    type:
      - 'null'
      - int
    doc: Size of the points (pixels)
    inputBinding:
      position: 102
      prefix: --pointsize
  - id: produce_wig
    type:
      - 'null'
      - boolean
    doc: Produce wig file.
    inputBinding:
      position: 102
      prefix: --wig
  - id: rho_file
    type: File
    doc: Input RHO file produced from rhocall
    inputBinding:
      position: 102
      prefix: --rho
  - id: skip_no_rsid
    type:
      - 'null'
      - boolean
    doc: Skip variants not containing an rsid
    inputBinding:
      position: 102
      prefix: --rsid
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (bases)
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory. The files will be named out_dir/chr.png. One picture 
      is drawn per chromosome.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
