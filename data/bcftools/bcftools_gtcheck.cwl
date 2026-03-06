cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - gtcheck
label: bcftools_gtcheck
doc: Check sample identity. With no -g BCF given, multi-sample cross-check is 
  performed.
inputs:
  - id: query_vcf
    type: File
    doc: Query VCF/BCF file
    inputBinding:
      position: 1
  - id: distinctive_sites
    type:
      - 'null'
      - string
    doc: Find sites that can distinguish between at least NUM sample pairs. 
      NUM[,MEM[,TMP]]
    inputBinding:
      position: 102
      prefix: --distinctive-sites
  - id: dry_run
    type: boolean
    doc: Stop after first record to estimate required time
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: error_probability
    type:
      - 'null'
      - int
    doc: Phred-scaled probability of genotyping error, 0 for faster but less 
      accurate results
    inputBinding:
      position: 102
      prefix: --error-probability
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true [qry|gt]:EXPR
    inputBinding:
      position: 102
      prefix: --exclude
  - id: genotypes
    type:
      - 'null'
      - File
    doc: Genotypes to compare against
    inputBinding:
      position: 102
      prefix: --genotypes
  - id: homs_only
    type:
      - 'null'
      - boolean
    doc: Homozygous genotypes only, useful with low coverage data (requires -g)
    inputBinding:
      position: 102
      prefix: --homs-only
  - id: include
    type:
      - 'null'
      - string
    doc: Include sites for which the expression is true [qry|gt]:EXPR
    inputBinding:
      position: 102
      prefix: --include
  - id: keep_refs
    type:
      - 'null'
      - boolean
    doc: Keep monoallelic sites with no alternate allele
    inputBinding:
      position: 102
      prefix: --keep-refs
  - id: n_matches
    type:
      - 'null'
      - int
    doc: Print only top INT matches for each sample (sorted by average score), 0
      for unlimited. Use negative value to sort by HWE probability rather than 
      by discordance
    inputBinding:
      position: 102
      prefix: --n-matches
  - id: no_hwe_prob
    type:
      - 'null'
      - boolean
    doc: Disable calculation of HWE probability
    inputBinding:
      position: 102
      prefix: --no-HWE-prob
  - id: output
    type: string
    doc: Write output to a file [standard output]
    inputBinding:
      position: 102
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: 't: plain tab-delimited text output, z: compressed'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: pairs
    type:
      - 'null'
      - string
    doc: Comma-separated sample pairs to compare (qry,gt[,qry,gt..] with -g or 
      qry,qry[,qry,qry..] w/o)
    inputBinding:
      position: 102
      prefix: --pairs
  - id: pairs_file
    type:
      - 'null'
      - File
    doc: File with tab-delimited sample pairs to compare (qry,gt with -g or 
      qry,qry w/o)
    inputBinding:
      position: 102
      prefix: --pairs-file
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
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: List of query or -g samples, "-" to select all samples (by default all 
      samples are compared)
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File with the query or -g samples to compare
    inputBinding:
      position: 102
      prefix: --samples-file
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
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: use
    type:
      - 'null'
      - string
    doc: Which tag to use in the query file (TAG1) and the -g file (TAG2)
    inputBinding:
      position: 102
      prefix: --use
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
