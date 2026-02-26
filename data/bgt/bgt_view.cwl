cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgt
  - view
label: bgt_view
doc: "View and convert VCF/BCF files\n\nTool homepage: https://github.com/Dysman/bgTools-playerPrefsEditor"
inputs:
  - id: bgt_prefix
    type: string
    doc: Prefix of the BGT file(s)
    inputBinding:
      position: 1
  - id: alleles_expr
    type:
      - 'null'
      - string
    doc: Alleles list chr:1basedPos:refLen:seq (,allele1,allele2 or a file or 
      expr)
    inputBinding:
      position: 102
      prefix: -a
  - id: bcf_compression_level
    type:
      - 'null'
      - int
    doc: Compression level for BCF
    inputBinding:
      position: 102
      prefix: -l
  - id: bcf_output
    type:
      - 'null'
      - boolean
    doc: BCF output (effective without -S/-H)
    inputBinding:
      position: 102
      prefix: -b
  - id: bed_file_extract
    type:
      - 'null'
      - File
    doc: Extract variants overlapping BED FILE
    inputBinding:
      position: 102
      prefix: -B
  - id: count_haplotypes_with_set
    type:
      - 'null'
      - boolean
    doc: Count of haplotypes with a set of alleles (with -a)
    inputBinding:
      position: 102
      prefix: -H
  - id: exclude_bed_file
    type:
      - 'null'
      - boolean
    doc: Exclude variants overlapping BED FILE (effective with -B)
    inputBinding:
      position: 102
      prefix: -e
  - id: frequency_filters
    type:
      - 'null'
      - string
    doc: Frequency filters
    inputBinding:
      position: 102
      prefix: -f
  - id: load_annotations_ram
    type:
      - 'null'
      - boolean
    doc: Load variant annotations in RAM (only with -d)
    inputBinding:
      position: 102
      prefix: -M
  - id: no_sample_genotypes
    type:
      - 'null'
      - boolean
    doc: Don't output sample genotypes
    inputBinding:
      position: 102
      prefix: -G
  - id: output_fields
    type:
      - 'null'
      - string
    doc: 'Comma-delimited list of fields to output. Accepted variables: AC, AN, AC#,
      AN#, CHROM, POS, END, REF, ALT (# for a group number)'
    inputBinding:
      position: 102
      prefix: -t
  - id: process_at_most_records
    type:
      - 'null'
      - int
    doc: Process at most INT records
    inputBinding:
      position: 102
      prefix: -n
  - id: process_from_record
    type:
      - 'null'
      - int
    doc: Process from the INT-th record (1-based)
    inputBinding:
      position: 102
      prefix: -i
  - id: region
    type:
      - 'null'
      - string
    doc: Region
    default: all
    inputBinding:
      position: 102
      prefix: -r
  - id: samples_expr
    type:
      - 'null'
      - string
    doc: Samples list (,sample1,sample2 or a file or expr; see Notes below)
    default: all
    inputBinding:
      position: 102
      prefix: -s
  - id: show_alleles_with_set
    type:
      - 'null'
      - boolean
    doc: Show samples with a set of alleles (with -a)
    inputBinding:
      position: 102
      prefix: -S
  - id: uncompressed_bcf
    type:
      - 'null'
      - boolean
    doc: Equivalent to -bl0 (overriding -b and -l)
    inputBinding:
      position: 102
      prefix: -u
  - id: variant_annotations_fmf
    type:
      - 'null'
      - File
    doc: Variant annotations in FMF (to work with -a)
    inputBinding:
      position: 102
      prefix: -d
  - id: write_ac_an_info
    type:
      - 'null'
      - boolean
    doc: Write AC/AN to the INFO field (auto applied with -f or multipl -s)
    inputBinding:
      position: 102
      prefix: -C
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_view.out
