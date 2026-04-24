cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_pipeline
label: hicstuff_pipeline
doc: "Whole (end-to-end) contact map generation command\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: input1
    type: string
    doc: Forward fastq file, if start_stage is "fastq", sam file for aligned 
      forward reads if start_stage is "bam", or a .pairs file if start_stage is 
      "pairs".
    inputBinding:
      position: 1
  - id: input2
    type:
      - 'null'
      - string
    doc: Reverse fastq file, if start_stage is "fastq", sam file for aligned 
      reverse reads if start_stage is "bam", or nothing if start_stage is 
      "pairs".
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: Alignment software to use. Can be either bowtie2, minimap2 or bwa. 
      minimap2 should only be used for reads > 100 bp.
    inputBinding:
      position: 103
      prefix: --aligner
  - id: balancing_args
    type:
      - 'null'
      - string
    doc: 'Arguments to pass to `cooler balance` (default: "") (only used if zoomify
      == True)'
    inputBinding:
      position: 103
      prefix: --balancing_args
  - id: binning
    type:
      - 'null'
      - int
    doc: Bin the contact matrix to a given resolution. By default, the contact 
      matrix is not binned. (only used if `--matfmt cool`)
    inputBinding:
      position: 103
      prefix: --binning
  - id: centromeres
    type:
      - 'null'
      - File
    doc: Positions of the centromeres separated by a space and in the same order
      than the chromosomes. Discordant with the circular option.
    inputBinding:
      position: 103
      prefix: --centromeres
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Enable if the genome is circular. Discordant with the centromeres 
      option.
    inputBinding:
      position: 103
      prefix: --circular
  - id: distance_law
    type:
      - 'null'
      - boolean
    doc: If enabled, generates a distance law file with the values of the 
      probabilities to have a contact between two distances for each chromosomes
      or arms if the file with the positions has been given. The values are not 
      normalized, or averaged.
    inputBinding:
      position: 103
      prefix: --distance-law
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: Filter out PCR duplicates based on read positions.
    inputBinding:
      position: 103
      prefix: --duplicates
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Restriction enzyme or "mnase" if a string, or chunk size (i.e. 
      resolution) if a number. Can also be multiple comma-separated enzymes.
    inputBinding:
      position: 103
      prefix: --enzyme
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude specific chromosomes from the generated matrix. Multiple 
      chromosomes can be listed separated by commas (e.g. `--exclude "chrM,2u"`)
    inputBinding:
      position: 103
      prefix: --exclude
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter out spurious 3C events (loops and uncuts) using hicstuff filter.
      Requires "-e" to be a restriction enzyme or mnase, not a chunk size. For 
      more informations, see Cournac et al. BMC Genomics, 2012.
    inputBinding:
      position: 103
      prefix: --filter
  - id: force
    type:
      - 'null'
      - boolean
    doc: Write even if the output file already exists.
    inputBinding:
      position: 103
      prefix: --force
  - id: genome
    type: File
    doc: Reference genome to map against. Path to the bowtie2/bwa index if using
      bowtie2/bwa, or to a FASTA file if using minimap2.
    inputBinding:
      position: 103
      prefix: --genome
  - id: mapping
    type:
      - 'null'
      - string
    doc: 'normal|iterative|cutsite. Parameter of mapping. "normal": Directly map reads
      without any process. "iterative": Map reads iteratively using iteralign, by
      truncating reads to 20bp and then repeatedly extending to align them. "cutsite":
      Cut reads at the religation sites of the given enzyme using cutsite, create
      new pairs of reads and then align them ; enzyme is required'
    inputBinding:
      position: 103
      prefix: --mapping
  - id: matfmt
    type:
      - 'null'
      - string
    doc: The format of the output sparse matrix. Can be "bg2" for 2D Bedgraph 
      format, "cool" for Mirnylab's cooler software, or "graal" for 
      graal-compatible plain text COO format.
    inputBinding:
      position: 103
      prefix: --matfmt
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: If enabled, intermediary BED files will be kept after generating the 
      contact map. Disabled by defaut.
    inputBinding:
      position: 103
      prefix: --no-cleanup
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory. Defaults to the current directory.
    inputBinding:
      position: 103
      prefix: --outdir
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generates plots in the output directory at different steps of the 
      pipeline.
    inputBinding:
      position: 103
      prefix: --plot
  - id: prefix
    type:
      - 'null'
      - string
    doc: Overrides default filenames and prefixes all output files with a custom
      name.
    inputBinding:
      position: 103
      prefix: --prefix
  - id: quality_min
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for selecting contacts.
    inputBinding:
      position: 103
      prefix: --quality-min
  - id: read_len
    type:
      - 'null'
      - int
    doc: Maximum read length in the fastq file. Optionally used in iterative 
      alignment mode. Estimated from the first read by default. Useful if input 
      fastq is a composite of different read lengths.
    inputBinding:
      position: 103
      prefix: --read-len
  - id: remove_centromeres
    type:
      - 'null'
      - int
    doc: Integer. Number of kb that will be remove around the centromere 
      position given by in the centromere file.
    inputBinding:
      position: 103
      prefix: --remove-centromeres
  - id: size
    type:
      - 'null'
      - int
    doc: Minimum size threshold to consider contigs. Keep all contigs by 
      default.
    inputBinding:
      position: 103
      prefix: --size
  - id: start_stage
    type:
      - 'null'
      - string
    doc: Define the starting point of the pipeline to skip some steps. Default 
      is "fastq" to run from the start. Can also be "bam" to skip the alignment,
      "pairs" to start from a single pairs file or "pairs_idx" to skip fragment 
      attribution and only build the matrix.
    inputBinding:
      position: 103
      prefix: --start-stage
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to allocate.
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory for storing intermediary BED files and temporary sort files. 
      Defaults to the output directory.
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: zoomify
    type:
      - 'null'
      - boolean
    doc: 'Zoomify binned cool matrix [default: True] (only used if mat_fmt == "cool"
      and binning is set)'
    inputBinding:
      position: 103
      prefix: --zoomify
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
stdout: hicstuff_pipeline.out
