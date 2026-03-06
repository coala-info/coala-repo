cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- mpileup
label: bcftools_mpileup
doc: Generate VCF or BCF containing genotype likelihoods for one or multiple BAM
  files
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_bams
  type:
    type: array
    items: File
  doc: Input BAM/CRAM files
  inputBinding:
    position: 1
- id: adjust_mq
  type:
  - 'null'
  - int
  doc: Adjust mapping quality
  inputBinding:
    position: 102
    prefix: --adjust-MQ
- id: ambig_reads
  type:
  - 'null'
  - string
  doc: 'What to do with ambiguous indel reads: drop,incAD,incAD0'
  inputBinding:
    position: 102
    prefix: --ambig-reads
- id: annotate
  type:
  - 'null'
  - string
  doc: Optional tags to output
  inputBinding:
    position: 102
    prefix: --annotate
- id: bam_list
  type:
  - 'null'
  - File
  doc: List of input BAM filenames, one per line
  inputBinding:
    position: 102
    prefix: --bam-list
- id: config
  type:
  - 'null'
  - string
  doc: Specify platform profile
  inputBinding:
    position: 102
    prefix: --config
- id: count_orphans
  type:
  - 'null'
  - boolean
  doc: Include anomalous read pairs, with flag PAIRED but not PROPER_PAIR set
  inputBinding:
    position: 102
    prefix: --count-orphans
- id: del_bias
  type:
  - 'null'
  - float
  doc: Relative likelihood of insertion to deletion
  inputBinding:
    position: 102
    prefix: --del-bias
- id: delta_bq
  type:
  - 'null'
  - int
  doc: Use neighbour_qual + INT if less than qual
  inputBinding:
    position: 102
    prefix: --delta-bq
- id: ext_prob
  type:
  - 'null'
  - int
  doc: Phred-scaled gap extension seq error probability
  inputBinding:
    position: 102
    prefix: --ext-prob
- id: fasta_ref
  type:
  - 'null'
  - File
  doc: Faidx indexed reference sequence file
  inputBinding:
    position: 102
    prefix: --fasta-ref
- id: full_baq
  type:
  - 'null'
  - boolean
  doc: Apply BAQ everywhere, not just in problematic regions
  inputBinding:
    position: 102
    prefix: --full-BAQ
- id: gap_frac
  type:
  - 'null'
  - float
  doc: Minimum fraction of gapped reads
  inputBinding:
    position: 102
    prefix: --gap-frac
- id: gvcf
  type:
  - 'null'
  - string
  doc: Group non-variant sites into gVCF blocks according to minimum per-sample 
    DP
  inputBinding:
    position: 102
    prefix: --gvcf
- id: ignore_overlaps
  type:
  - 'null'
  - boolean
  doc: Disable read-pair overlap detection
  inputBinding:
    position: 102
    prefix: --ignore-overlaps
- id: ignore_rg
  type:
  - 'null'
  - boolean
  doc: Ignore RG tags (one BAM = one sample)
  inputBinding:
    position: 102
    prefix: --ignore-RG
- id: illumina_encoding
  type:
  - 'null'
  - boolean
  doc: Quality is in the Illumina-1.3+ encoding
  inputBinding:
    position: 102
    prefix: --illumina1.3+
- id: indel_bias
  type:
  - 'null'
  - float
  doc: Raise to favour recall over precision
  inputBinding:
    position: 102
    prefix: --indel-bias
- id: indel_size
  type:
  - 'null'
  - int
  doc: Approximate maximum indel size considered
  inputBinding:
    position: 102
    prefix: --indel-size
- id: indels_2_0
  type:
  - 'null'
  - boolean
  doc: New EXPERIMENTAL indel calling model (diploid reference consensus)
  inputBinding:
    position: 102
    prefix: --indels-2.0
- id: indels_cns
  type:
  - 'null'
  - boolean
  doc: New EXPERIMENTAL indel calling model with edlib
  inputBinding:
    position: 102
    prefix: --indels-cns
- id: max_bq
  type:
  - 'null'
  - int
  doc: Limit baseQ/BAQ to no more than INT
  inputBinding:
    position: 102
    prefix: --max-bq
