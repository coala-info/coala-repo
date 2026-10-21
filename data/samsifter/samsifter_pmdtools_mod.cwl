cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmdtools_mod
label: samsifter_pmdtools_mod
doc: "Estimate post-mortem degradation (PMD) scores of reads in SAM files with MD tags (modified PMDtools shipped with SamSifter)\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM formatted data with MD field present (read from standard input)"
  - id: pmdsprim
    type:
      - 'null'
      - boolean
    doc: "PMDSprim"
    inputBinding:
      position: 2
      prefix: --PMDSprim
  - id: pmdsprimthreshold
    type:
      - 'null'
      - float
    doc: "PMDSprimthreshold"
    inputBinding:
      position: 3
      prefix: --PMDSprimthreshold
  - id: first
    type:
      - 'null'
      - boolean
    doc: "outputs the deamination rate at the first position only, but with a standard error"
    inputBinding:
      position: 4
      prefix: --first
  - id: range
    type:
      - 'null'
      - int
    doc: "output deamination patterns for this many positions from the sequence terminus (default=30)"
    inputBinding:
      position: 5
      prefix: --range
  - id: noclips
    type:
      - 'null'
      - boolean
    doc: "no clips"
    inputBinding:
      position: 6
      prefix: --noclips
  - id: noindels
    type:
      - 'null'
      - boolean
    doc: "no indels"
    inputBinding:
      position: 7
      prefix: --noindels
  - id: onlyclips
    type:
      - 'null'
      - boolean
    doc: "only clips"
    inputBinding:
      position: 8
      prefix: --onlyclips
  - id: onlydeletions
    type:
      - 'null'
      - boolean
    doc: "only deletions"
    inputBinding:
      position: 9
      prefix: --onlydeletions
  - id: onlyinsertions
    type:
      - 'null'
      - boolean
    doc: "only insertions"
    inputBinding:
      position: 10
      prefix: --onlyinsertions
  - id: nodeletions
    type:
      - 'null'
      - boolean
    doc: "no deletions"
    inputBinding:
      position: 11
      prefix: --nodeletions
  - id: noinsertions
    type:
      - 'null'
      - boolean
    doc: "no insertions"
    inputBinding:
      position: 12
      prefix: --noinsertions
  - id: notreverse
    type:
      - 'null'
      - boolean
    doc: "no reverse complement alignments"
    inputBinding:
      position: 13
      prefix: --notreverse
  - id: adjustbaseq
    type:
      - 'null'
      - boolean
    doc: "apply PMD-aware adjustment of base quality scores specific to C>T and G>A mismatches to the reference"
    inputBinding:
      position: 14
      prefix: -a
  - id: adjustbaseq_all
    type:
      - 'null'
      - boolean
    doc: "apply PMD-aware adjustment of base quality scores regardless of observed bases"
    inputBinding:
      position: 15
      prefix: --adjustbaseq_all
  - id: samtoolspath
    type:
      - 'null'
      - string
    doc: "full path to samtools"
    inputBinding:
      position: 16
      prefix: --samtoolspath
  - id: basecomposition
    type:
      - 'null'
      - boolean
    doc: "basecomposition"
    inputBinding:
      position: 17
      prefix: --basecomposition
  - id: refseq
    type:
      - 'null'
      - File
    doc: "refseq"
    inputBinding:
      position: 18
      prefix: -r
  - id: estimate
    type:
      - 'null'
      - boolean
    doc: "two-terminus estimate of contamination"
    inputBinding:
      position: 19
      prefix: --estimate
  - id: estimatebase
    type:
      - 'null'
      - int
    doc: "position of base used for two-terminus estimate of contamination"
    inputBinding:
      position: 20
      prefix: --estimatebase
  - id: basic
    type:
      - 'null'
      - int
    doc: "only output reads with a C>T mismatch this many basepairs from the 5' end"
    inputBinding:
      position: 21
      prefix: -b
  - id: pmdpparam
    type:
      - 'null'
      - float
    doc: "parameter p in geometric probability distribution of PMD"
    inputBinding:
      position: 22
      prefix: --PMDpparam
  - id: pmdconstant
    type:
      - 'null'
      - float
    doc: "constant C in geometric probability distribution of PMD"
    inputBinding:
      position: 23
      prefix: --PMDconstant
  - id: polymorphism_ancient
    type:
      - 'null'
      - float
    doc: "True biological polymorphism between the ancient individual and the reference sequence"
    inputBinding:
      position: 24
      prefix: --polymorphism_ancient
  - id: polymorphism_contamination
    type:
      - 'null'
      - float
    doc: "True biological polymorphism between the contaminants and the reference sequence"
    inputBinding:
      position: 25
      prefix: --polymorphism_contamination
  - id: dry
    type:
      - 'null'
      - boolean
    doc: "print SAM input without any filters"
    inputBinding:
      position: 26
      prefix: --dry
  - id: maxreads
    type:
      - 'null'
      - int
    doc: "stop after these many reads have been processed"
    inputBinding:
      position: 27
      prefix: -n
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "only process data from this chromosome"
    inputBinding:
      position: 28
      prefix: -c
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: "only output sequences with percent identity above this threshold"
    inputBinding:
      position: 29
      prefix: --perc_identity
  - id: requiremapq
    type:
      - 'null'
      - int
    doc: "only process sequences with mapping quality at least this great"
    inputBinding:
      position: 30
      prefix: -m
  - id: readlength
    type:
      - 'null'
      - int
    doc: "only process sequences with this read length"
    inputBinding:
      position: 31
      prefix: --readlength
  - id: maxlength
    type:
      - 'null'
      - int
    doc: "only process sequences with max this read length"
    inputBinding:
      position: 32
      prefix: --maxlength
  - id: minlength
    type:
      - 'null'
      - int
    doc: "only process sequences with min this read length"
    inputBinding:
      position: 33
      prefix: --minlength
  - id: maxgc
    type:
      - 'null'
      - float
    doc: "only process sequences with max this GC content of the aligning reference sequence"
    inputBinding:
      position: 34
      prefix: --maxGC
  - id: mingc
    type:
      - 'null'
      - float
    doc: "only process sequences with min this GC content of the aligning reference sequence"
    inputBinding:
      position: 35
      prefix: --minGC
  - id: requirebaseq
    type:
      - 'null'
      - int
    doc: "only process bases with base quality at least this great"
    inputBinding:
      position: 36
      prefix: -q
  - id: threshold
    type:
      - 'null'
      - float
    doc: "only output sequences with PMD score above this threshold"
    inputBinding:
      position: 37
      prefix: -t
  - id: upperthreshold
    type:
      - 'null'
      - float
    doc: "only output sequences with PMD score below this threshold"
    inputBinding:
      position: 38
      prefix: --upperthreshold
  - id: cpg
    type:
      - 'null'
      - boolean
    doc: "only use Cs and Gs in CpG context"
    inputBinding:
      position: 39
      prefix: --CpG
  - id: nocpg
    type:
      - 'null'
      - boolean
    doc: "dont use Cs and Gs in CpG context"
    inputBinding:
      position: 40
      prefix: --noCpG
  - id: udghalf
    type:
      - 'null'
      - boolean
    doc: "only use Cs and Gs in CpG context, the first and last base are used regardless of dinucleotide context"
    inputBinding:
      position: 41
      prefix: --UDGhalf
  - id: udgminus
    type:
      - 'null'
      - boolean
    doc: "use all bases (placeholder)"
    inputBinding:
      position: 42
      prefix: --UDGminus
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 43
      prefix: --verbose
  - id: header
    type:
      - 'null'
      - boolean
    doc: "output the SAM header"
    inputBinding:
      position: 44
      prefix: --header
  - id: writesamfield
    type:
      - 'null'
      - boolean
    doc: "add 'DS:Z:<PMDS>' field to SAM output, will overwrite if already present"
    inputBinding:
      position: 45
      prefix: --writesamfield
  - id: stats
    type:
      - 'null'
      - boolean
    doc: "output summarizing statistics to stderr"
    inputBinding:
      position: 46
      prefix: --stats
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "show additional information for debugging"
    inputBinding:
      position: 47
      prefix: --debug
  - id: printds
    type:
      - 'null'
      - boolean
    doc: "print PMD scores"
    inputBinding:
      position: 48
      prefix: -p
  - id: printalignments
    type:
      - 'null'
      - boolean
    doc: "print human readable alignments"
    inputBinding:
      position: 49
      prefix: --printalignments
  - id: platypus
    type:
      - 'null'
      - boolean
    doc: "output big list of base frequencies for platypus"
    inputBinding:
      position: 50
      prefix: --platypus
  - id: deamination
    type:
      - 'null'
      - boolean
    doc: "output base frequencies in the read at positions where there are C or G in the reference"
    inputBinding:
      position: 51
      prefix: -d
  - id: include_deamination
    type:
      - 'null'
      - boolean
    doc: "treat possibly deaminated T>C and A>G pairs as mismatches in calculation of percent identity"
    inputBinding:
      position: 52
      prefix: --include_deamination
  - id: include_indels
    type:
      - 'null'
      - boolean
    doc: "treat insertions and deletions as mismatches in calculation of percent identity"
    inputBinding:
      position: 53
      prefix: --include_indels
  - id: include_unknown
    type:
      - 'null'
      - boolean
    doc: "treat Ns in either read or reference as mismatch in calculation of percent identity"
    inputBinding:
      position: 54
      prefix: --include_unknown
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_pmdtools_mod.out
stderr: samsifter_pmdtools_mod.err
stdin: $(inputs.input_sam.path)
