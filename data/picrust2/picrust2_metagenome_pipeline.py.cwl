cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagenome_pipeline.py
label: picrust2_metagenome_pipeline.py
doc: "Per-sample metagenome functional profiles are generated based on the predicted functions for each study sequence. The sequence abundance table is normalized by the predicted number of marker gene copies by default.\n\nTool homepage: https://github.com/picrust/picrust2"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'Input table of sequence abundances (BIOM, TSV, or mothur shared file format).'
    inputBinding:
      position: 101
      prefix: --input
  - id: function
    type: File
    doc: 'Table of predicted gene family copy numbers (output of hsp.py).'
    inputBinding:
      position: 101
      prefix: --function
  - id: marker
    type:
      - 'null'
      - File
    doc: 'Table of predicted marker gene copy numbers (output of hsp.py, typically for 16S).'
    inputBinding:
      position: 101
      prefix: --marker
  - id: max_nsti
    type:
      - 'null'
      - float
    doc: 'Sequences with NSTI values above this value will be excluded (default: 2).'
    inputBinding:
      position: 101
      prefix: --max_nsti
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads across all samples for each input ASV (default: 1).'
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: min_samples
    type:
      - 'null'
      - int
    doc: 'Minimum number of samples that an ASV needs to be identified within (default: 1).'
    inputBinding:
      position: 101
      prefix: --min_samples
  - id: strat_out
    type:
      - 'null'
      - boolean
    doc: 'Output table stratified by sequences as well.'
    inputBinding:
      position: 101
      prefix: --strat_out
  - id: wide_table
    type:
      - 'null'
      - boolean
    doc: 'Output wide-format stratified table of metagenome predictions when strat_out is set (deprecated).'
    inputBinding:
      position: 101
      prefix: --wide_table
  - id: skip_norm
    type:
      - 'null'
      - boolean
    doc: 'Skip normalizing sequence abundances by predicted marker gene copy numbers.'
    inputBinding:
      position: 101
      prefix: --skip_norm
  - id: out_dir
    type: string
    doc: 'Output directory for metagenome predictions.'
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: output_directory
    type: Directory
    doc: 'Metagenome predictions folder (pred_metagenome_unstrat.tsv.gz, seqtab_norm.tsv.gz, weighted_nsti.tsv.gz).'
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
