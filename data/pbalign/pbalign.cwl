cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbalign
label: pbalign
doc: "Align PacBio reads to reference sequences using an algorithm selected from a
  selection of supported alignment algorithms. Input can be a fasta, pls.h5, bas.h5
  or ccs.h5 file or a fofn (file of file names), or an unaligned PacBio BAM. Output
  can be in SAM or BAM format.\n\nTool homepage: https://github.com/PacificBiosciences/pbalign"
inputs:
  - id: input_file
    type: File
    doc: SubreadSet or unaligned .bam (also fasta, pls.h5, bas.h5, ccs.h5 or a fofn).
    inputBinding:
      position: 1
  - id: reference_path
    type: File
    doc: Reference DataSet or FASTA file.
    inputBinding:
      position: 2
  - id: output_file_name
    type: string
    doc: Alignment results file name (.sam, .bam or a dataset .xml).
    inputBinding:
      position: 3
  - id: log_file
    type:
      - 'null'
      - string
    doc: Write the log to file. Default (None) writes to stdout.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: DEBUG, INFO, WARNING, ERROR, CRITICAL.'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to DEBUG.
    inputBinding:
      position: 103
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to CRITICAL to suppress output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Enable Python debugger.
    inputBinding:
      position: 103
      prefix: --pdb
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Print runtime profile at exit.
    inputBinding:
      position: 103
      prefix: --profile
  - id: region_table
    type:
      - 'null'
      - File
    doc: Specify a region table for filtering reads.
    inputBinding:
      position: 103
      prefix: --regionTable
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify a set of user-defined argument values.
    inputBinding:
      position: 103
      prefix: --configFile
  - id: pulse_file
    type:
      - 'null'
      - File
    doc: When input reads are in fasta format and output is a cmp.h5 this option can specify pls.h5 or bas.h5 or FOFN files from which pulse metrics can be loaded for Quiver.
    inputBinding:
      position: 103
      prefix: --pulseFile
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Select an algorithm from blasr, bowtie, and gmap.
    inputBinding:
      position: 103
      prefix: --algorithm
  - id: max_hits
    type:
      - 'null'
      - int
    doc: The maximum number of matches of each read to the reference sequence that will be evaluated.
    inputBinding:
      position: 103
      prefix: --maxHits
  - id: min_anchor_size
    type:
      - 'null'
      - int
    doc: The minimum anchor size defines the length of the read that must match against the reference sequence.
    inputBinding:
      position: 103
      prefix: --minAnchorSize
  - id: max_match
    type:
      - 'null'
      - int
    doc: BLASR maxMatch option. Will be overridden if also set in algorithmOptions.
    inputBinding:
      position: 103
      prefix: --maxMatch
  - id: useccs
    type:
      - 'null'
      - string
    doc: 'Map the ccsSequence to the genome first, then align subreads to the interval that the CCS reads mapped to. Valid choices: useccs, useccsall, useccsdenovo.'
    inputBinding:
      position: 103
      prefix: --useccs
  - id: no_split_subreads
    type:
      - 'null'
      - boolean
    doc: Do not split reads into subreads even if subread regions are available.
    inputBinding:
      position: 103
      prefix: --noSplitSubreads
  - id: concordant
    type:
      - 'null'
      - boolean
    doc: Map subreads of a ZMW to the same genomic location.
    inputBinding:
      position: 103
      prefix: --concordant
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 103
      prefix: --nproc
  - id: algorithm_options
    type:
      - 'null'
      - string
    doc: Pass alignment options through.
    inputBinding:
      position: 103
      prefix: --algorithmOptions
  - id: max_divergence
    type:
      - 'null'
      - float
    doc: The maximum allowed percentage divergence of a read from the reference sequence.
    inputBinding:
      position: 103
      prefix: --maxDivergence
  - id: min_accuracy
    type:
      - 'null'
      - float
    doc: The minimum concordance of alignments that will be evaluated.
    inputBinding:
      position: 103
      prefix: --minAccuracy
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum aligned read length of alignments that will be evaluated.
    inputBinding:
      position: 103
      prefix: --minLength
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: The worst score to output an alignment.
    inputBinding:
      position: 103
      prefix: --scoreCutoff
  - id: hit_policy
    type:
      - 'null'
      - string
    doc: 'How to treat multiple hits. Valid choices: randombest, allbest, random, all, leftmost.'
    inputBinding:
      position: 103
      prefix: --hitPolicy
  - id: filter_adapter_only
    type:
      - 'null'
      - boolean
    doc: If specified, do not report adapter-only hits using annotations with the reference entry.
    inputBinding:
      position: 103
      prefix: --filterAdapterOnly
  - id: unaligned
    type:
      - 'null'
      - string
    doc: Output names of unaligned reads to specified file.
    inputBinding:
      position: 103
      prefix: --unaligned
  - id: seed
    type:
      - 'null'
      - int
    doc: Initialize the random number generator with a non-zero integer. Zero means that the current system time is used.
    inputBinding:
      position: 103
      prefix: --seed
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Specify a directory for saving temporary files.
    inputBinding:
      position: 103
      prefix: --tmpDir
outputs:
  - id: output_file
    type: File
    doc: The output alignment file (SAM or BAM).
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: unaligned_names
    type:
      - 'null'
      - File
    doc: Names of unaligned reads, when --unaligned is used.
    outputBinding:
      glob: $(inputs.unaligned)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbalign:v0.3.2-1-deb-py2_cv1
