cwlVersion: v1.2
class: CommandLineTool
baseCommand: configManta.py
label: manta_configManta.py
doc: 'This script configures the Manta SV analysis pipeline.

  You must specify a BAM or CRAM file for at least one sample.


  Configuration will produce a workflow run script which

  can execute the workflow on a single node or through

  sge and resume any interrupted execution.


  Tool homepage: https://github.com/Illumina/manta'
inputs:
  - id: all_help
    type:
      - 'null'
      - boolean
    doc: show all extended/hidden options
    inputBinding:
      position: 101
      prefix: --allHelp
  - id: call_regions
    type:
      - 'null'
      - File
    doc: 'Optionally provide a bgzip-compressed/tabix-indexed

      BED file containing the set of regions to call. No VCF

      output will be provided outside of these regions. The

      full genome will still be used to estimate statistics

      from the input (such as expected fragment size

      distribution). Only one BED file may be specified.'
    inputBinding:
      position: 101
      prefix: --callRegions
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: config_file
    type:
      - 'null'
      - File
    doc: 'provide a configuration file to override defaults in

      global config file (/usr/local/bin/configManta.py.ini)'
    inputBinding:
      position: 101
      prefix: --config
  - id: exome
    type:
      - 'null'
      - boolean
    doc: 'Set options for WES input: turn off depth filters'
    inputBinding:
      position: 101
      prefix: --exome
  - id: normal_bam
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bam
    doc: 'Normal sample BAM or CRAM file. May be specified more

      than once, multiple inputs will be treated as each BAM

      file representing a different sample.'
    inputBinding:
      position: 101
    secondaryFiles: &id001
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: reference_fasta
    type: File
    secondaryFiles:
      - .fai
    doc: samtools-indexed reference fasta file
    inputBinding:
      position: 101
      prefix: --referenceFasta
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'Set options for RNA-Seq input. Must specify exactly

      one bam input file'
    inputBinding:
      position: 101
      prefix: --rna
  - id: run_dir
    type:
      - 'null'
      - string
    doc: 'Name of directory to be created where all workflow

      scripts and output will be written. Each analysis

      requires a separate directory.'
    inputBinding:
      position: 101
      prefix: --runDir
  - id: tumor_bam
    type:
      - 'null'
      - File
    doc: 'Tumor sample BAM or CRAM file. Only up to one tumor

      bam file accepted.'
    inputBinding:
      position: 101
      prefix: --tumorBam
    secondaryFiles: *id001
  - id: unstranded_rna
    type:
      - 'null'
      - boolean
    doc: 'Set if RNA-Seq input is unstranded: Allows splice-

      junctions on either strand'
    inputBinding:
      position: 101
      prefix: --unstrandedRNA
  - id: existing_align_stats_file
    type:
      - 'null'
      - File
    doc: Pre-calculated alignment statistics file. Skips alignment stats calculation.
    inputBinding:
      position: 101
      prefix: --existingAlignStatsFile
  - id: use_existing_chrom_depths
    type:
      - 'null'
      - boolean
    doc: Use pre-calculated chromosome depths.
    inputBinding:
      position: 101
      prefix: --useExistingChromDepths
  - id: retain_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep all temporary files (for workflow debugging)
    inputBinding:
      position: 101
      prefix: --retainTempFiles
  - id: generate_evidence_bam
    type:
      - 'null'
      - boolean
    doc: Generate a bam of supporting reads for all SVs
    inputBinding:
      position: 101
      prefix: --generateEvidenceBam
  - id: output_contig
    type:
      - 'null'
      - boolean
    doc: Output assembled contig sequences in VCF file
    inputBinding:
      position: 101
      prefix: --outputContig
  - id: scan_size_mb
    type:
      - 'null'
      - int
    doc: 'Maximum sequence region size (in megabases) scanned by each task during
      SV Locus graph generation. (default: 12)'
    inputBinding:
      position: 101
      prefix: --scanSizeMb
  - id: region
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --region
    doc: 'Limit the analysis to a region of the genome for debugging purposes. Examples:
      ''chr20'' (whole chromosome), ''chr2:100-2000''. May be given several times;
      regions must not overlap.'
    inputBinding:
      position: 101
  - id: call_mem_mb
    type:
      - 'null'
      - int
    doc: Set default task memory requirement (in megabytes) for common tasks.
    inputBinding:
      position: 101
      prefix: --callMemMb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: run_dir_dir
    type:
      - 'null'
      - Directory
    doc: Name of directory to be created where all workflow scripts and output will
      be written. Each analysis requires a separate directory.
    outputBinding:
      glob: $(inputs.run_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta_configManta.py.out
