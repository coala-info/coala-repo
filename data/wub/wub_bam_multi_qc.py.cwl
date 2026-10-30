cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam_multi_qc.py
label: wub_bam_multi_qc.py
doc: 'Compare alignment QC statistics of multiple samples. It takes a list of pickle
  files produced by `bam_alignment_qc.py` and produces plots comparing the following
  properties of the input samples: * Number of mapped reads. * Number of unmapped
  reads. * Distribution of mean quality values in the unaligned fraction. * Distribution
  of mean quality values in the aligned fraction. * Distribution of read lengths in
  the unaligned fraction. * Distribution of read lengths in the aligned fraction.
  * Distribution of alignment lengths. * Distribution of mapping qualities. * Alignment
  accuracy. * Alignment identity. * Distribution of deletion lengths. * Distribution
  of insertion lengths. Per reference plots (can be disabled by -x): * Relative coverage
  across reference. * Mean qualities per position.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_pickles
    type: File[]
    doc: Input pickles.
    inputBinding:
      position: 1
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report PDF (bam_multi_qc.pdf).
    default: bam_multi_qc.pdf
    inputBinding:
      position: 102
      prefix: -r
  - id: no_ref_plots
    type:
      - 'null'
      - boolean
    doc: Do not plot reference statistics.
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: report
    type: File
    doc: Multi-sample QC comparison report (PDF).
    outputBinding:
      glob: $(inputs.report_pdf)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
