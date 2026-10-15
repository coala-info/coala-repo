cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmdtools
label: pmdtools
doc: "Post-mortem damage (PMD) score filtering and deamination analysis of ancient
  DNA reads. Reads a SAM file with the MD field (for example from samtools calmd) on
  standard input; the filtered SAM or the damage table goes to standard output and
  the statistics to standard error.\n\nTool homepage: https://github.com/pontussk/PMDtools"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sam
    type: File
    doc: SAM formatted data with the MD field present (read from standard input)
  - id: maxreads
    type:
      - 'null'
      - int
    doc: 'stop after these many reads have been processed'
    inputBinding:
      position: 101
      prefix: -n
  - id: chromosome
    type:
      - 'null'
      - string
    doc: 'only process data from this chromosome'
    inputBinding:
      position: 101
      prefix: -c
  - id: requiremapq
    type:
      - 'null'
      - int
    doc: 'only process sequences with mapping quality at least this great'
    inputBinding:
      position: 101
      prefix: -m
  - id: readlength
    type:
      - 'null'
      - int
    doc: 'only process sequences with this read length'
    inputBinding:
      position: 101
      prefix: --readlength
  - id: maxlength
    type:
      - 'null'
      - int
    doc: 'only process sequences with max this read length'
    inputBinding:
      position: 101
      prefix: --maxlength
  - id: minlength
    type:
      - 'null'
      - int
    doc: 'only process sequences with min this read length'
    inputBinding:
      position: 101
      prefix: --minlength
  - id: maxgc
    type:
      - 'null'
      - float
    doc: 'only process sequences with max this GC content of the aligning reference sequence'
    inputBinding:
      position: 101
      prefix: --maxGC
  - id: mingc
    type:
      - 'null'
      - float
    doc: 'only process sequences with min this GC content of the aligning reference sequence'
    inputBinding:
      position: 101
      prefix: --minGC
  - id: requirebaseq
    type:
      - 'null'
      - int
    doc: 'only process bases with base quality at least this great'
    inputBinding:
      position: 101
      prefix: -q
  - id: pmdsprim_threshold
    type:
      - 'null'
      - float
    doc: 'PMDSprimthreshold'
    inputBinding:
      position: 101
      prefix: --PMDSprimthreshold
  - id: customterminus
    type:
      - 'null'
      - string
    doc: 'customterminus'
    inputBinding:
      position: 101
      prefix: --customterminus
  - id: range
    type:
      - 'null'
      - int
    doc: 'output deamination patterns for this many positions from the sequence terminus (default=30)'
    inputBinding:
      position: 101
      prefix: --range
  - id: polymorphism_ancient
    type:
      - 'null'
      - float
    doc: 'True biological polymorphism between the ancient individual and the reference sequence'
    inputBinding:
      position: 101
      prefix: --polymorphism_ancient
  - id: polymorphism_contamination
    type:
      - 'null'
      - float
    doc: 'True biological polymorphism between the contaminants and the reference sequence'
    inputBinding:
      position: 101
      prefix: --polymorphism_contamination
  - id: pmd_pparam
    type:
      - 'null'
      - float
    doc: 'parameter p in geometric probability distribution of PMD'
    inputBinding:
      position: 101
      prefix: --PMDpparam
  - id: pmd_constant
    type:
      - 'null'
      - float
    doc: 'constant C in geometric probability distribution of PMD'
    inputBinding:
      position: 101
      prefix: --PMDconstant
  - id: maskterminaldeaminations
    type:
      - 'null'
      - int
    doc: 'mask terminal deaminations'
    inputBinding:
      position: 101
      prefix: --maskterminaldeaminations
  - id: maskterminalbases
    type:
      - 'null'
      - int
    doc: 'mask terminal bases'
    inputBinding:
      position: 101
      prefix: --maskterminalbases
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'only output sequences with PMD score above this threshold'
    inputBinding:
      position: 101
      prefix: -t
  - id: upperthreshold
    type:
      - 'null'
      - float
    doc: 'only output sequences with PMD score below this threshold'
    inputBinding:
      position: 101
      prefix: --upperthreshold
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: 'only output sequences with percent identity above this threshold'
    inputBinding:
      position: 101
      prefix: --perc_identity
  - id: samtoolspath
    type:
      - 'null'
      - string
    doc: 'full path to samtools'
    inputBinding:
      position: 101
      prefix: --samtoolspath
  - id: estimatebase
    type:
      - 'null'
      - int
    doc: 'position of base used fortwo-terminus estimate of contamination'
    inputBinding:
      position: 101
      prefix: --estimatebase
  - id: basic
    type:
      - 'null'
      - int
    doc: 'only output reads with a C>T mismatch this many basepairs from the 5'' end'
    inputBinding:
      position: 101
      prefix: -b
  - id: refseq
    type:
      - 'null'
      - File
    doc: Reference FASTA used to look up the reference sequence (indexed with samtools faidx)
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --refseq
  - id: adjustss
    type:
      - 'null'
      - boolean
    doc: 'strand orientation aware penalization of base qualities for single stranded libraries (use with --CpG for udg-treated ss libs)'
    inputBinding:
      position: 101
      prefix: --adjustss
  - id: deamination
    type:
      - 'null'
      - boolean
    doc: 'output base frequencies in the read at positions where there are C or G in the reference'
    inputBinding:
      position: 101
      prefix: -d
  - id: cpg
    type:
      - 'null'
      - boolean
    doc: 'Only use Cs and Gs in CpG context (alias --UDGplus)'
    inputBinding:
      position: 101
      prefix: --CpG
  - id: ss
    type:
      - 'null'
      - boolean
    doc: 'single stranded'
    inputBinding:
      position: 101
      prefix: --ss
  - id: pmdsprim
    type:
      - 'null'
      - boolean
    doc: 'PMDSprim'
    inputBinding:
      position: 101
      prefix: --PMDSprim
  - id: udghalf
    type:
      - 'null'
      - boolean
    doc: 'only use Cs and Gs in CpG context, the first and last base are used regardless of dinucleotide context'
    inputBinding:
      position: 101
      prefix: --UDGhalf
  - id: udgminus
    type:
      - 'null'
      - boolean
    doc: 'use all bases (placeholder)'
    inputBinding:
      position: 101
      prefix: --UDGminus
  - id: ecolicpg
    type:
      - 'null'
      - boolean
    doc: 'Ecoli CpG (first 5'' position and two 3'' positions and CpG context)'
    inputBinding:
      position: 101
      prefix: --EcoliCpG
  - id: ecoli
    type:
      - 'null'
      - boolean
    doc: 'Ecoli (first 5'' position and two 3'' positions only)'
    inputBinding:
      position: 101
      prefix: --Ecoli
  - id: maskss
    type:
      - 'null'
      - boolean
    doc: 'mask to lower case bases where ref is C (taking strand into account)'
    inputBinding:
      position: 101
      prefix: --maskss
  - id: leipzigsimple
    type:
      - 'null'
      - boolean
    doc: 'Leipzigsimple'
    inputBinding:
      position: 101
      prefix: --Leipzigsimple
  - id: flagss
    type:
      - 'null'
      - boolean
    doc: 'flag SNPs (taking strand into account)'
    inputBinding:
      position: 101
      prefix: --flagss
  - id: nocpg
    type:
      - 'null'
      - boolean
    doc: 'dont use Cs and Gs in CpG context'
    inputBinding:
      position: 101
      prefix: --noCpG
  - id: first
    type:
      - 'null'
      - boolean
    doc: 'outputs the deamination rate at the first position only, but with a standard error'
    inputBinding:
      position: 101
      prefix: --first
  - id: noclips
    type:
      - 'null'
      - boolean
    doc: 'no clips'
    inputBinding:
      position: 101
      prefix: --noclips
  - id: noindels
    type:
      - 'null'
      - boolean
    doc: 'no indels'
    inputBinding:
      position: 101
      prefix: --noindels
  - id: onlyclips
    type:
      - 'null'
      - boolean
    doc: 'only clips'
    inputBinding:
      position: 101
      prefix: --onlyclips
  - id: onlydeletions
    type:
      - 'null'
      - boolean
    doc: 'only deletions'
    inputBinding:
      position: 101
      prefix: --onlydeletions
  - id: onlyinsertions
    type:
      - 'null'
      - boolean
    doc: 'only insertions'
    inputBinding:
      position: 101
      prefix: --onlyinsertions
  - id: nodeletions
    type:
      - 'null'
      - boolean
    doc: 'no deletions'
    inputBinding:
      position: 101
      prefix: --nodeletions
  - id: noinsertions
    type:
      - 'null'
      - boolean
    doc: 'no insertions'
    inputBinding:
      position: 101
      prefix: --noinsertions
  - id: notreverse
    type:
      - 'null'
      - boolean
    doc: 'no reverse complement alignments'
    inputBinding:
      position: 101
      prefix: --notreverse
  - id: print_ds
    type:
      - 'null'
      - boolean
    doc: 'print PMD scores'
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'verbose'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: printalignments
    type:
      - 'null'
      - boolean
    doc: 'print human readable alignments'
    inputBinding:
      position: 101
      prefix: --printalignments
  - id: adjustbaseq
    type:
      - 'null'
      - boolean
    doc: 'apply PMD-aware adjustment of base quality scores specific to C>T and G>A mismatches to the reference'
    inputBinding:
      position: 101
      prefix: -a
  - id: adjustbaseq_all
    type:
      - 'null'
      - boolean
    doc: 'apply PMD-aware adjustment of base quality scores regardless of observed bases'
    inputBinding:
      position: 101
      prefix: --adjustbaseq_all
  - id: dry
    type:
      - 'null'
      - boolean
    doc: 'print SAM input without any filters'
    inputBinding:
      position: 101
      prefix: --dry
  - id: basecomposition
    type:
      - 'null'
      - boolean
    doc: 'basecomposition'
    inputBinding:
      position: 101
      prefix: --basecomposition
  - id: header
    type:
      - 'null'
      - boolean
    doc: 'output the SAM header'
    inputBinding:
      position: 101
      prefix: --header
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: 'two-terminus estimate of contamination'
    inputBinding:
      position: 101
      prefix: --estimate
  - id: platypus
    type:
      - 'null'
      - boolean
    doc: 'output big list of base frequencies for platypus'
    inputBinding:
      position: 101
      prefix: --platypus
  - id: writesamfield
    type:
      - 'null'
      - boolean
    doc: 'add ''DS:Z:<PMDS>'' field to SAM output, will overwrite if already present'
    inputBinding:
      position: 101
      prefix: --writesamfield
  - id: terminal
    type:
      - 'null'
      - boolean
    doc: 'only output reads with a C>T mismatch in either 3'' or 5'' end'
    inputBinding:
      position: 101
      prefix: --terminal
  - id: stats
    type:
      - 'null'
      - boolean
    doc: 'output summarizing statistics to stderr'
    inputBinding:
      position: 101
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: Filtered SAM, or the deamination table, written to standard output
  - id: stderr
    type: stderr
    doc: Summary statistics written to standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmdtools:0.60--hdfd78af_3
stdin: $(inputs.sam.path)
stdout: pmdtools.out
stderr: pmdtools.err
