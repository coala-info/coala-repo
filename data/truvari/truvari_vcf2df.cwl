cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - vcf2df
label: truvari_vcf2df
doc: "Takes a vcf and creates a data frame. Can parse a bench output directory\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: bench_dir_mode
    type:
      - 'null'
      - boolean
    doc: Input is a truvari bench directory
    inputBinding:
      position: 1
      prefix: "-b"
  - id: info
    type:
      - 'null'
      - boolean
    doc: Attempt to put the INFO fields into the dataframe
    inputBinding:
      position: 1
      prefix: "-i"
  - id: format
    type:
      - 'null'
      - boolean
    doc: Attempt to put the FORMAT fileds into the dataframe
    inputBinding:
      position: 1
      prefix: "-f"
  - id: sample
    type:
      - 'null'
      - string
    doc: SAMPLE name to parse when building columns for --format
    inputBinding:
      position: 1
      prefix: "-s"
  - id: no_prefix
    type:
      - 'null'
      - boolean
    doc: Don't prepend sample name to format columns
    inputBinding:
      position: 1
      prefix: "-n"
  - id: skip_compression
    type:
      - 'null'
      - boolean
    doc: Skip the attempt to optimize the dataframe's size
    inputBinding:
      position: 1
      prefix: "-S"
  - id: compress
    type:
      - 'null'
      - int
    doc: Compression level for joblib 0-9 (3)
    inputBinding:
      position: 1
      prefix: "-c"
  - id: alleles
    type:
      - 'null'
      - boolean
    doc: Add REF/ALT alleles into the dataframe
    inputBinding:
      position: 1
      prefix: "-a"
  - id: parquet
    type:
      - 'null'
      - boolean
    doc: Write a parquet file instead of joblib dump
    inputBinding:
      position: 1
      prefix: "-p"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: vcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: VCF to parse (give this or bench_dir)
    inputBinding:
      position: 2
  - id: bench_dir
    type:
      - 'null'
      - Directory
    doc: Truvari bench directory (give this with bench_dir_mode)
    inputBinding:
      position: 2
  - id: jl
    type: string
    doc: Output joblib to save
    inputBinding:
      position: 3
outputs:
  - id: output_df
    type: File
    doc: Saved dataframe (joblib, or parquet with --parquet)
    outputBinding:
      glob: "$(inputs.jl)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
