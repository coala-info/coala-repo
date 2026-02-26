cwlVersion: v1.2
class: CommandLineTool
baseCommand: configManta.py
label: manta_configManta.py
doc: "This script configures the Manta SV analysis pipeline.\nYou must specify a BAM
  or CRAM file for at least one sample.\n\nConfiguration will produce a workflow run
  script which\ncan execute the workflow on a single node or through\nsge and resume
  any interrupted execution.\n\nTool homepage: https://github.com/Illumina/manta"
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
    doc: "Optionally provide a bgzip-compressed/tabix-indexed\nBED file containing
      the set of regions to call. No VCF\noutput will be provided outside of these
      regions. The\nfull genome will still be used to estimate statistics\nfrom the
      input (such as expected fragment size\ndistribution). Only one BED file may
      be specified."
    inputBinding:
      position: 101
      prefix: --callRegions
  - id: config_file
    type:
      - 'null'
      - File
    doc: "provide a configuration file to override defaults in\nglobal config file
      (/usr/local/bin/configManta.py.ini)"
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
    doc: "Normal sample BAM or CRAM file. May be specified more\nthan once, multiple
      inputs will be treated as each BAM\nfile representing a different sample."
    inputBinding:
      position: 101
      prefix: --bam
  - id: normal_bam_alt
    type:
      - 'null'
      - type: array
        items: File
    doc: "Normal sample BAM or CRAM file. May be specified more\nthan once, multiple
      inputs will be treated as each BAM\nfile representing a different sample."
    inputBinding:
      position: 101
      prefix: --normalBam
  - id: reference_fasta
    type: File
    doc: samtools-indexed reference fasta file
    inputBinding:
      position: 101
      prefix: --referenceFasta
  - id: rna
    type:
      - 'null'
      - boolean
    doc: "Set options for RNA-Seq input. Must specify exactly\none bam input file"
    inputBinding:
      position: 101
      prefix: --rna
  - id: run_dir
    type:
      - 'null'
      - Directory
    doc: "Name of directory to be created where all workflow\nscripts and output will
      be written. Each analysis\nrequires a separate directory."
    default: MantaWorkflow
    inputBinding:
      position: 101
      prefix: --runDir
  - id: tumor_bam
    type:
      - 'null'
      - File
    doc: "Tumor sample BAM or CRAM file. Only up to one tumor\nbam file accepted."
    inputBinding:
      position: 101
      prefix: --tumorBam
  - id: tumor_bam_alt
    type:
      - 'null'
      - File
    doc: "Tumor sample BAM or CRAM file. Only up to one tumor\nbam file accepted."
    inputBinding:
      position: 101
      prefix: --tumourBam
  - id: unstranded_rna
    type:
      - 'null'
      - boolean
    doc: "Set if RNA-Seq input is unstranded: Allows splice-\njunctions on either
      strand"
    inputBinding:
      position: 101
      prefix: --unstrandedRNA
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
stdout: manta_configManta.py.out