- id: max_depth
  type:
  - 'null'
  - int
  doc: Max raw per-file depth; avoids excessive memory usage
  inputBinding:
    position: 102
    prefix: --max-depth
- id: max_idepth
  type:
  - 'null'
  - int
  doc: Maximum per-file depth for INDEL calling
  inputBinding:
    position: 102
    prefix: --max-idepth
- id: max_read_len
  type:
  - 'null'
  - int
  doc: Maximum length of read to pass to BAQ algorithm
  inputBinding:
    position: 102
    prefix: --max-read-len
- id: min_bq
  type:
  - 'null'
  - int
  doc: Skip bases with baseQ/BAQ smaller than INT
  inputBinding:
    position: 102
    prefix: --min-BQ
- id: min_ireads
  type:
  - 'null'
  - int
  doc: Minimum number gapped reads for indel candidates
  inputBinding:
    position: 102
    prefix: --min-ireads
- id: min_mq
  type:
  - 'null'
  - int
  doc: Skip alignments with mapQ smaller than INT
  inputBinding:
    position: 102
    prefix: --min-MQ
- id: no_baq
  type:
  - 'null'
  - boolean
  doc: Disable BAQ (per-Base Alignment Quality)
  inputBinding:
    position: 102
    prefix: --no-BAQ
- id: no_indels_cns
  type:
  - 'null'
  - boolean
  doc: Disable CNS mode, to use after a -X profile
  inputBinding:
    position: 102
    prefix: --no-indels-cns
- id: no_reference
  type:
  - 'null'
  - boolean
  doc: Do not require fasta reference file
  inputBinding:
    position: 102
    prefix: --no-reference
- id: no_version
  type:
  - 'null'
  - boolean
  doc: Do not append version and command line to the header
  inputBinding:
    position: 102
    prefix: --no-version
- id: open_prob
  type:
  - 'null'
  - int
  doc: Phred-scaled gap open seq error probability
  inputBinding:
    position: 102
    prefix: --open-prob
- id: output
  type: string
  doc: Write output to FILE
  inputBinding:
    position: 102
    prefix: --output
- id: output_type
  type:
  - 'null'
  - string
  doc: "'b' compressed BCF; 'u' uncompressed BCF; 'z' compressed VCF; 'v' uncompressed
    VCF; 0-9 compression level"
  inputBinding:
    position: 102
    prefix: --output-type
- id: per_sample_mf
  type:
  - 'null'
  - boolean
  doc: Apply -m and -F per-sample for increased sensitivity
  inputBinding:
    position: 102
    prefix: --per-sample-mF
- id: platforms
  type:
  - 'null'
  - string
  doc: Comma separated list of platforms for indels
  inputBinding:
    position: 102
    prefix: --platforms
- id: poly_mqual
  type:
  - 'null'
  - boolean
  doc: (Edlib mode) Use minimum quality within homopolymers
  inputBinding:
    position: 102
    prefix: --poly-mqual
- id: read_groups
  type:
  - 'null'
  - File
  doc: Select or exclude read groups listed in the file
  inputBinding:
    position: 102
    prefix: --read-groups
- id: redo_baq
  type:
  - 'null'
  - boolean
  doc: Recalculate BAQ on the fly, ignore existing BQs
  inputBinding:
    position: 102
    prefix: --redo-BAQ
- id: regions
  type:
  - 'null'
  - string
  doc: Comma separated list of regions in which pileup is generated
  inputBinding:
    position: 102
    prefix: --regions
- id: regions_file
  type:
  - 'null'
  - File
  doc: Restrict to regions listed in a file
  inputBinding:
    position: 102
    prefix: --regions-file
- id: samples
  type:
  - 'null'
  - string
  doc: Comma separated list of samples to include
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type:
  - 'null'
  - File
  doc: File of samples to include
  inputBinding:
    position: 102
    prefix: --samples-file
- id: score_vs_ref
  type:
  - 'null'
  - float
  doc: Ratio of score
arguments:
- position: 101
  valueFrom: |
    ${
      if (inputs.fasta_ref == null && inputs.no_reference == null) {
        return "--no-reference";
      } else {
        return null;
      }
    }
outputs:
- id: output_output
  type: File
  outputBinding:
    glob: $(inputs.output)
