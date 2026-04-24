cwlVersion: v1.2
class: CommandLineTool
baseCommand: corset
label: corset
doc: "Corset clusters contigs and counts reads from de novo assembled transcriptomes.\n
  \nTool homepage: https://github.com/Oshlack/Corset"
inputs:
  - id: input_bam_files
    type:
      type: array
      items: File
    doc: The input files should be multi-mapped bam files. They can be single, paired-end
      or mixed and do not need to be indexed. A space separated list should be given.
    inputBinding:
      position: 1
  - id: distance_thresholds
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A comma separated list of distance thresholds. The range must be between
      0 and 1. e.g -d 0.4,0.5. If more than one distance threshold is supplied, the
      output filenames will be of the form: counts-<threshold>.txt and clusters-<threshold>.txt'
    inputBinding:
      position: 102
      prefix: -d
  - id: grouping
    type:
      - 'null'
      - string
    doc: Specifies the grouping. i.e. which samples belong to which experimental groups.
      The parameter must be a comma separated list (no spaces), with the groupings
      given in the same order as the bam filename.
    inputBinding:
      position: 102
      prefix: -g
  - id: input_type
    type:
      - 'null'
      - string
    doc: 'The input file type. Options: bam, corset, salmon_eq_classes.'
    inputBinding:
      position: 102
      prefix: -i
  - id: likelihood_ratio_threshold
    type:
      - 'null'
      - float
    doc: The value used for thresholding the log likelihood ratio. By default D =
      17.5 + 2.5 * ndf.
    inputBinding:
      position: 102
      prefix: -D
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: If running with -i corset or salmon_eq_classes, this option will filter out
      reads that align to more than x contigs.
    inputBinding:
      position: 102
      prefix: -x
  - id: min_link_reads
    type:
      - 'null'
      - int
    doc: If running with -i corset or salmon_eq_classes, this will filter out a link
      between contigs if the link is supported by less than this many reads.
    inputBinding:
      position: 102
      prefix: -l
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Filter out any transcripts with fewer than this many reads aligning.
    inputBinding:
      position: 102
      prefix: -m
  - id: overwrite
    type:
      - 'null'
      - string
    doc: Specifies whether the output files should be overwritten if they already
      exist.
    inputBinding:
      position: 102
      prefix: -f
  - id: sample_names
    type:
      - 'null'
      - string
    doc: Specifies the sample names to be used in the header of the output count file.
      This should be a comma separated list without spaces.
    inputBinding:
      position: 102
      prefix: -n
  - id: summary_output
    type:
      - 'null'
      - string
    doc: 'Output a file summarising the read alignments. Options: true, true-stop,
      false.'
    inputBinding:
      position: 102
      prefix: -r
  - id: switch_off_llr_test
    type:
      - 'null'
      - boolean
    doc: Switches off the log likelihood ratio test and should be used for downstream
      differential transcript usage analysis. It will prevent differentially expressed
      transcript being split into different clusters.
    inputBinding:
      position: 102
      prefix: -I
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output filenames. The output files will be of the form <prefix>-counts.txt
      and <prefix>-clusters.txt.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corset:1.09--h077b44d_6
