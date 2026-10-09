cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifihla
  - call-contigs
label: hifihla_call-contigs
doc: "Extract HLA loci from assembled MHC contigs & call star alleles on extracted
  sequences\n\nTool homepage: https://github.com/PacificBiosciences/hifihla"
inputs:
  - id: aligned_assembly
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: Input assembly aligned to GRCh38
    inputBinding:
      position: 101
      prefix: --abam
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Full length IMGT records only
    inputBinding:
      position: 101
      prefix: --full_length
  - id: hap1_fa
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Input hap1 assembly fa(.gz)
    inputBinding:
      position: 101
      prefix: --hap1
  - id: hap2_fa
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: Input hap2 assembly fa(.gz) (optional)
    inputBinding:
      position: 101
      prefix: --hap2
  - id: loci
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Input comma-sep loci to extract [default: all]'
    inputBinding:
      position: 101
      prefix: --loci
      itemSeparator: ','
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Alternative to repeated -v/--verbose: set log level via key.\n         \
      \                        Equivalence to -v/--verbose:\n                    \
      \                   => \"Warn\"\n                                    -v => \"\
      Info\"\n                                   -vv => \"Debug\"\n              \
      \                    -vvv => \"Trace\" [default: Warn]"
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_matches
    type:
      - 'null'
      - int
    doc: 'Maximum equivalent matches per query in report [default: 10]'
    inputBinding:
      position: 101
      prefix: --max_matches
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum length of extracted targets [default: 1000]'
    inputBinding:
      position: 101
      prefix: --min_length
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix, with a directory part (for example ./sample); the directory must exist
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output directory [deprecated]
    inputBinding:
      position: 101
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Analysis threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in out_prefix
    outputBinding:
      glob: $(inputs.out_prefix)*
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory [deprecated]
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hap1_fa)
        writable: true
      - entry: $(inputs.hap2_fa)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
stdout: hifihla_call-contigs.out
