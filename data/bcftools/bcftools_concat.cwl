cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - concat
label: bcftools_concat
doc: "Concatenate or combine VCF/BCF files. All source files must have the same sample
  columns appearing in the same order. The program can be used, for example, to concatenate
  chromosome VCFs into one VCF, or combine a SNP VCF and an indel VCF into one. The
  input files must be sorted by chr and position. The files must be given in the correct
  order to produce sorted VCF on output unless the -a, --allow-overlaps option is
  specified. With the --naive option, the files are concatenated without being recompressed,
  which is very fast.\n\nTool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input VCF/BCF files to concatenate
    inputBinding:
      position: 1
  - id: allow_overlaps
    type:
      - 'null'
      - boolean
    doc: First coordinate of the next file can precede last record of the 
      current file.
    inputBinding:
      position: 102
      prefix: --allow-overlaps
  - id: compact_ps
    type:
      - 'null'
      - boolean
    doc: Do not output PS tag at each site, only at the start of a new phase set
      block.
    inputBinding:
      position: 102
      prefix: --compact-PS
  - id: drop_genotypes
    type:
      - 'null'
      - boolean
    doc: Drop individual genotype information.
    inputBinding:
      position: 102
      prefix: --drop-genotypes
  - id: file_list
    type:
      - 'null'
      - File
    doc: Read the list of files from a file.
    inputBinding:
      position: 102
      prefix: --file-list
  - id: ligate
    type:
      - 'null'
      - boolean
    doc: Ligate phased VCFs by matching phase at overlapping haplotypes
    inputBinding:
      position: 102
      prefix: --ligate
  - id: ligate_force
    type:
      - 'null'
      - boolean
    doc: Ligate even non-overlapping chunks, keep all sites
    inputBinding:
      position: 102
      prefix: --ligate-force
  - id: ligate_warn
    type:
      - 'null'
      - boolean
    doc: Drop sites in imperfect overlaps
    inputBinding:
      position: 102
      prefix: --ligate-warn
  - id: min_pq
    type:
      - 'null'
      - int
    doc: Break phase set if phasing quality is lower than <int>
    default: 30
    inputBinding:
      position: 102
      prefix: --min-PQ
  - id: naive
    type:
      - 'null'
      - boolean
    doc: Concatenate files without recompression, a header check compatibility 
      is performed
    inputBinding:
      position: 102
      prefix: --naive
  - id: naive_force
    type:
      - 'null'
      - boolean
    doc: Same as --naive, but header compatibility is not checked. Dangerous, 
      use with caution.
    inputBinding:
      position: 102
      prefix: --naive-force
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
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Alias for -d exact
    inputBinding:
      position: 102
      prefix: --remove-duplicates
  - id: rm_dups
    type:
      - 'null'
      - string
    doc: 'Output duplicate records present in multiple files only once: <snps|indels|both|all|exact>'
    inputBinding:
      position: 102
      prefix: --rm-dups
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
    doc: Set verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files [off]
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to a file [standard output]
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
