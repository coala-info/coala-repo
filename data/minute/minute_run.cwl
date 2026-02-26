cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minute
  - run
label: minute_run
doc: "Run the Minute pipeline\n\nCalls Snakemake to produce all the output files.\n\
  \nminute run will execute a default set of rules and produce a set of final bigWig\n\
  files and a MultiQC report.\n\nAny further arguments that this wrapper script does
  not recognize are forwarded\nto Snakemake. This can be used to provide file(s) to
  create, targets to run or\nany other Snakemake options. For example, this runs the
  \"full\" target (including\nfingerprinting) in dry-run mode:\n\n    minute run --dryrun
  full\n\nAlternative target rules:\n\n    final (default) Default pipeline that does
  not include fingerprint plots.\n                    It runs quicker than the full
  version.\n\n    full            Runs the default pipeline plus deepTools fingerprint.
  This\n                    is a computationally expensive step that can significantly\n\
  \                    increase runtime on highly multiplexed minute runs.\n\n   \
  \ quick           Runs the default pipeline but reduces the amount of bigWig\n \
  \                   files produced. Only scaled bigWig files will be generated\n\
  \                    for treatments, and unscaled bigWig files will be generated\n\
  \                    for controls.\n\n    pooled_only     Runs the default pipeline,
  but only generates the bigWig\n                    files corresponding to the pooled
  replicates.\n\n    pooled_only_minimal Runs the default pipeline, but it only generates
  bigWig\n                    files for the pools present in groups.tsv, scaled for\n\
  \                    treatment libraries and unscaled for the controls.\n\n    mapq_bigwigs\
  \    Generates an additional set of bigWig files where each final\n            \
  \        BAM alignment is also filtered for mapping quality. This\n            \
  \        requires a mapping_quality_bigwig parameter value higher\n            \
  \        than zero in the minute.yaml configuration.\n\n    no_bigwigs      Runs
  the default pipeline but skips the bigWig generation\n                    entirely.
  This is useful for a quick check on QC metrics,\n                    since the rest
  of the steps are significantly faster than\n                    bigWig generation.\n\
  \n    no_scaling      Skips entirely the scaling statistics and bigWigs. Produces\n\
  \                    only unscaled bigWigs and a MultiQC report with only\n    \
  \                non-scaling QC metrics.\n\nSee minute documentation for a more
  detailed description of the available target\nrules and their outputs.\n\nRun 'snakemake
  --help' or see the Snakemake documentation to see valid snakemake\narguments.\n\n\
  Tool homepage: https://github.com/NBISweden/minute/"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: "Run on at most N CPU cores in parallel. Default: Use as\n              \
      \     many cores as available)"
    inputBinding:
      position: 101
      prefix: --cores
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not execute anything
    inputBinding:
      position: 101
      prefix: --dryrun
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
stdout: minute_run.out
