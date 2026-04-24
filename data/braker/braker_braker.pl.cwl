cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker.pl
label: braker_braker.pl
doc: "Pipeline for predicting genes with GeneMark-ET and AUGUSTUS with RNA-Seq\n\n
  Tool homepage: https://github.com/Gaius-Augustus/BRAKER"
inputs:
  - id: alternatives_from_evidence
    type:
      - 'null'
      - boolean
    doc: Output alternative transcripts based on explicit evidence from hints
    inputBinding:
      position: 101
      prefix: --alternatives-from-evidence
  - id: augustus_config_path
    type:
      - 'null'
      - Directory
    doc: Set path to AUGUSTUS (if not specified as environment variable). Has higher
      priority than environment variable.
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_CONFIG_PATH
  - id: bam
    type:
      - 'null'
      - File
    doc: bam file with spliced alignments from RNA-Seq
    inputBinding:
      position: 101
      prefix: --bam
  - id: bamtools_path
    type:
      - 'null'
      - Directory
    doc: Set path to bamtools (if not specified as environment variable). Has higher
      priority than the environment variable.
    inputBinding:
      position: 101
      prefix: --BAMTOOLS_PATH
  - id: cores
    type:
      - 'null'
      - int
    doc: Specifies the maximum number of cores that can be used during computation
    inputBinding:
      position: 101
      prefix: --cores
  - id: extrinsic_cfg_file
    type:
      - 'null'
      - File
    doc: Optional. This file contains the list of used sources for the hints and their
      boni and mali.
    inputBinding:
      position: 101
      prefix: --extrinsicCfgFile
  - id: filter_out_short
    type:
      - 'null'
      - boolean
    doc: Discard training genes that are supported by RNA-Seq but are considered too
      short based on specific criteria.
    inputBinding:
      position: 101
      prefix: --filterOutShort
  - id: fungus
    type:
      - 'null'
      - boolean
    doc: 'GeneMark-ET option: run algorithm with branch point model (most useful for
      fungal genomes)'
    inputBinding:
      position: 101
      prefix: --fungus
  - id: genemark_path
    type:
      - 'null'
      - Directory
    doc: Set path to GeneMark-ET (if not specified as environment variable). Has higher
      priority than environment variable.
    inputBinding:
      position: 101
      prefix: --GENEMARK_PATH
  - id: genome
    type: File
    doc: fasta file with DNA sequences
    inputBinding:
      position: 101
      prefix: --genome
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: Output in GFF3 format.
    inputBinding:
      position: 101
      prefix: --gff3
  - id: hints
    type:
      - 'null'
      - File
    doc: File that contains introns extracted from RNA-Seq data in gff format or hints
      from additional extrinsic sources.
    inputBinding:
      position: 101
      prefix: --hints
  - id: opt_cfg_file
    type:
      - 'null'
      - File
    doc: Optional custom config file for AUGUSTUS (see --hints).
    inputBinding:
      position: 101
      prefix: --optCfgFile
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (except for species parameter files)
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: samtools_path
    type:
      - 'null'
      - Directory
    doc: Optionally set path to samtools (if not specified as environment variable)
      to fix BAM files automatically.
    inputBinding:
      position: 101
      prefix: --SAMTOOLS_PATH
  - id: skip_genemark_et
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-ET and use provided GeneMark-ET output
    inputBinding:
      position: 101
      prefix: --skipGeneMark-ET
  - id: skip_optimize
    type:
      - 'null'
      - boolean
    doc: Skip optimize parameter step (not recommended).
    inputBinding:
      position: 101
      prefix: --skipOptimize
  - id: softmasking
    type:
      - 'null'
      - string
    doc: Softmasking option for soft masked genome files. Set to 'on' or '1'
    inputBinding:
      position: 101
      prefix: --softmasking
  - id: species
    type:
      - 'null'
      - string
    doc: Species name. Existing species will not be overwritten.
    inputBinding:
      position: 101
      prefix: --species
  - id: use_existing
    type:
      - 'null'
      - boolean
    doc: Use the present config and parameter files if they exist for 'species'
    inputBinding:
      position: 101
      prefix: --useexisting
  - id: utr
    type:
      - 'null'
      - boolean
    doc: Predict untranslated regions. Default is off.
    inputBinding:
      position: 101
      prefix: --UTR
outputs:
  - id: working_dir
    type:
      - 'null'
      - Directory
    doc: Set path to working directory. In the working directory results and temporary
      files are stored
    outputBinding:
      glob: $(inputs.working_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braker:1.9--1
