cwlVersion: v1.2
class: CommandLineTool
baseCommand: captus assemble
label: captus_assemble
doc: "Assemble; perform de novo assembly using MEGAHIT\n\nTool homepage: https://github.com/edgardomortiz/Captus"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "FASTQ files. Valid file name extensions are: .fq, .fastq, .fq.gz, and .fastq.gz.
      The names must include the string '_R1' (and '_R2' when pairs are provided).
      Everything before the string '_R1' will be used as sample name. There are a
      few ways to provide the FASTQ files: A directory = path to directory containing
      FASTQ files (e.g.: -r ./raw_reads) A list = file names separated by space (e.g.:
      -r A_R1.fq A_R2.fq B_R1.fq C_R1.fq) A pattern = UNIX matching expression (e.g.:
      -r ./raw_reads/*.fastq.gz) (default: ./01_clean_reads)"
    inputBinding:
      position: 1
  - id: concurrent
    type:
      - 'null'
      - string
    doc: Captus will attempt to assemble this many samples concurrently. RAM and
      CPUs will be divided by this value for each individual MEGAHIT process. 
      For example if you set --threads to 12 and --concurrent to 3, then each 
      MEGAHIT assembly will be done using --threads/--concurrent = 4 CPUs. If 
      set to 'auto', Captus will run as many concurrent assemblies as possible 
      with a minimum of 4 CPUs and 4 GB of RAM per assembly (8 GB if presets RNA
      or WGS are used)
    inputBinding:
      position: 102
      prefix: --concurrent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode, parallelization is disabled so errors are logged
      to screen
    inputBinding:
      position: 102
      prefix: --debug
  - id: disable_mapping
    type:
      - 'null'
      - boolean
    doc: Disable mapping the reads back to the contigs using Salmon for accurate
      depth estimation. If disabled, the approximate depth estimation given by 
      MEGAHIT will be used instead
    inputBinding:
      position: 102
      prefix: --disable_mapping
  - id: k_list
    type:
      - 'null'
      - string
    doc: Comma-separated list of kmer sizes, all must be odd values in the range
      15-255, in increments of at most 28. If not provided, a list optimized for
      hybridization capture and/or genome skimming data will be used. The final 
      kmer size will be adjusted automatically so it never exceeds the mean read
      length of the sample by more than 31
    inputBinding:
      position: 102
      prefix: --k_list
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Do not delete any intermediate files
    inputBinding:
      position: 102
      prefix: --keep_all
  - id: max_contig_gc
    type:
      - 'null'
      - float
    doc: Maximum GC percentage allowed per contig. Useful to filter 
      contamination. For example, bacteria usually exceed 60% GC content while 
      eukaryotes rarely exceed that limit. 100.0 disables the GC filter
    inputBinding:
      position: 102
      prefix: --max_contig_gc
  - id: megahit_path
    type:
      - 'null'
      - File
    doc: Path to MEGAHIT
    inputBinding:
      position: 102
      prefix: --megahit_path
  - id: megahit_toolkit_path
    type:
      - 'null'
      - File
    doc: Path to MEGAHIT's toolkit
    inputBinding:
      position: 102
      prefix: --megahit_toolkit_path
  - id: merge_level
    type:
      - 'null'
      - string
    doc: Merge complex bubbles, the first number multiplied by the kmer size 
      represents the maximum bubble length to merge, the second number 
      represents the minimum similarity required to merge bubbles
    inputBinding:
      position: 102
      prefix: --merge_level
  - id: min_contig_depth
    type:
      - 'null'
      - string
    doc: Minimum contig depth of coverage in output assembly; 'auto' will retain
      contigs with depth of coverage greater than 1.0x when '--disable_mapping' 
      is chosen, otherwise it will retain only contigs of at least 1.5x. 
      Accepted values are decimals greater or equal to 0. Use 0 to disable the 
      filter
    inputBinding:
      position: 102
      prefix: --min_contig_depth
  - id: min_contig_len
    type:
      - 'null'
      - string
    doc: Minimum contig length in output assembly, 'auto' is mean input read 
      length + smallest kmer size in '--k_list'
    inputBinding:
      position: 102
      prefix: --min_contig_len
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum contig depth (a.k.a. multiplicity in MEGAHIT), accepted values 
      are integers >= 1. Reducing it to 1 may increase the amount of low-depth 
      contigs likely produced from reads with errors. Increase above 2 if the 
      data has high and even sequencing depth
    inputBinding:
      position: 102
      prefix: --min_count
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous results
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: preset
    type:
      - 'null'
      - string
    doc: The default preset is 'CAPSKIM', these settings work well with either 
      hybridization capture or genome skimming data (or a combination of both). 
      You can assemble RNA-Seq reads with the 'RNA' preset or high-coverage 
      Whole Genome Sequencing reads with the 'WGS' preset, however, both presets
      require a minimum of 8GB of RAM to work well. In order to avoid RAM 
      limitations when assembly high-depth data, consider using '--preset WGS 
      --concurrent 1' to assemble a single sample at time using all the CPUs and
      RAM provided by '--threads' and '--ram'
    inputBinding:
      position: 102
      prefix: --preset
  - id: prune_level
    type:
      - 'null'
      - int
    doc: Prunning strength for low-coverage edges during graph cleaning. 
      Increasing the value beyond 2 can speed up the assembly at the cost of 
      losing low-depth contigs. Accepted values are integers between 0 and 3
    inputBinding:
      position: 102
      prefix: --prune_level
  - id: ram
    type:
      - 'null'
      - string
    doc: "Maximum RAM in GB (e.g.: 4.5) dedicated to Captus, 'auto' uses 99% of available
      RAM"
    inputBinding:
      position: 102
      prefix: --ram
  - id: redo_filtering
    type:
      - 'null'
      - boolean
    doc: Enable if you want to try different values for `--max_contig_gc` or 
      `--min_contig_depth`. Only the filtering step will be repeated
    inputBinding:
      position: 102
      prefix: --redo_filtering
  - id: reformat_path
    type:
      - 'null'
      - File
    doc: Path to reformat.sh
    inputBinding:
      position: 102
      prefix: --reformat_path
  - id: salmon_path
    type:
      - 'null'
      - File
    doc: Path to Salmon
    inputBinding:
      position: 102
      prefix: --salmon_path
  - id: sample_reads_target
    type:
      - 'null'
      - int
    doc: "Use this number of read pairs (or reads if single-end) for assembly. Reads
      are randomly subsampled with 'reformat.sh' from BBTools (option: srt/samplereadstarget).
      Useful for limiting the amount of data of samples with very high sequencing
      depth. To use all the reads, set this value to 0"
    inputBinding:
      position: 102
      prefix: --sample_reads_target
  - id: show_less
    type:
      - 'null'
      - boolean
    doc: Do not show individual sample information during the run, the 
      information is still written to the log
    inputBinding:
      position: 102
      prefix: --show_less
  - id: threads
    type:
      - 'null'
      - string
    doc: Maximum number of CPUs dedicated to Captus, 'auto' uses all available 
      CPUs
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Location to create the temporary directory 'captus_assembly_tmp' for 
      MEGAHIT assembly. Sometimes, when working on external hard drives MEGAHIT 
      will refuse to run unless this directory is created in an internal hard 
      drive
    inputBinding:
      position: 102
      prefix: --tmp_dir
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory name. Inside this directory the output for each sample
      will be stored in a subdirectory named as 'Sample_name__captus-asm'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
