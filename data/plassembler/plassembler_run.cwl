cwlVersion: v1.2
class: CommandLineTool
baseCommand: plassembler run
label: plassembler_run
doc: "Runs Plassembler\n\nTool homepage: https://github.com/gbouras13/plassembler"
inputs:
  - id: chromosome
    type:
      - 'null'
      - int
    doc: Approximate lower-bound chromosome length of bacteria (in base pairs).
    default: 1000000
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: database
    type:
      - 'null'
      - Directory
    doc: Directory of PLSDB database.
    inputBinding:
      position: 101
      prefix: --database
  - id: depth_filter
    type:
      - 'null'
      - float
    doc: Filters all contigs low than this fraction of the chromosome read 
      depth. Will apply on both long- and short-read sets for plassembler run.
    inputBinding:
      position: 101
      prefix: --depth_filter
  - id: flye_assembly
    type:
      - 'null'
      - File
    doc: Path to file containing Flye long read assembly FASTA. Allows 
      Plassembler to Skip Flye assembly step in conjunction with  --flye_info.
    inputBinding:
      position: 101
      prefix: --flye_assembly
  - id: flye_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing Flye long read assembly. Needs to contain 
      assembly_info.txt and assembly_info.fasta. Allows Plassembler to Skip Flye
      assembly step.
    inputBinding:
      position: 101
      prefix: --flye_directory
  - id: flye_info
    type:
      - 'null'
      - File
    doc: Path to file containing Flye long read assembly info text file. Allows 
      Plassembler to Skip Flye assembly step in conjunction with 
      --flye_assembly.
    inputBinding:
      position: 101
      prefix: --flye_info
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: keep_chromosome
    type:
      - 'null'
      - boolean
    doc: If you want to keep the chromosome assembly.
    inputBinding:
      position: 101
      prefix: --keep_chromosome
  - id: keep_fastqs
    type:
      - 'null'
      - boolean
    doc: Whether you want to keep FASTQ files containing putative plasmid reads  
      and long reads that map to multiple contigs (plasmid and chromosome).
    inputBinding:
      position: 101
      prefix: --keep_fastqs
  - id: longreads
    type: File
    doc: FASTQ file of long reads.
    inputBinding:
      position: 101
      prefix: --longreads
  - id: min_length
    type:
      - 'null'
      - string
    doc: minimum length for filtering long reads with chopper.
    default: '500'
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_quality
    type:
      - 'null'
      - string
    doc: minimum quality q-score for filtering long reads with chopper.
    default: '9'
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: no_chromosome
    type:
      - 'null'
      - boolean
    doc: Run Plassembler assuming no chromosome can be assembled. Use this if 
      your reads only contain plasmids that you would like to assemble.
    inputBinding:
      position: 101
      prefix: --no_chromosome
  - id: pacbio_model
    type:
      - 'null'
      - string
    doc: Pacbio model for Flye.  Must be one of pacbio-raw, pacbio-corr or 
      pacbio-hifi.  Use pacbio-raw for PacBio regular CLR reads (<20 percent 
      error), pacbio-corr for PacBio reads that were corrected with other 
      methods (<3 percent error) or pacbio-hifi for PacBio HiFi reads (<1 
      percent error).
    inputBinding:
      position: 101
      prefix: --pacbio_model
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files. This is not required.
    default: plassembler
    inputBinding:
      position: 101
      prefix: --prefix
  - id: raw_flag
    type:
      - 'null'
      - boolean
    doc: Use --nano-raw for Flye.  Designed for Guppy fast configuration reads.  
      By default, Flye will assume SUP or HAC reads and use --nano-hq.
    inputBinding:
      position: 101
      prefix: --raw_flag
  - id: short_one
    type: File
    doc: R1 short read FASTQ file.
    inputBinding:
      position: 101
      prefix: --short_one
  - id: short_two
    type: File
    doc: R2 short read FASTQ file.
    inputBinding:
      position: 101
      prefix: --short_two
  - id: skip_mash
    type:
      - 'null'
      - boolean
    doc: Skips mash search vs Plassembler PLSDB database
    inputBinding:
      position: 101
      prefix: --skip_mash
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: Skips qc (chopper and fastp).
    inputBinding:
      position: 101
      prefix: --skip_qc
  - id: spades_options
    type:
      - 'null'
      - string
    doc: Extra spades options for Unicycler - must be encapsulated by quotation 
      marks "--tmp-dir /tmp"
    inputBinding:
      position: 101
      prefix: --spades_options
  - id: threads
    type:
      - 'null'
      - string
    doc: Number of threads.
    default: '1'
    inputBinding:
      position: 101
      prefix: --threads
  - id: unicycler_options
    type:
      - 'null'
      - string
    doc: Extra Unicycler options - must be encapsulated by quotation marks if 
      multiple "--no_rotate --mode conservative"
    inputBinding:
      position: 101
      prefix: --unicycler_options
  - id: use_raven
    type:
      - 'null'
      - boolean
    doc: Uses Raven instead of Flye for long read assembly. May be useful if you
      want to reduce runtime.
    inputBinding:
      position: 101
      prefix: --use_raven
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write the output to.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
