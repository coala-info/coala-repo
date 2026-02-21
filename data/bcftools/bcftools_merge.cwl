cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - merge
label: bcftools_merge
doc: "Merge multiple VCF/BCF files from non-overlapping sample sets to create one
  multi-sample file. Note that only records from different files can be merged, never
  from the same file.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input VCF/BCF files to be merged
    inputBinding:
      position: 1
  - id: apply_filters
    type:
      - 'null'
      - string
    doc: Require at least one of the listed FILTER strings (e.g. "PASS,.")
    inputBinding:
      position: 102
      prefix: --apply-filters
  - id: file_list
    type:
      - 'null'
      - File
    doc: Read file names from the file
    inputBinding:
      position: 102
      prefix: --file-list
  - id: filter_logic
    type:
      - 'null'
      - string
    doc: Remove filters if some input is PASS ("x"), or apply all filters ("+")
    default: +
    inputBinding:
      position: 102
      prefix: --filter-logic
  - id: force_no_index
    type:
      - 'null'
      - boolean
    doc: Merge unindexed files, synonymous to --no-index
    inputBinding:
      position: 102
      prefix: --force-no-index
  - id: force_samples
    type:
      - 'null'
      - boolean
    doc: Resolve duplicate sample names
    inputBinding:
      position: 102
      prefix: --force-samples
  - id: force_single
    type:
      - 'null'
      - boolean
    doc: Run even if there is only one file on input
    inputBinding:
      position: 102
      prefix: --force-single
  - id: gvcf
    type:
      - 'null'
      - string
    doc: Merge gVCF blocks, INFO/END tag is expected. Implies specific -i and -M
      rules.
    inputBinding:
      position: 102
      prefix: --gvcf
  - id: info_rules
    type:
      - 'null'
      - string
    doc: Rules for merging INFO fields (method is one of sum,avg,min,max,join) 
      or "-" to turn off the default
    default: DP:sum,DP4:sum
    inputBinding:
      position: 102
      prefix: --info-rules
  - id: local_alleles
    type:
      - 'null'
      - int
    doc: If more than INT alt alleles are encountered, drop FMT/PL and output 
      LAA+LPL instead; 0=unlimited
    default: 0
    inputBinding:
      position: 102
      prefix: --local-alleles
  - id: merge
    type:
      - 'null'
      - string
    doc: Allow multiallelic records for 
      snps,indels,both,snp-ins-del,all,none,id,*,**
    default: both
    inputBinding:
      position: 102
      prefix: --merge
  - id: missing_rules
    type:
      - 'null'
      - string
    doc: Rules for replacing missing values in numeric vectors (.,0,max) when 
      unknown allele <*> is not present
    default: .
    inputBinding:
      position: 102
      prefix: --missing-rules
  - id: missing_to_ref
    type:
      - 'null'
      - boolean
    doc: Assume genotypes at missing sites are 0/0
    inputBinding:
      position: 102
      prefix: --missing-to-ref
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: Merge unindexed files, the same chromosomal order is required and -r/-R
      are not allowed
    inputBinding:
      position: 102
      prefix: --no-index
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    default: v
    inputBinding:
      position: 102
      prefix: --output-type
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print only the merged header and exit
    inputBinding:
      position: 102
      prefix: --print-header
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_header
    type:
      - 'null'
      - File
    doc: Use the provided header
    inputBinding:
      position: 102
      prefix: --use-header
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
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
