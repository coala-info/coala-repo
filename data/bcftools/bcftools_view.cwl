cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - view
label: bcftools_view
doc: VCF/BCF conversion, view, subset and filter VCF/BCF files.
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: regions_positional
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to restrict to
    inputBinding:
      position: 2
  - id: apply_filters
    type:
      - 'null'
      - string
    doc: Require at least one of the listed FILTER strings (e.g. "PASS,.")
    inputBinding:
      position: 103
      prefix: --apply-filters
  - id: compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level: 0 uncompressed, 1 best speed, 9 best compression'
    inputBinding:
      position: 103
      prefix: --compression-level
  - id: drop_genotypes
    type:
      - 'null'
      - boolean
    doc: Drop individual genotype information (after subsetting if -s option 
      set)
    inputBinding:
      position: 103
      prefix: --drop-genotypes
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_phased
    type:
      - 'null'
      - boolean
    doc: Exclude sites where all samples are phased
    inputBinding:
      position: 103
      prefix: --exclude-phased
  - id: exclude_private
    type:
      - 'null'
      - boolean
    doc: Exclude sites where the non-reference alleles are exclusive (private) 
      to the subset samples
    inputBinding:
      position: 103
      prefix: --exclude-private
  - id: exclude_types
    type:
      - 'null'
      - string
    doc: 'Exclude comma-separated list of variant types: snps,indels,mnps,ref,bnd,other'
    inputBinding:
      position: 103
      prefix: --exclude-types
  - id: exclude_uncalled
    type:
      - 'null'
      - boolean
    doc: Exclude sites without a called genotype
    inputBinding:
      position: 103
      prefix: --exclude-uncalled
  - id: force_samples
    type:
      - 'null'
      - boolean
    doc: Only warn about unknown subset samples
    inputBinding:
      position: 103
      prefix: --force-samples
  - id: genotype
    type:
      - 'null'
      - string
    doc: Require one or more hom/het/missing genotype or, if prefixed with "^", 
      exclude such sites
    inputBinding:
      position: 103
      prefix: --genotype
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Print only the header in VCF output (equivalent to bcftools head)
    inputBinding:
      position: 103
      prefix: --header-only
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 103
      prefix: --include
  - id: known
    type:
      - 'null'
      - boolean
    doc: Select known sites only (ID is not '.')
    inputBinding:
      position: 103
      prefix: --known
  - id: max_ac
    type:
      - 'null'
      - string
    doc: Maximum count for non-reference (nref), 1st alternate (alt1), least 
      frequent (minor), most frequent (major) or sum of all but most frequent 
      (nonmajor) alleles
    inputBinding:
      position: 103
      prefix: --max-ac
  - id: max_af
    type:
      - 'null'
      - string
    doc: Maximum frequency for non-reference (nref), 1st alternate (alt1), least
      frequent (minor), most frequent (major) or sum of all but most frequent 
      (nonmajor) alleles
    inputBinding:
      position: 103
      prefix: --max-af
  - id: max_alleles
    type:
      - 'null'
      - int
    doc: Maximum number of alleles listed in REF and ALT
    inputBinding:
      position: 103
      prefix: --max-alleles
  - id: min_ac
    type:
      - 'null'
      - string
    doc: Minimum count for non-reference (nref), 1st alternate (alt1), least 
      frequent (minor), most frequent (major) or sum of all but most frequent 
      (nonmajor) alleles
    inputBinding:
      position: 103
      prefix: --min-ac
  - id: min_af
    type:
      - 'null'
      - string
    doc: Minimum frequency for non-reference (nref), 1st alternate (alt1), least
      frequent (minor), most frequent (major) or sum of all but most frequent 
      (nonmajor) alleles
    inputBinding:
      position: 103
      prefix: --min-af
  - id: min_alleles
    type:
      - 'null'
      - int
    doc: Minimum number of alleles listed in REF and ALT
    inputBinding:
      position: 103
      prefix: --min-alleles
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress the header in VCF output
    inputBinding:
      position: 103
      prefix: --no-header
  - id: no_update
    type:
      - 'null'
      - boolean
    doc: Do not (re)calculate INFO fields for the subset (currently INFO/AC and 
      INFO/AN)
    inputBinding:
      position: 103
      prefix: --no-update
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 103
      prefix: --no-version
  - id: novel
    type:
      - 'null'
      - boolean
    doc: Select novel sites only (ID is '.')
    inputBinding:
      position: 103
      prefix: --novel
  - id: output_file
    type: string
    doc: Output file name [stdout]
    inputBinding:
      position: 103
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    inputBinding:
      position: 103
      prefix: --output-type
  - id: phased
    type:
      - 'null'
      - boolean
    doc: Select sites where all samples are phased
    inputBinding:
      position: 103
      prefix: --phased
  - id: private
    type:
      - 'null'
      - boolean
    doc: Select sites where the non-reference alleles are exclusive (private) to
      the subset samples
    inputBinding:
      position: 103
      prefix: --private
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
    doc: Restrict to regions listed in FILE
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
    doc: Comma separated list of samples to include (or exclude with "^" prefix)
    inputBinding:
      position: 103
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include (or exclude with "^" prefix)
    inputBinding:
      position: 103
      prefix: --samples-file
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps. Exclude regions with
      "^" prefix
    inputBinding:
      position: 103
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps. Exclude regions with
      "^" prefix
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
    doc: Use multithreading with INT worker threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: trim_alt_alleles
    type:
      - 'null'
      - boolean
    doc: Trim ALT alleles not seen in the genotype fields (or their subset with 
      -s/-S)
    inputBinding:
      position: 103
      prefix: --trim-alt-alleles
  - id: trim_unseen_allele
    type:
      - 'null'
      - boolean
    doc: Remove '<*>' or '<NON_REF>' at variant (-A) or at all (-AA) sites
    inputBinding:
      position: 103
      prefix: --trim-unseen-allele
  - id: types
    type:
      - 'null'
      - string
    doc: 'Select comma-separated list of variant types: snps,indels,mnps,ref,bnd,other'
    inputBinding:
      position: 103
      prefix: --types
  - id: uncalled
    type:
      - 'null'
      - boolean
    doc: Select sites without a called genotype
    inputBinding:
      position: 103
      prefix: --uncalled
  - id: with_header
    type:
      - 'null'
      - boolean
    doc: Print both header and records in VCF output [default]
    inputBinding:
      position: 103
      prefix: --with-header
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files [off]
    inputBinding:
      position: 103
      prefix: --write-index
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Output file name [stdout]
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
