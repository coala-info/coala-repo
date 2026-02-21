cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - polysomy
label: bcftools_polysomy
doc: "Detect number of chromosomal copies from Illumina's B-allele frequency (BAF)\n\
  \nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: cn_penalty
    type:
      - 'null'
      - float
    doc: Penalty for increasing CN (0-1, larger is stricter)
    default: 0.7
    inputBinding:
      position: 102
      prefix: --cn-penalty
  - id: fit_th
    type:
      - 'null'
      - float
    doc: Goodness of fit threshold (>0, smaller is stricter)
    default: 3.3
    inputBinding:
      position: 102
      prefix: --fit-th
  - id: include_aa
    type:
      - 'null'
      - boolean
    doc: Include the AA peak in CN2 and CN3 evaluation
    inputBinding:
      position: 102
      prefix: --include-aa
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minimum distinguishable fraction of aberrant cells
    default: 0.1
    inputBinding:
      position: 102
      prefix: --min-fraction
  - id: peak_size
    type:
      - 'null'
      - float
    doc: Minimum peak size (0-1, larger is stricter)
    default: 0.1
    inputBinding:
      position: 102
      prefix: --peak-size
  - id: peak_symmetry
    type:
      - 'null'
      - float
    doc: Peak symmetry threshold (0-1, larger is stricter)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --peak-symmetry
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample to analyze
    inputBinding:
      position: 102
      prefix: --sample
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 0
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
