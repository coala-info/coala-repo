cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cojac
  - cooc-mutbamscan
label: cojac_cooc-mutbamscan
doc: "Scan amplicon (covered by long read pairs) for mutation cooccurrence\n\nTool
  homepage: https://github.com/cbg-ethz/cojac"
inputs:
  - id: alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: alignment files
    inputBinding:
      position: 101
      prefix: --alignments
  - id: batchname_sep
    type:
      - 'null'
      - string
    doc: concatenate samplename/batchname from samples tsv
    inputBinding:
      position: 101
      prefix: --batchname
  - id: bedfile
    type:
      - 'null'
      - File
    doc: 'bedfile defining the amplicons, with format: ref\tstart\tstop\tamp_num\tpool\tstrand'
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: comment
    type:
      - 'null'
      - boolean
    doc: 'add comments in the out amplicon YAML with names from BED file (default:
      comment the YAML)'
    inputBinding:
      position: 101
      prefix: --comment
  - id: cooc
    type:
      - 'null'
      - int
    doc: minimum number of cooccurrences to search for
    inputBinding:
      position: 101
      prefix: --cooc
  - id: dump
    type:
      - 'null'
      - boolean
    doc: dump the python object to the terminal
    inputBinding:
      position: 101
      prefix: --dump
  - id: fix_subset
    type:
      - 'null'
      - boolean
    doc: Fix variants attribution when cooccurrence are subset/superset of other
      variants
    inputBinding:
      position: 101
      prefix: --fix-subset
  - id: fs
    type:
      - 'null'
      - boolean
    doc: Fix variants attribution when cooccurrence are subset/superset of other
      variants
    inputBinding:
      position: 101
      prefix: --fs
  - id: in_amp
    type:
      - 'null'
      - File
    doc: use the supplied YAML file to query amplicons instead of building it 
      from BED + voc's DIR
    inputBinding:
      position: 101
      prefix: --in-amp
  - id: in_amplicons
    type:
      - 'null'
      - File
    doc: use the supplied YAML file to query amplicons instead of building it 
      from BED + voc's DIR
    inputBinding:
      position: 101
      prefix: --amplicons
  - id: in_amplicons_yaml
    type:
      - 'null'
      - File
    doc: use the supplied YAML file to query amplicons instead of building it 
      from BED + voc's DIR
    inputBinding:
      position: 101
      prefix: --in-amplicons
  - id: name
    type:
      - 'null'
      - string
    doc: when using alignment files, name to use for the output
    inputBinding:
      position: 101
      prefix: --name
  - id: no_comment
    type:
      - 'null'
      - boolean
    doc: 'add comments in the out amplicon YAML with names from BED file (default:
      comment the YAML)'
    inputBinding:
      position: 101
      prefix: --no-comment
  - id: no_fix_subset
    type:
      - 'null'
      - boolean
    doc: Fix variants attribution when cooccurrence are subset/superset of other
      variants
    inputBinding:
      position: 101
      prefix: --no-fix-subset
  - id: no_fs
    type:
      - 'null'
      - boolean
    doc: Fix variants attribution when cooccurrence are subset/superset of other
      variants
    inputBinding:
      position: 101
      prefix: --no-fs
  - id: no_sort_bedfile
    type:
      - 'null'
      - boolean
    doc: "sort the bedfile by 'reference name' and 'start position' (default: sorted)"
    inputBinding:
      position: 101
      prefix: --no-sort
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: V-pipe work directory prefix for where to look at align files when 
      using TSV samples list
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - string
    doc: reference to look for in alignment files
    inputBinding:
      position: 101
      prefix: --reference
  - id: samples
    type:
      - 'null'
      - File
    doc: V-pipe samples list tsv
    inputBinding:
      position: 101
      prefix: --samples
  - id: sort_bedfile
    type:
      - 'null'
      - boolean
    doc: "sort the bedfile by 'reference name' and 'start position' (default: sorted)"
    inputBinding:
      position: 101
      prefix: --sort
  - id: voc
    type:
      - 'null'
      - type: array
        items: string
    doc: individual yamls defining the variant of concerns
    inputBinding:
      position: 101
      prefix: --voc
  - id: vocdir
    type:
      - 'null'
      - Directory
    doc: directory containing the yamls defining the variant of concerns
    inputBinding:
      position: 101
      prefix: --vocdir
  - id: with_revert
    type:
      - 'null'
      - boolean
    doc: also include reverts when compiling amplicons (requires VOC YAML files 
      with revert category)
    inputBinding:
      position: 101
      prefix: --rev
  - id: without_revert
    type:
      - 'null'
      - boolean
    doc: also include reverts when compiling amplicons (requires VOC YAML files 
      with revert category)
    inputBinding:
      position: 101
      prefix: --no-rev
outputs:
  - id: out_amplicons
    type:
      - 'null'
      - File
    doc: output amplicon query in a YAML file
    outputBinding:
      glob: $(inputs.out_amplicons)
  - id: out_amplicons_yaml
    type:
      - 'null'
      - File
    doc: output amplicon query in a YAML file
    outputBinding:
      glob: $(inputs.out_amplicons_yaml)
  - id: json
    type:
      - 'null'
      - File
    doc: output results to a JSON file
    outputBinding:
      glob: $(inputs.json)
  - id: yaml
    type:
      - 'null'
      - File
    doc: output results to a yaml file
    outputBinding:
      glob: $(inputs.yaml)
  - id: tsv
    type:
      - 'null'
      - File
    doc: output results to a (raw) tsv file
    outputBinding:
      glob: $(inputs.tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
