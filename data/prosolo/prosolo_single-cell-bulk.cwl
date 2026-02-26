cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosolo single-cell-bulk
label: prosolo_single-cell-bulk
doc: "Call somatic and germline variants from a single cell-bulk sample pair and a
  VCF/BCF with candidate variants.\n\nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs:
  - id: single_cell
    type: File
    doc: BAM file with reads from single cell sample.
    inputBinding:
      position: 1
  - id: bulk
    type: File
    doc: BAM file with reads from bulk sample.
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: FASTA file with reference genome. Has to be indexed with samtools 
      faidx.
    inputBinding:
      position: 3
  - id: bulk_max_n
    type:
      - 'null'
      - int
    doc: Maximum number of (theoretical) reads to work with in the bulk 
      background, in case the actual read count for a variant is higher (all 
      read information will be used, but probabilities will only be computed for
      all discrete allele frequencies allowed by the maximum read count provided
      here). The code will work with any number above bulk-min-n, but we use the
      cap of the currently used Lodato amplification bias model for the single 
      cell sample as the default.
    default: 100
    inputBinding:
      position: 104
      prefix: --bulk-max-n
  - id: bulk_min_n
    type:
      - 'null'
      - int
    doc: Minimum number of (theoretical) reads to work with in the bulk 
      background, in case the actual read count for a variant site is lower (in 
      this case, probabilities will be computed for all discrete allele 
      frequencies allowed by the minimum read count provided here). The code 
      will work with a minimum of 2, but for a more even sampling of Event 
      spaces, the default is at 8.
    default: 8
    inputBinding:
      position: 104
      prefix: --bulk-min-n
  - id: candidates
    type:
      - 'null'
      - File
    doc: VCF/BCF file to process (if omitted, read from STDIN).
    inputBinding:
      position: 104
      prefix: --candidates
  - id: exclusive_end
    type:
      - 'null'
      - boolean
    doc: Assume that the END tag is exclusive (i.e. it points to the position 
      after the variant). This is needed, e.g., for DELLY.
    inputBinding:
      position: 104
      prefix: --exclusive-end
  - id: indel_window
    type:
      - 'null'
      - int
    doc: Number of bases to consider left and right of indel breakpoint when 
      calculating read support. This number should not be too large in order to 
      avoid biases caused by other close variants.
    default: 100
    inputBinding:
      position: 104
      prefix: --indel-window
  - id: max_indel_len
    type:
      - 'null'
      - int
    doc: Omit longer indels when calling
    default: 1000
    inputBinding:
      position: 104
      prefix: --max-indel-len
  - id: obs
    type:
      - 'null'
      - File
    doc: Optional path where read observations shall be written to. The 
      resulting file contains a line for each observation with tab-separated 
      values.
    inputBinding:
      position: 104
      prefix: --obs
  - id: omit_fragment_evidence
    type:
      - 'null'
      - boolean
    doc: Omit evidence consisting of read pairs with unexpected insert size 
      (insert size parameters will be ignored).
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
    default: 2500
    inputBinding:
      position: 104
      prefix: --pileup-window
  - id: ploidy
    type:
      - 'null'
      - int
    doc: General ploidy of sampled individual.
    default: 2
    inputBinding:
      position: 104
      prefix: --ploidy
  - id: spurious_del_rate
    type:
      - 'null'
      - float
    doc: 'Rate of spuriosly deleted bases by the sequencer (Illumina: 5.1e-6, see
      Schirmer et al. BMC Bioinformatics 2016).'
    default: '5.1e-6'
    inputBinding:
      position: 104
      prefix: --spurious-del-rate
  - id: spurious_delext_rate
    type:
      - 'null'
      - float
    doc: 'Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
      Schirmer et al. BMC Bioinformatics 2016).'
    default: 0.0
    inputBinding:
      position: 104
      prefix: --spurious-delext-rate
  - id: spurious_ins_rate
    type:
      - 'null'
      - float
    doc: 'Rate of spuriously inserted bases by the sequencer (Illumina: 2.8e-6, see
      Schirmer et al. BMC Bioinformatics 2016).'
    default: '2.8e-6'
    inputBinding:
      position: 104
      prefix: --spurious-ins-rate
  - id: spurious_insext_rate
    type:
      - 'null'
      - float
    doc: 'Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
      Schirmer et al. BMC Bioinformatics 2016)'
    default: 0.0
    inputBinding:
      position: 104
      prefix: --spurious-insext-rate
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
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
