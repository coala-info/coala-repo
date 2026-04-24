cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsearch-deoverlap.pl
label: cmsearch_tblout_deoverlap_cmsearch-deoverlap.pl
doc: "Remove overlapping hits from cmsearch, cmscan, nhmmer, or hmmsearch tblout files.\n\
  \nTool homepage: https://github.com/nawrockie/cmsearch_tblout_deoverlap"
inputs:
  - id: tblout_file
    type: File
    doc: Single tblout file or a list of tblout files if -l is specified
    inputBinding:
      position: 1
  - id: besthmm
    type:
      - 'null'
      - boolean
    doc: with --hmmsearch, sort by evalue/score of *best* single hit not 
      evalue/score of full seq
    inputBinding:
      position: 102
      prefix: --besthmm
  - id: clanin
    type:
      - 'null'
      - File
    doc: 'only remove overlaps within clans, read clan info from file <s> [default:
      remove all overlaps]'
    inputBinding:
      position: 102
      prefix: --clanin
  - id: cmscan
    type:
      - 'null'
      - boolean
    doc: tblout files are from cmscan v1.1x, not cmsearch
    inputBinding:
      position: 102
      prefix: --cmscan
  - id: debug
    type:
      - 'null'
      - boolean
    doc: run in debugging mode (prints extra info)
    inputBinding:
      position: 102
      prefix: -d
  - id: dirty
    type:
      - 'null'
      - boolean
    doc: keep intermediate files (sorted tblout files)
    inputBinding:
      position: 102
      prefix: --dirty
  - id: fcmsearch
    type:
      - 'null'
      - boolean
    doc: assert tblout files are cmsearch not cmscan
    inputBinding:
      position: 102
      prefix: --fcmsearch
  - id: hmmsearch
    type:
      - 'null'
      - boolean
    doc: tblout files are from hmmsearch v3.x
    inputBinding:
      position: 102
      prefix: --hmmsearch
  - id: invclan
    type:
      - 'null'
      - boolean
    doc: 'w/--clanin, invert clan behavior: do not remove overlaps within clans, remove
      all other overlaps'
    inputBinding:
      position: 102
      prefix: --invclan
  - id: is_list
    type:
      - 'null'
      - boolean
    doc: single command line argument is a list of tblout files, not a single 
      tblout file
    inputBinding:
      position: 102
      prefix: -l
  - id: maxkeep
    type:
      - 'null'
      - boolean
    doc: 'keep hits that only overlap with other hits that are not kept [default:
      remove all hits with higher scoring overlap]'
    inputBinding:
      position: 102
      prefix: --maxkeep
  - id: mdllenin
    type:
      - 'null'
      - File
    doc: w/--overlapout, read model lengths from two-token-per-line-file <s>
    inputBinding:
      position: 102
      prefix: --mdllenin
  - id: nhmmer
    type:
      - 'null'
      - boolean
    doc: tblout files are from nhmmer v3.x
    inputBinding:
      position: 102
      prefix: --nhmmer
  - id: noverlap
    type:
      - 'null'
      - int
    doc: define an overlap as >= <n> or more overlapping residues
    inputBinding:
      position: 102
      prefix: --noverlap
  - id: sort_by_score
    type:
      - 'null'
      - boolean
    doc: 'sort hits by bit score [default: sort by E-value]'
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: run in verbose mode (prints all removed and kept hits)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: overlapout
    type:
      - 'null'
      - File
    doc: create new tabular file with overlap information in <s>
    outputBinding:
      glob: $(inputs.overlapout)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/cmsearch_tblout_deoverlap:0.09--pl5321hdfd78af_0
