cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - build_model
  - event_resquiggle
label: ont-tombo_build_model_event_resquiggle
doc: "Re-annotate raw signal with genomic alignment from existing basecalls using event table.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5s_basedir
    type: Directory
    doc: "Directory containing fast5 files. All files ending in \"fast5\" found recursively within this base directory will be processed."
    inputBinding:
      position: 1
      valueFrom: "$(self.basename)"
  - id: reference_fasta
    type: File
    doc: "Reference genome/transcriptome FASTA file for mapping."
    inputBinding:
      position: 2
      valueFrom: "$(self.basename)"
  - id: minimap2_executable
    type:
      - 'null'
      - string
    doc: "Path to minimap2 executable."
    inputBinding:
      position: 101
      prefix: "--minimap2-executable"
  - id: minimap2_index
    type:
      - 'null'
      - File
    doc: "Path to minimap2 index (with map-ont preset) file corresponding to the [genome_fasta] provided."
    inputBinding:
      position: 101
      prefix: "--minimap2-index"
  - id: bwa_mem_executable
    type:
      - 'null'
      - string
    doc: "Path to bwa-mem executable."
    inputBinding:
      position: 101
      prefix: "--bwa-mem-executable"
  - id: graphmap_executable
    type:
      - 'null'
      - string
    doc: "Path to graphmap executable."
    inputBinding:
      position: 101
      prefix: "--graphmap-executable"
  - id: alignment_batch_size
    type:
      - 'null'
      - int
    doc: "Number of reads included in each alignment call. Note: A new system mapping call is made for each batch (including loading of the genome), so it is advised to use larger values for larger genomes. Default: 1000"
    inputBinding:
      position: 101
      prefix: "--alignment-batch-size"
  - id: normalization_type
    type:
      - 'null'
      - string
    doc: "Choices: \"none\": raw 16-bit DAQ values, \"pA_raw\": pA as in the ONT events (using offset, range and digitization), \"pA\": k-mer-based correction for pA drift as in nanopolish (requires [--pore-model- filename]), \"median\": median and MAD from raw signal. Default: median"
    inputBinding:
      position: 101
      prefix: "--normalization-type"
  - id: pore_model_filename
    type:
      - 'null'
      - File
    doc: "File containing kmer model parameters (level_mean and level_stdv) used in order to compute kmer-based corrected pA values. E.g. https://github.com/jts/nanop olish/blob/master/etc/r9-models/template_median68pA.5m ers.model"
    inputBinding:
      position: 101
      prefix: "--pore-model-filename"
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: "Windosrize the signal at this number of scale values. Negative value disables outlier clipping. Default: 5.000000"
    inputBinding:
      position: 101
      prefix: "--outlier-threshold"
  - id: segmentation_parameters
    type:
      - 'null'
      - type: array
        items: int
    doc: "Specify the 2 parameters for segmentation 1) running neighboring windows width 2) minimum raw observations per genomic base. Sample type defaults: RNA : 12 6 || DNA : 5 3"
    inputBinding:
      position: 101
      prefix: "--segmentation-parameters"
  - id: obs_per_base_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter reads based on observations per base percentile thresholds. Format thresholds as \"percentile:thresh [pctl2:thresh2 ...]\". For example to filter reads with 99th pctl > 200 obs/base or max > 5k obs/base use \"99:200 100:5000\"."
    inputBinding:
      position: 101
      prefix: "--obs-per-base-filter"
  - id: timeout
    type:
      - 'null'
      - int
    doc: "Timeout in seconds for processing a single read. Default: No timeout."
    inputBinding:
      position: 101
      prefix: "--timeout"
  - id: cpts_limit
    type:
      - 'null'
      - int
    doc: "Maximum number of changepoints to find within a single indel group. Default: No limit."
    inputBinding:
      position: 101
      prefix: "--cpts-limit"
  - id: skip_index
    type:
      - 'null'
      - boolean
    doc: "Skip creation of tombo index. This drastically slows downstream tombo commands. Default stores tombo index named \".[--fast5-basedir].[--corrected- group].tombo.index\" to be loaded automatically for downstream commands."
    inputBinding:
      position: 101
      prefix: "--skip-index"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous corrected group in FAST5 files. Note: only effects --corrected-group or --new- corrected-group."
    inputBinding:
      position: 101
      prefix: "--overwrite"
  - id: failed_reads_filename
    type:
      - 'null'
      - string
    doc: "Output failed read filenames with assoicated error. Default: Do not store failed reads."
    inputBinding:
      position: 101
      prefix: "--failed-reads-filename"
  - id: include_event_stdev
    type:
      - 'null'
      - boolean
    doc: "Include corrected event standard deviation in output FAST5 data."
    inputBinding:
      position: 101
      prefix: "--include-event-stdev"
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "FAST5 group created by resquiggle command. Default: RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: "--corrected-group"
  - id: basecall_group
    type:
      - 'null'
      - string
    doc: "FAST5 group obtain original basecalls (under Analyses group). Default: Basecall_1D_000"
    inputBinding:
      position: 101
      prefix: "--basecall-group"
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: "FAST5 subgroup(s) (under /Analyses/[--basecall- group]/) containing basecalls and created within [--corrected-group] containing re-squiggle results. Default: ['BaseCalled_template']"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroups"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 2"
    inputBinding:
      position: 101
      prefix: "--processes"
  - id: align_processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use for parsing and aligning original basecalls. Each process will independently load the genome into memory, so use caution with larger genomes (e.g. human). Default: 1"
    inputBinding:
      position: 101
      prefix: "--align-processes"
  - id: align_threads_per_process
    type:
      - 'null'
      - int
    doc: "Number of threads to use for aligner system call. Default: [--processes] / (2 * [--align-processes)]"
    inputBinding:
      position: 101
      prefix: "--align-threads-per-process"
  - id: resquiggle_processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use for resquiggle algorithm. Default: [--processes] / 2"
    inputBinding:
      position: 101
      prefix: "--resquiggle-processes"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: resquiggled_fast5_dir
    type:
      type: array
      items: Directory
    doc: "FAST5 directory with re-squiggled reads"
    outputBinding:
      glob: "$([inputs.fast5s_basedir.basename])"
  - id: failed_reads
    type:
      - 'null'
      - File
    doc: "File of failed read information written with --failed-reads-filename"
    outputBinding:
      glob: "$(inputs.failed_reads_filename ? [inputs.failed_reads_filename] : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_fasta)
        writable: true
      - entry: $(inputs.fast5s_basedir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
