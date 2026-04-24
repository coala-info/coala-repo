cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosic call-tumor-normal
label: prosic_call-tumor-normal
doc: "Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF
  with candidate variants.\n\nTool homepage: https://prosic.github.io"
inputs:
  - id: tumor
    type: File
    doc: BAM file with reads from tumor sample.
    inputBinding:
      position: 1
  - id: normal
    type: File
    doc: BAM file with reads from normal sample.
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: FASTA file with reference genome. Has to be indexed with samtools 
      faidx.
    inputBinding:
      position: 3
  - id: candidates
    type:
      - 'null'
      - File
    doc: VCF/BCF file to process (if omitted, read from STDIN).
    inputBinding:
      position: 104
      prefix: --candidates
  - id: deletion_factor
    type:
      - 'null'
      - float
    doc: "Factor of deletion mutation rate relative to SNV mutation rate (0.03 according\n\
      \                                          to Hodkinson et al. Nature Reviews
      Genetics 2011)."
    inputBinding:
      position: 104
      prefix: --deletion-factor
  - id: effmut
    type:
      - 'null'
      - float
    doc: "Effective SNV mutation rate of tumor sample (should be estimated from somatic\n\
      \                                          SNVs)."
    inputBinding:
      position: 104
      prefix: --effmut
  - id: exclusive_end
    type:
      - 'null'
      - boolean
    doc: "Assume that the END tag is exclusive (i.e. it points to the position after
      the\n                                    variant). This is needed, e.g., for
      DELLY."
    inputBinding:
      position: 104
      prefix: --exclusive-end
  - id: flat_priors
    type:
      - 'null'
      - boolean
    doc: Ignore the prior model and use flat priors instead.
    inputBinding:
      position: 104
      prefix: --flat-priors
  - id: het
    type:
      - 'null'
      - float
    doc: Expected heterozygosity of normal sample.
    inputBinding:
      position: 104
      prefix: --het
  - id: indel_window
    type:
      - 'null'
      - int
    doc: "Number of bases to consider left and right of indel breakpoint when\n  \
      \                                        calculating read support. This number
      should not be too large in order to\n                                      \
      \    avoid biases caused by other close variants."
    inputBinding:
      position: 104
      prefix: --indel-window
  - id: insertion_factor
    type:
      - 'null'
      - float
    doc: "Factor of insertion mutation rate relative to SNV mutation rate (0.01\n\
      \                                          according to Hodkinson et al. Nature
      Reviews Genetics 2011)."
    inputBinding:
      position: 104
      prefix: --insertion-factor
  - id: max_indel_len
    type:
      - 'null'
      - int
    doc: Omit longer indels when calling.
    inputBinding:
      position: 104
      prefix: --max-indel-len
  - id: obs
    type:
      - 'null'
      - File
    doc: "Optional path where read observations shall be written to. The resulting
      file\n                                          contains a line for each observation
      with tab-separated values."
    inputBinding:
      position: 104
      prefix: --obs
  - id: omit_fragment_evidence
    type:
      - 'null'
      - boolean
    doc: "Omit evidence consisting of read pairs with unexpected insert size (insert
      size\n                                    parameters will be ignored)."
    inputBinding:
      position: 104
      prefix: --omit-fragment-evidence
  - id: omit_indels
    type:
      - 'null'
      - boolean
    doc: Don't call indels.
    inputBinding:
      position: 104
      prefix: --omit-indels
  - id: omit_snvs
    type:
      - 'null'
      - boolean
    doc: Don't call SNVs.
    inputBinding:
      position: 104
      prefix: --omit-snvs
  - id: pileup_window
    type:
      - 'null'
      - int
    doc: Window to investigate for evidence left and right of each variant.
    inputBinding:
      position: 104
      prefix: --pileup-window
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Average ploidy of tumor and normal sample.
    inputBinding:
      position: 104
      prefix: --ploidy
  - id: purity
    type:
      - 'null'
      - float
    doc: Purity of tumor sample.
    inputBinding:
      position: 104
      prefix: --purity
  - id: spurious_del_rate
    type:
      - 'null'
      - float
    doc: "Rate of spuriosly deleted bases by the sequencer (Illumina: 5.1e-6, see\n\
      \                                          Schirmer et al. BMC Bioinformatics
      2016)."
    inputBinding:
      position: 104
      prefix: --spurious-del-rate
  - id: spurious_delext_rate
    type:
      - 'null'
      - float
    doc: "Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see\n\
      \                                          Schirmer et al. BMC Bioinformatics
      2016)."
    inputBinding:
      position: 104
      prefix: --spurious-delext-rate
  - id: spurious_ins_rate
    type:
      - 'null'
      - float
    doc: "Rate of spuriously inserted bases by the sequencer (Illumina: 2.8e-6, see\n\
      \                                          Schirmer et al. BMC Bioinformatics
      2016)."
    inputBinding:
      position: 104
      prefix: --spurious-ins-rate
  - id: spurious_insext_rate
    type:
      - 'null'
      - float
    doc: "Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see\n\
      \                                          Schirmer et al. BMC Bioinformatics
      2016) [0.0]."
    inputBinding:
      position: 104
      prefix: --spurious-insext-rate
  - id: spurious_isize_rate
    type:
      - 'null'
      - float
    doc: "Rate of wrongly reported insert size abberations (should be set depending
      on\n                                          mapper, BWA: 0.01332338, LASER:
      0.05922201)."
    inputBinding:
      position: 104
      prefix: --spurious-isize-rate
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: BCF file that shall contain the results (if omitted, write to STDOUT).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
