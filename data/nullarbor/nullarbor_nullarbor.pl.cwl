cwlVersion: v1.2
class: CommandLineTool
baseCommand: nullarbor.pl
label: nullarbor_nullarbor.pl
doc: "Reads to reports for public health microbiology\n\nTool homepage: https://github.com/tseemann/nullarbor"
inputs:
  - id: annotator
    type:
      - 'null'
      - string
    doc: 'Genome annotator to use: prokka_fast'
    default: prokka_fast
    inputBinding:
      position: 101
      prefix: --annotator
  - id: annotator_options
    type:
      - 'null'
      - string
    doc: Extra annotator options to pass
    default: ()
    inputBinding:
      position: 101
      prefix: --annotator-opt
  - id: assembler
    type:
      - 'null'
      - string
    doc: 'Assembler to use: megahit shovill skesa skesa_fast spades'
    default: skesa
    inputBinding:
      position: 101
      prefix: --assembler
  - id: assembler_options
    type:
      - 'null'
      - string
    doc: Extra assembler options to pass
    default: ()
    inputBinding:
      position: 101
      prefix: --assembler-opt
  - id: auto_configure
    type:
      - 'null'
      - boolean
    doc: Be lazy and guess --name,--ref,--input,--outdir,--mask
    inputBinding:
      position: 101
      prefix: --auto
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies and exit
    inputBinding:
      position: 101
      prefix: --check
  - id: config_file
    type:
      - 'null'
      - File
    doc: Config file
    default: /usr/local/bin/../conf/nullarbor.conf
    inputBinding:
      position: 101
      prefix: --conf
  - id: cpus
    type:
      - 'null'
      - int
    doc: Maximum number of CPUs to use in total
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite --outdir (useful for adding samples to existing analysis)
    inputBinding:
      position: 101
      prefix: --force
  - id: force_mlst_scheme
    type:
      - 'null'
      - string
    doc: Force this MLST scheme
    default: AUTO
    inputBinding:
      position: 101
      prefix: --mlst
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: Genetic code for prokka
    default: 11
    inputBinding:
      position: 101
      prefix: --gcode
  - id: input_file
    type: File
    doc: 'Input TSV file with format:  | Isolate_ID | R1.fq.gz | R2.fq.gz |'
    inputBinding:
      position: 101
      prefix: --input
  - id: job_name
    type: string
    doc: Job name
    inputBinding:
      position: 101
      prefix: --name
  - id: link_command
    type:
      - 'null'
      - string
    doc: Command to symlink/copy FASTQ files into --outdir
    default: "'ln -s -f'"
    inputBinding:
      position: 101
      prefix: --link-cmd
  - id: mask_regions
    type:
      - 'null'
      - string
    doc: Mask core SNPS in these regions or 'auto'
    default: ()
    inputBinding:
      position: 101
      prefix: --mask
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length for Prokka and Roary
    inputBinding:
      position: 101
      prefix: --minctg
  - id: mode
    type: string
    doc: 'Run mode: [all] preview'
    default: all
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_prefill
    type:
      - 'null'
      - boolean
    doc: Override precomputed data usage.
    inputBinding:
      position: 101
      prefix: --no-prefill
  - id: output_dir
    type: Directory
    doc: Output folder
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference_file
    type: File
    doc: Reference file in FASTA or GBK format
    inputBinding:
      position: 101
      prefix: --ref
  - id: roary_options
    type:
      - 'null'
      - string
    doc: Options to pass to roary eg. '-iv 1.75 -s -cd 97'
    default: ()
    inputBinding:
      position: 101
      prefix: --roary_opt
  - id: run
    type:
      - 'null'
      - boolean
    doc: Immediately launch Makefile
    inputBinding:
      position: 101
      prefix: --run
  - id: snippy_options
    type:
      - 'null'
      - string
    doc: Options to pass to snippy eg. '--mincov 10 --ram 32'
    default: ()
    inputBinding:
      position: 101
      prefix: --snippy_opt
  - id: taxoner
    type:
      - 'null'
      - string
    doc: 'Species ID tool to use: centrifuge kraken kraken2'
    default: kraken
    inputBinding:
      position: 101
      prefix: --taxoner
  - id: taxoner_options
    type:
      - 'null'
      - string
    doc: Extra species ID builder options to pass
    default: ()
    inputBinding:
      position: 101
      prefix: --taxoner-opt
  - id: treebuilder
    type:
      - 'null'
      - string
    doc: 'Tree-builder to use: fasttree iqtree iqtree_fast iqtree_slow'
    default: iqtree_fast
    inputBinding:
      position: 101
      prefix: --treebuilder
  - id: treebuilder_options
    type:
      - 'null'
      - string
    doc: Extra tree-builder options to pass
    default: ()
    inputBinding:
      position: 101
      prefix: --treebuilder-opt
  - id: trim_reads
    type:
      - 'null'
      - boolean
    doc: Trim reads of adaptors
    default: false
    inputBinding:
      position: 101
      prefix: --trim
  - id: use_precomputed_data
    type:
      - 'null'
      - boolean
    doc: Use precomputed data as per --conf file.
    inputBinding:
      position: 101
      prefix: --prefill
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More screen output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nullarbor:2.0.20191013--0
stdout: nullarbor_nullarbor.pl.out
