cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_alignment_qc.py
label: wub_bam_alignment_qc.py
doc: 'Produce alignment based QC plots of the input BAM file. The input BAM file must
  be sorted by coordinates and indexed. It produces the following global plots: *
  Read statistics: number of mapped, unmapped and low mapping quality reads. * Distribution
  of mean quality values in the mapped and unmapped fractions. * Distribution of read
  lengths in the unmapped fraction. * Distribution of read lengths in the mapped fraction.
  * Distribution of read lengths in the mapping with quality less than -q * Distribution
  of alignment lengths. * Distribution of mapping qualities. * Plot of alignment lengths
  vs. mean base qualities. * Basewise statistics: total alignment length, number of
  insertions, deleltions, matches and mismatches. * Precision statistics: accuracy
  and identity. * Frequency of errors in the context specifed by the left and right
  context sizes (-n). Definition of context: for substitutions the event is happening
  from the "central base", in the case of indels the events are located between the
  central base and the base before. The columns of the heatmap are normalised to sum
  to one and then the diagonal element are set to zero. * Distribution of deletion
  lengths. * Distribution of insertion lengths. * Base composition of insertions.
  The following plots are produced for every reference unless disabled via -x: * Distribution
  of quality values across the reference as a heatmap. * Mean quality values across
  the reference. * Base coverage across the reference. The tool saves the gathered
  statistics in a pickle file, which can be fed to `bam_multi_qc.py` to compare different
  samples.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: bam
    type: File
    doc: Input BAM file (sorted by coordinates and indexed).
    secondaryFiles:
      - .bai
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 102
      prefix: -f
  - id: region
    type:
      - 'null'
      - string
    doc: BAM region (None).
    inputBinding:
      position: 102
      prefix: -c
  - id: context_sizes
    type:
      - 'null'
      - string
    doc: Left and right context sizes (1,1).
    inputBinding:
      position: 102
      prefix: -n
  - id: no_ref_plots
    type:
      - 'null'
      - boolean
    doc: Do not plot per-reference information.
    inputBinding:
      position: 102
      prefix: -x
  - id: bam_tag
    type:
      - 'null'
      - string
    doc: Dataset tag (BAM basename).
    inputBinding:
      position: 102
      prefix: -t
  - id: aqual
    type:
      - 'null'
      - int
    doc: Minimum alignment quality (0).
    inputBinding:
      position: 102
      prefix: -q
  - id: qual_ints
    type:
      - 'null'
      - int
    doc: Number of quality intervals (6).
    inputBinding:
      position: 102
      prefix: -i
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (bam_alignment_qc.pdf).
    default: bam_alignment_qc.pdf
    inputBinding:
      position: 102
      prefix: -r
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file (bam_alignment_qc.pk).
    default: bam_alignment_qc.pk
    inputBinding:
      position: 102
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet and do not show progress bars.
    inputBinding:
      position: 102
      prefix: -Q
outputs:
  - id: report
    type: File
    doc: QC report PDF.
    outputBinding:
      glob: $(inputs.report_pdf)
  - id: pickle
    type: File
    doc: Pickled QC statistics (input of bam_multi_qc.py).
    outputBinding:
      glob: $(inputs.results_pickle)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
