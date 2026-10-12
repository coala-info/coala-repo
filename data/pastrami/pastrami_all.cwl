cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - all
label: pastrami_all
doc: "Perform full analysis\n\nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: haplotypes
    type:
      - 'null'
      - File
    doc: "File of haplotype positions"
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: pop_group
    type:
      - 'null'
      - File
    doc: "File containing population to group (e.g., tribes to region) mapping"
    inputBinding:
      position: 101
      prefix: --pop-group
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: "Should all debugging file be produced in the output"
    inputBinding:
      position: 101
      prefix: --debug_mode
  - id: reference_files
    type:
      type: array
      items: File
    doc: "TPED and TFAM files of the reference individuals (they are staged in the working directory)"
  - id: query_files
    type:
      type: array
      items: File
    doc: "TPED and TFAM files of the query individuals (they are staged in the working directory)"
  - id: reference_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the reference TPED/TFAM input files"
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the query TPED/TFAM input files"
    inputBinding:
      position: 101
      prefix: --query-prefix
  - id: map_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing genetic maps: chr1.map, chr2.map, etc"
    inputBinding:
      position: 101
      prefix: --map-dir
  - id: min_snps
    type:
      - 'null'
      - int
    doc: "Minimum number of SNPs in a haplotype block (default: 7)"
    inputBinding:
      position: 101
      prefix: --min-snps
  - id: max_snps
    type:
      - 'null'
      - int
    doc: "Maximum number of SNPs in a haplotype block (default: 20)"
    inputBinding:
      position: 101
      prefix: --max-snps
  - id: max_rate
    type:
      - 'null'
      - float
    doc: "Maximum recombination rate (default: 0.3)"
    inputBinding:
      position: 101
      prefix: --max-rate
  - id: per_individual
    type:
      - 'null'
      - boolean
    doc: "Generate per-individual copying rather than per-population copying"
    inputBinding:
      position: 101
      prefix: --per-individual
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "File containing log information (default: run.log)"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads (default: 4)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print program progress information on screen"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_prefix
    type: string
    doc: "Output prefix (default: pastrami) for creating following sets of files. <prefix>.pickle, <prefix>_query.tsv, <prefix>.tsv, <prefix>.fam, <prefix>_fractions.Q, <prefix>_paintings.Q, <prefix>_estimates.Q, <prefix>_fine_grain_estimates.Q"
    inputBinding:
      position: 103
      prefix: --out-prefix
outputs:
  - id: out_files
    type: File[]
    doc: "All output files with the given prefix (pickle, copying fractions, ancestry estimates)"
    outputBinding:
      glob: $(inputs.out_prefix)*
  - id: log_file
    type:
      - 'null'
      - File
    doc: "File containing log information"
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.reference_files.concat(inputs.query_files))"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
