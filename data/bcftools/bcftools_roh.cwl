cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - roh
label: bcftools_roh
doc: "HMM model for detecting runs of autozygosity.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file (in.vcf.gz)
    inputBinding:
      position: 1
  - id: af_dflt
    type:
      - 'null'
      - float
    doc: If AF is not known, use this allele frequency
    inputBinding:
      position: 102
      prefix: --AF-dflt
  - id: af_file
    type:
      - 'null'
      - File
    doc: read allele frequencies from file (CHR\tPOS\tREF,ALT\tAF)
    inputBinding:
      position: 102
      prefix: --AF-file
  - id: af_tag
    type:
      - 'null'
      - string
    doc: Use TAG for allele frequency
    inputBinding:
      position: 102
      prefix: --AF-tag
  - id: az_to_hw
    type:
      - 'null'
      - float
    doc: P(HW|AZ) transition probability from AZ to HW state
    default: 5e-09
    inputBinding:
      position: 102
      prefix: --az-to-hw
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: Buffer size and the number of overlapping sites, 0 for unlimited. If 
      negative, interpreted as max memory in MB.
    default: '0'
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: estimate_af
    type:
      - 'null'
      - string
    doc: Estimate AF from FORMAT/TAG (GT or PL) of all samples ("-") or samples 
      listed in FILE.
    inputBinding:
      position: 102
      prefix: --estimate-AF
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: genetic_map
    type:
      - 'null'
      - File
    doc: Genetic map in IMPUTE2 format, single file or mask
    inputBinding:
      position: 102
      prefix: --genetic-map
  - id: gts_only
    type:
      - 'null'
      - float
    doc: Use GTs and ignore PLs, instead using FLOAT for PL of the two least 
      likely genotypes.
    inputBinding:
      position: 102
      prefix: --GTs-only
  - id: hw_to_az
    type:
      - 'null'
      - float
    doc: P(AZ|HW) transition probability from HW (Hardy-Weinberg) to AZ 
      (autozygous) state
    default: 6.7e-08
    inputBinding:
      position: 102
      prefix: --hw-to-az
  - id: ignore_homref
    type:
      - 'null'
      - boolean
    doc: Skip hom-ref genotypes (0/0)
    inputBinding:
      position: 102
      prefix: --ignore-homref
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: include_noalt
    type:
      - 'null'
      - boolean
    doc: Include sites with no ALT allele (ignored by default)
    inputBinding:
      position: 102
      prefix: --include-noalt
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output s:per-site, r:regions, z:compressed
    default: sr
    inputBinding:
      position: 102
      prefix: --output-type
  - id: rec_rate
    type:
      - 'null'
      - float
    doc: Constant recombination rate per bp
    inputBinding:
      position: 102
      prefix: --rec-rate
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
    doc: include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: samples
    type:
      - 'null'
      - string
    doc: List of samples to analyze
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to analyze
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: skip_indels
    type:
      - 'null'
      - boolean
    doc: Skip indels as their genotypes are enriched for errors
    inputBinding:
      position: 102
      prefix: --skip-indels
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with <int> worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: viterbi_training
    type:
      - 'null'
      - float
    doc: Estimate HMM parameters, FLOAT is the convergence threshold
    inputBinding:
      position: 102
      prefix: --viterbi-training
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
