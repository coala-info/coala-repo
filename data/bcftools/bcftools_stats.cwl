cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - stats
label: bcftools_stats
doc: Parses VCF or BCF and produces stats which can be plotted using 
  plot-vcfstats. When two files are given, the program generates separate stats 
  for intersection and the complements.
inputs:
  - id: input_file_a
    type: File
    doc: Input VCF or BCF file A
    inputBinding:
      position: 1
  - id: input_file_b
    type:
      - 'null'
      - File
    doc: Optional second input VCF or BCF file B for comparison
    inputBinding:
      position: 2
  - id: af_bins
    type:
      - 'null'
      - string
    doc: Allele frequency bins, a list (0.1,0.5,1) or a file (0.1\n0.5\n1)
    inputBinding:
      position: 103
      prefix: --af-bins
  - id: af_tag
    type:
      - 'null'
      - string
    doc: Allele frequency tag to use, by default estimated from AN,AC or GT
    inputBinding:
      position: 103
      prefix: --af-tag
  - id: apply_filters
    type:
      - 'null'
      - string
    doc: Require at least one of the listed FILTER strings (e.g. "PASS,.")
    inputBinding:
      position: 103
      prefix: --apply-filters
  - id: collapse
    type:
      - 'null'
      - string
    doc: Treat as identical records with <snps|indels|both|all|some|none>
    inputBinding:
      position: 103
      prefix: --collapse
  - id: depth
    type:
      - 'null'
      - string
    doc: 'Depth distribution: min,max,bin size'
    inputBinding:
      position: 103
      prefix: --depth
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exons
    type:
      - 'null'
      - File
    doc: Tab-delimited file with exons for indel frameshifts (chr,beg,end; 
      1-based, inclusive, bgzip compressed)
    inputBinding:
      position: 103
      prefix: --exons
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Faidx indexed reference sequence file to determine INDEL context
    inputBinding:
      position: 103
      prefix: --fasta-ref
  - id: first_allele_only
    type:
      - 'null'
      - boolean
    doc: Include only 1st allele at multiallelic sites
    inputBinding:
      position: 103
      prefix: --1st-allele-only
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 103
      prefix: --include
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 103
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 103
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 103
      prefix: --regions-overlap
  - id: samples
    type:
      - 'null'
      - string
    doc: List of samples for sample stats, "-" to include all samples
    inputBinding:
      position: 103
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include
    inputBinding:
      position: 103
      prefix: --samples-file
  - id: split_by_id
    type:
      - 'null'
      - boolean
    doc: Collect stats for sites with ID separately (known vs novel)
    inputBinding:
      position: 103
      prefix: --split-by-ID
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 103
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 103
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 103
      prefix: --targets-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with <int> worker threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: user_tstv
    type:
      - 'null'
      - string
    doc: Collect Ts/Tv stats for any tag using the given binning
    inputBinding:
      position: 103
      prefix: --user-tstv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
stdout: bcftools_stats.out
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
