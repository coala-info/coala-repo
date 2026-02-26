cwlVersion: v1.2
class: CommandLineTool
baseCommand: MTBseq
label: mtbseq_MTBseq
doc: "This pipeline generates mappings and calls variants from input samples.\n\n\
  Tool homepage: https://github.com/ngs-fzb/MTBseq_source"
inputs:
  - id: all_vars
    type:
      - 'null'
      - boolean
    doc: If set, all variant (unambiguous and ambiguous) and invariant sites 
      will be reported.
    inputBinding:
      position: 101
      prefix: --all_vars
  - id: basecalib
    type:
      - 'null'
      - File
    doc: Specifies file for base quality recalibration. See the README.pdf for 
      file properties.
    inputBinding:
      position: 101
      prefix: --basecalib
  - id: categories
    type:
      - 'null'
      - File
    doc: Specifies a gene categories file to detect essential and non-essential 
      genes as well as repetitive regions. See the README.pdf for file 
      properties.
    inputBinding:
      position: 101
      prefix: --categories
  - id: continue_pipeline
    type:
      - 'null'
      - boolean
    doc: Ensures that the pipeline continues after selecting a certain pipeline 
      step that is not TBfull.
    inputBinding:
      position: 101
      prefix: --continue
  - id: distance
    type:
      - 'null'
      - int
    doc: Defines SNP distance for the single linkage clustering in TBgroups.
    default: 12
    inputBinding:
      position: 101
      prefix: --distance
  - id: intregions
    type:
      - 'null'
      - File
    doc: Specifies an interesting region files for extended resistance 
      prediction. See the README.pdf for file properties.
    inputBinding:
      position: 101
      prefix: --intregions
  - id: lowfreq_vars
    type:
      - 'null'
      - boolean
    doc: If set, alternative low frequency alleles competing with majority 
      reference alleles will be reported (useful for the detection of 
      subpopulations).
    inputBinding:
      position: 101
      prefix: --lowfreq_vars
  - id: minbqual
    type:
      - 'null'
      - int
    doc: Defines minimum positional mapping quality during variant calling.
    default: 13
    inputBinding:
      position: 101
      prefix: --minbqual
  - id: mincovf
    type:
      - 'null'
      - int
    doc: Defines minimum forward read coverage for a putative variant position.
    default: 4
    inputBinding:
      position: 101
      prefix: --mincovf
  - id: mincovr
    type:
      - 'null'
      - int
    doc: Defines minimum reverse read coverage for a putative variant position.
    default: 4
    inputBinding:
      position: 101
      prefix: --mincovr
  - id: minfreq
    type:
      - 'null'
      - int
    doc: Defines minimum allele frequency for majority allele.
    default: 75
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: minphred20
    type:
      - 'null'
      - int
    doc: Defines the minimum number of reads having a phred score above or equal
      20 to be considered as a putative variant.
    default: 4
    inputBinding:
      position: 101
      prefix: --minphred20
  - id: project
    type:
      - 'null'
      - string
    doc: Specifiies a project name to identify your joint analysis. Essential 
      for TBamend and TBgroups.
    inputBinding:
      position: 101
      prefix: --project
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turns off Display logging process.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref
    type:
      - 'null'
      - string
    doc: Reference genome for mapping without .fasta extension.
    default: M._tuberculosis_H37Rv_2015-11-13
    inputBinding:
      position: 101
      prefix: --ref
  - id: resilist
    type:
      - 'null'
      - File
    doc: Specifies a file of resistance mediating SNPs for resistance 
      prediction. See the README.pdf for file properties.
    inputBinding:
      position: 101
      prefix: --resilist
  - id: samples
    type:
      - 'null'
      - File
    doc: Specifies a column separated text file with sampleID in column 1 and 
      libID in column 2 for pipeline steps after TBstats.
    inputBinding:
      position: 101
      prefix: --samples
  - id: snp_vars
    type:
      - 'null'
      - boolean
    doc: If set, only unambigous SNPs will be reported. No Insertions nd 
      Deletions will be reported.
    inputBinding:
      position: 101
      prefix: --snp_vars
  - id: step
    type: string
    doc: 'Choose your pipeline step as a parameter! TBfull: Full workflow, TBbwa:
      Read mapping, TBrefine: Refinement of mapping(s), TBpile: Creation of mpileup
      file(s), TBlist: Creation of position list(s), TBvariants: Calling variants,
      TBstats: Statistics of mapping(s) and variant calling(s), TBstrains: Calling
      lineage from sample(s), TBjoin: Joint variant analysis from defined samples,
      TBamend: Amending joint variant table(s), TBgroups: Detecting groups of samples'
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Defines number of CPUs to use. The usage of 8 CPUs is maximum.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: unambig
    type:
      - 'null'
      - int
    doc: Defines minimum percentage of samples having unambigous base call in 
      TBamend analysis.
    default: 95
    inputBinding:
      position: 101
      prefix: --unambig
  - id: window
    type:
      - 'null'
      - int
    doc: Defines window for SNP cluster look up. Reduces putative false 
      positives in TBamend.
    default: 12
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtbseq:1.1.0--hdfd78af_1
stdout: mtbseq_MTBseq.out
