cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bcftools, plugin, filter_snv_density]
label: bcftools-snvphyl-plugin_filter_snv_density
doc: "A plugin which filters on freebayes for SNV's deemed to be within high density regions of the genome;\
  \ writes the high-density regions to a file.\n\nTool homepage: https://github.com/phac-nml/snvphyl-tools"
inputs:
  - id: input_vcf
    type: File
    doc: input VCF/BCF file (sorted by position)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 10
  - id: exclude
    type:
      - 'null'
      - string
    doc: exclude sites for which the expression is true
    inputBinding:
      position: 1
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: select sites for which the expression is true
    inputBinding:
      position: 1
      prefix: --include
  - id: regions
    type:
      - 'null'
      - string
    doc: restrict to comma-separated list of regions (needs an indexed input)
    inputBinding:
      position: 1
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: restrict to regions listed in a file
    inputBinding:
      position: 1
      prefix: --regions-file
  - id: targets
    type:
      - 'null'
      - string
    doc: similar to --regions but streams rather than index-jumps
    inputBinding:
      position: 1
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: similar to --regions-file but streams rather than index-jumps
    inputBinding:
      position: 1
      prefix: --targets-file
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: do not append version and command line to the header
    inputBinding:
      position: 1
      prefix: --no-version
  - id: output
    type: string
    doc: output file name for the passed-through records
    inputBinding:
      position: 1
      prefix: --output
    default: filtered.vcf
  - id: output_type
    type:
      - 'null'
      - type: enum
        symbols:
          - b
          - u
          - z
          - v
    doc: '''b'' compressed BCF; ''u'' uncompressed BCF; ''z'' compressed VCF; ''v'' uncompressed VCF [v]'
    inputBinding:
      position: 1
      prefix: --output-type
  - id: threads
    type:
      - 'null'
      - int
    doc: number of extra output compression threads [0]
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: filename
    type:
      - 'null'
      - File
    doc: 'plugin option: input VCF file name (stored by the plugin, not otherwise used)'
    inputBinding:
      position: 21
      prefix: --filename
  - id: region_file
    type: string
    doc: 'plugin option: output file for high-density regions (<chrom> <start> <end>)'
    inputBinding:
      position: 22
      prefix: --region_file
    default: density_regions.tsv
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'plugin option: window size in bases [100]; set threshold too, the plugin also copies this value
      into the threshold'
    inputBinding:
      position: 23
      prefix: --window_size
  - id: threshold
    type:
      - 'null'
      - int
    doc: 'plugin option: number of SNVs in a window that marks a high-density region [10]'
    inputBinding:
      position: 24
      prefix: --threshold
outputs:
  - id: output_variants
    type: File
    doc: Input records passed through (VCF/BCF)
    outputBinding:
      glob: $(inputs.output)
  - id: density_regions
    type:
      - 'null'
      - File
    doc: High-density regions found (tab-separated chrom, start, end)
    outputBinding:
      glob: $(inputs.region_file)
arguments:
  - position: 20
    valueFrom: --
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h4da6232_0
