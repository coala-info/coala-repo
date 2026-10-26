cwlVersion: v1.2
class: CommandLineTool
baseCommand: v-build.pl
label: vadr_v-build.pl
doc: 'build homology model of a single sequence for feature annotation


  Tool homepage: https://github.com/ncbi/vadr'
inputs:
  - id: accession
    type: string
    doc: accession of the sequence to build a model of
    inputBinding:
      position: 1
  - id: output_directory
    type: string
    doc: path to output directory to create
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: force; if dir <output directory> exists, overwrite it
    inputBinding:
      position: 103
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose; output commands to stdout as they're run
    inputBinding:
      position: 103
      prefix: -v
  - id: stk
    type:
      - 'null'
      - File
    doc: read single sequence stockholm 'alignment' from <s>
    inputBinding:
      position: 103
      prefix: --stk
  - id: infa
    type:
      - 'null'
      - File
    doc: read single sequence fasta file from <s>, don't fetch it
    inputBinding:
      position: 103
      prefix: --infa
  - id: inft
    type:
      - 'null'
      - File
    doc: read feature table file from <s>, don't fetch it
    inputBinding:
      position: 103
      prefix: --inft
  - id: ftfetch1
    type:
      - 'null'
      - boolean
    doc: fetch feature table with efetch -format ft
    inputBinding:
      position: 103
      prefix: --ftfetch1
  - id: ftfetch2
    type:
      - 'null'
      - boolean
    doc: fetch feature table with efetch -format gbc | xml2tbl
    inputBinding:
      position: 103
      prefix: --ftfetch2
  - id: gb
    type:
      - 'null'
      - boolean
    doc: parse a genbank file, not a feature table file
    inputBinding:
      position: 103
      prefix: --gb
  - id: ingb
    type:
      - 'null'
      - File
    doc: read genbank file from <s>, don't fetch it
    inputBinding:
      position: 103
      prefix: --ingb
  - id: addminfo
    type:
      - 'null'
      - File
    doc: add feature info from model info file <s>
    inputBinding:
      position: 103
      prefix: --addminfo
  - id: forcelong
    type:
      - 'null'
      - boolean
    doc: allow long models > 25Kb in length
    inputBinding:
      position: 103
      prefix: --forcelong
  - id: keep
    type:
      - 'null'
      - boolean
    doc: do not remove intermediate files, keep them all on disk
    inputBinding:
      position: 103
      prefix: --keep
  - id: fall
    type:
      - 'null'
      - boolean
    doc: store info for all feature types (except those in --fskip)
    inputBinding:
      position: 103
      prefix: --fall
  - id: fadd
    type:
      - 'null'
      - string
    doc: also store feature types in comma separated string <s>
    inputBinding:
      position: 103
      prefix: --fadd
  - id: fskip
    type:
      - 'null'
      - string
    doc: do not store info for feature types in comma separated string <s>
    inputBinding:
      position: 103
      prefix: --fskip
  - id: qall
    type:
      - 'null'
      - boolean
    doc: store info for all qualifiers (except those in --qskip)
    inputBinding:
      position: 103
      prefix: --qall
  - id: qadd
    type:
      - 'null'
      - string
    doc: also store info for qualifiers in comma separated string <s>
    inputBinding:
      position: 103
      prefix: --qadd
  - id: qftradd
    type:
      - 'null'
      - string
    doc: --qadd <s2> only applies for feature types in comma separated string <s>
    inputBinding:
      position: 103
      prefix: --qftradd
  - id: qskip
    type:
      - 'null'
      - string
    doc: do not store info for qualifiers in comma separated string <s>
    inputBinding:
      position: 103
      prefix: --qskip
  - id: noaddgene
    type:
      - 'null'
      - boolean
    doc: do not add gene qualifiers from gene features to overlapping features
    inputBinding:
      position: 103
      prefix: --noaddgene
  - id: nosplice
    type:
      - 'null'
      - boolean
    doc: do not check and add valid splice sites qualifiers for CDS
    inputBinding:
      position: 103
      prefix: --nosplice
  - id: ssplice
    type:
      - 'null'
      - boolean
    doc: exit if any noncanonical splice sites exist in any CDS
    inputBinding:
      position: 103
      prefix: --ssplice
  - id: group
    type:
      - 'null'
      - string
    doc: specify model group is <s>
    inputBinding:
      position: 103
      prefix: --group
  - id: subgroup
    type:
      - 'null'
      - string
    doc: specify model subgroup is <s>
    inputBinding:
      position: 103
      prefix: --subgroup
  - id: ttbl
    type:
      - 'null'
      - int
    doc: use NCBI translation table <n> to translate CDS [1]
    inputBinding:
      position: 103
      prefix: --ttbl
  - id: cmn
    type:
      - 'null'
      - int
    doc: set number of seqs for glocal fwd HMM calibration to <n>
    inputBinding:
      position: 103
      prefix: --cmn
  - id: cmp7ml
    type:
      - 'null'
      - boolean
    doc: set CM's filter p7 HMM as the ML p7 HMM
    inputBinding:
      position: 103
      prefix: --cmp7ml
  - id: cmere
    type:
      - 'null'
      - float
    doc: set CM relative entropy target to <x>
    inputBinding:
      position: 103
      prefix: --cmere
  - id: cmeset
    type:
      - 'null'
      - float
    doc: 'set CM eff seq # for CM to <x>'
    inputBinding:
      position: 103
      prefix: --cmeset
  - id: cmemaxseq
    type:
      - 'null'
      - float
    doc: 'set CM maximum alowed eff seq # for CM to <x>'
    inputBinding:
      position: 103
      prefix: --cmemaxseq
  - id: cmnoh3pri
    type:
      - 'null'
      - boolean
    doc: do not use --noh3pri option with cmbuild
    inputBinding:
      position: 103
      prefix: --cmnoh3pri
  - id: cminfile
    type:
      - 'null'
      - File
    doc: read cmbuild options from file <s>, one per line
    inputBinding:
      position: 103
      prefix: --cminfile
  - id: skipbuild
    type:
      - 'null'
      - boolean
    doc: skip the cmbuild and blastn db creation steps
    inputBinding:
      position: 103
      prefix: --skipbuild
  - id: onlyurl
    type:
      - 'null'
      - boolean
    doc: output genbank file url for accession and exit
    inputBinding:
      position: 103
      prefix: --onlyurl
  - id: ftrinfo
    type:
      - 'null'
      - boolean
    doc: create file with internal feature information
    inputBinding:
      position: 103
      prefix: --ftrinfo
  - id: sgminfo
    type:
      - 'null'
      - boolean
    doc: create file with internal segment information
    inputBinding:
      position: 103
      prefix: --sgminfo
  - id: nosig2mat
    type:
      - 'null'
      - boolean
    doc: do not treat sig_peptide as mat_peptide
    inputBinding:
      position: 103
      prefix: --nosig2mat
  - id: intlen
    type:
      - 'null'
      - int
    doc: set min length of intron to check for splice sites to <n> [40]
    inputBinding:
      position: 103
      prefix: --intlen
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: output directory with the model files
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_v-build.pl.out
