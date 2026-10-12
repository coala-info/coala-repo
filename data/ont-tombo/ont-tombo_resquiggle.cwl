cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - resquiggle
label: ont-tombo_resquiggle
doc: "Re-annotate raw signal with genomic alignment from existing basecalls.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5s_basedir
    type: Directory
    doc: "Directory containing fast5 files. All files ending in \"fast5\" found recursively within this base directory will be processed."
    inputBinding:
      position: 1
      valueFrom: "$(self.basename)"
  - id: reference
    type: File
    doc: "Reference genome/transcriptome FASTA file or minimap2 index (with \"map-ont\" preset) for mapping."
    inputBinding:
      position: 2
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical DNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--dna"
  - id: rna
    type:
      - 'null'
      - boolean
    doc: "Explicitly select canonical RNA model. Default: Automatically determine from FAST5s"
    inputBinding:
      position: 101
      prefix: "--rna"
  - id: obs_per_base_filter
    type:
      - 'null'
      - string[]
    doc: "Filter reads based on observations per base percentile thresholds. Format thresholds as \"percentile:thresh [pctl2:thresh2 ...]\". For example to filter reads with 99th pctl > 200 obs/base or max > 5k obs/base use \"99:200 100:5000\"."
    inputBinding:
      position: 101
      prefix: "--obs-per-base-filter"
  - id: q_score
    type:
      - 'null'
      - float
    doc: "Q-score threshold for filtering low quality reads. Default: 0.000000"
    inputBinding:
      position: 101
      prefix: "--q-score"
  - id: signal_matching_score
    type:
      - 'null'
      - float
    doc: "Observed to expected signal matching score (higher score indicates poor matching). Sample type defaults: RNA : 2 || DNA : 1.1"
    inputBinding:
      position: 101
      prefix: "--signal-matching-score"
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes. Default: 1"
    inputBinding:
      position: 101
      prefix: "--processes"
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
      - string[]
    doc: "FAST5 subgroup(s) (under /Analyses/[--basecall- group]/) containing basecalls and created within [--corrected-group] containing re-squiggle results. Default: ['BaseCalled_template']"
    inputBinding:
      position: 101
      prefix: "--basecall-subgroups"
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
  - id: num_most_common_errors
    type:
      - 'null'
      - int
    doc: "Dynamically show this many most common errors so far through run. Default: 0; Just show progress"
    inputBinding:
      position: 101
      prefix: "--num-most-common-errors"
  - id: print_advanced_arguments
    type:
      - 'null'
      - boolean
    doc: "Print advanced re-squiggle arguments and exit."
    inputBinding:
      position: 101
      prefix: "--print-advanced-arguments"
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
      glob: "$(inputs.fast5s_basedir.basename)"
  - id: failed_reads
    type:
      - 'null'
      - File
    doc: "File of failed read information written with --failed-reads-filename"
    outputBinding:
      glob: "$(inputs.failed_reads_filename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5s_basedir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
