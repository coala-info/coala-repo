cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - +gtc2vcf
label: bcftools-gtc2vcf-plugin
doc: "Convert Illumina GTC (or IDAT) files containing intensity data into VCF. It also
  converts BPM/CSV manifests and EGT cluster files to text, and writes manifest flank
  sequences as FASTA.\n\nTool homepage: https://github.com/freeseek/gtc2vcf"
inputs:
  - id: list_tags
    type:
      - 'null'
      - boolean
    doc: List available FORMAT tags with description for VCF output
    inputBinding:
      position: 101
      prefix: --list-tags
  - id: tags
    type:
      - 'null'
      - string
    doc: List of output FORMAT tags [GT,GQ,IGC,BAF,LRR,NORMX,NORMY,R,THETA,X,Y]
    inputBinding:
      position: 101
      prefix: --tags
  - id: bpm
    type:
      - 'null'
      - File
    doc: BPM manifest file
    inputBinding:
      position: 101
      prefix: --bpm
  - id: csv
    type:
      - 'null'
      - File
    doc: CSV manifest file (can be gzip compressed)
    inputBinding:
      position: 101
      prefix: --csv
  - id: egt
    type:
      - 'null'
      - File
    doc: EGT cluster file
    inputBinding:
      position: 101
      prefix: --egt
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Reference sequence in FASTA format (required for VCF output)
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: set_cache_size
    type:
      - 'null'
      - int
    doc: Select fasta cache size in bytes
    inputBinding:
      position: 101
      prefix: --set-cache-size
  - id: gc_window_size
    type:
      - 'null'
      - int
    doc: Window size in bp used to compute the GC content (-1 for no estimate) [200]
    inputBinding:
      position: 101
      prefix: --gc-window-size
  - id: gtcs
    type:
      - 'null'
      - File
    doc: File listing GTC (or IDAT) genotype files
    inputBinding:
      position: 101
      prefix: --gtcs
  - id: idat
    type:
      - 'null'
      - boolean
    doc: Input IDAT files rather than GTC files
    inputBinding:
      position: 101
      prefix: --idat
  - id: capacity
    type:
      - 'null'
      - int
    doc: Number of variants to read from intensity files per I/O operation [32768]
    inputBinding:
      position: 101
      prefix: --capacity
  - id: adjust_clusters
    type:
      - 'null'
      - boolean
    doc: Adjust cluster centers in (Theta, R) space (requires --bpm and --egt)
    inputBinding:
      position: 101
      prefix: --adjust-clusters
  - id: use_gtc_sample_names
    type:
      - 'null'
      - boolean
    doc: Use sample name in GTC files rather than GTC file name
    inputBinding:
      position: 101
      prefix: --use-gtc-sample-names
  - id: do_not_check_bpm
    type:
      - 'null'
      - boolean
    doc: Do not check whether BPM and GTC files match manifest file name
    inputBinding:
      position: 101
      prefix: --do-not-check-bpm
  - id: do_not_check_eof
    type:
      - 'null'
      - boolean
    doc: Do not check whether the BPM and EGT readers reach the end of the file
    inputBinding:
      position: 101
      prefix: --do-not-check-eof
  - id: genome_studio
    type:
      - 'null'
      - File
    doc: Input a GenomeStudio final report file (in matrix format)
    inputBinding:
      position: 101
      prefix: --genome-studio
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 101
      prefix: --no-version
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, t: GenomeStudio tab-delimited
      text output, 0-9: compression level [v]'
    inputBinding:
      position: 101
      prefix: --output-type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of extra output compression threads [0]
    inputBinding:
      position: 101
      prefix: --threads
  - id: extra
    type:
      - 'null'
      - string
    doc: Write GTC metadata to a file
    inputBinding:
      position: 101
      prefix: --extra
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: beadset_order
    type:
      - 'null'
      - boolean
    doc: Output BeadSetID normalization order (requires --bpm and --csv)
    inputBinding:
      position: 101
      prefix: --beadset-order
  - id: fasta_flank
    type:
      - 'null'
      - boolean
    doc: Output flank sequence in FASTA format (requires --csv)
    inputBinding:
      position: 101
      prefix: --fasta-flank
  - id: sam_flank
    type:
      - 'null'
      - File
    doc: Input flank sequence alignment in SAM/BAM format (requires --csv)
    inputBinding:
      position: 101
      prefix: --sam-flank
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Genome build ID used to update the manifest file [GRCh38]
    inputBinding:
      position: 101
      prefix: --genome-build
  - id: output_path
    type: string
    doc: Write output to this file
    inputBinding:
      position: 102
      prefix: --output
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GTC (or IDAT with --idat) files
    inputBinding:
      position: 103
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file (VCF/BCF, text table or FASTA)
    outputBinding:
      glob: $(inputs.output_path)
  - id: extra_output
    type:
      - 'null'
      - File
    doc: GTC metadata file
    outputBinding:
      glob: $(inputs.extra)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-gtc2vcf-plugin:1.22--hb66fcc3_0
