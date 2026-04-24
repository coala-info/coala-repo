cwlVersion: v1.2
class: CommandLineTool
baseCommand: plassembler assembled
label: plassembler_assembled
doc: "Runs assembled mode\n\nTool homepage: https://github.com/gbouras13/plassembler"
inputs:
  - id: chromosome
    type:
      - 'null'
      - int
    doc: Approximate lower-bound chromosome length of bacteria (in base pairs).
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: database
    type: Directory
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
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: input_chromosome
    type:
      - 'null'
      - File
    doc: Input FASTA file consisting of already assembled chromosome with 
      assembled mode. Must be 1 complete contig.
    inputBinding:
      position: 101
      prefix: --input_chromosome
  - id: input_plasmids
    type:
      - 'null'
      - File
    doc: Input FASTA file consisting of already assembled plasmids with 
      assembled mode. Requires FASTQ file input (short only, long only or long +
      short).
    inputBinding:
      position: 101
      prefix: --input_plasmids
  - id: longreads
    type:
      - 'null'
      - File
    doc: FASTQ file of long reads.
    inputBinding:
      position: 101
      prefix: --longreads
  - id: min_length
    type:
      - 'null'
      - string
    doc: minimum length for filtering long reads with chopper.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_quality
    type:
      - 'null'
      - string
    doc: minimum quality q-score for filtering long reads with chopper.
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: no_copy_numbers
    type:
      - 'null'
      - boolean
    doc: Only run the PLSDB mash screen, not copy number estimation
    inputBinding:
      position: 101
      prefix: --no_copy_numbers
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write the output to.
    inputBinding:
      position: 101
      prefix: --outdir
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
    inputBinding:
      position: 101
      prefix: --prefix
  - id: short_one
    type:
      - 'null'
      - File
    doc: R1 short read FASTQ file.
    inputBinding:
      position: 101
      prefix: --short_one
  - id: short_two
    type:
      - 'null'
      - File
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
stdout: plassembler_assembled.out
