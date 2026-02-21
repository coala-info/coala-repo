cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - callpeak
label: macs3_callpeak
doc: "Model-based Analysis of ChIP-Seq (MACS) for identifying transcript factor binding
  sites.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: barcodes
    type:
      - 'null'
      - File
    doc: A plain text file containing the barcodes for the fragment file while 
      the format is 'FRAG'.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: bdg
    type:
      - 'null'
      - boolean
    doc: Whether or not to save extended fragment pileup and local lambda tracks
      into bedGraph files.
    default: false
    inputBinding:
      position: 101
      prefix: --bdg
  - id: broad
    type:
      - 'null'
      - boolean
    doc: If set, MACS will try to call broad peaks using the --broad-cutoff 
      setting.
    default: false
    inputBinding:
      position: 101
      prefix: --broad
  - id: broad_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff for broad region. This option is not available unless --broad is
      set.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --broad-cutoff
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: bw
    type:
      - 'null'
      - int
    doc: Band width for picking regions to compute fragment size.
    default: 300
    inputBinding:
      position: 101
      prefix: --bw
  - id: call_summits
    type:
      - 'null'
      - boolean
    doc: If set, MACS will use a more sophisticated signal processing approach 
      to find subpeak summits.
    default: false
    inputBinding:
      position: 101
      prefix: --call-summits
  - id: control
    type:
      - 'null'
      - type: array
        items: File
    doc: Control file. If multiple files are given, they will be pooled to 
      estimate ChIP-seq background noise.
    inputBinding:
      position: 101
      prefix: --control
  - id: cutoff_analysis
    type:
      - 'null'
      - boolean
    doc: While set, MACS3 will analyze number or total length of peaks that can 
      be called by different p-value cutoff.
    default: false
    inputBinding:
      position: 101
      prefix: --cutoff-analysis
  - id: d_min
    type:
      - 'null'
      - int
    doc: Minimum fragment size in basepair.
    default: 20
    inputBinding:
      position: 101
      prefix: --d-min
  - id: down_sample
    type:
      - 'null'
      - boolean
    doc: When set, random sampling method will scale down the bigger sample.
    default: false
    inputBinding:
      position: 101
      prefix: --down-sample
  - id: extsize
    type:
      - 'null'
      - int
    doc: The arbitrary extension size in bp.
    default: 200
    inputBinding:
      position: 101
      prefix: --extsize
  - id: fe_cutoff
    type:
      - 'null'
      - float
    doc: When set, the value will be used as the minimum requirement to filter 
      out peaks with low fold-enrichment.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --fe-cutoff
  - id: fix_bimodal
    type:
      - 'null'
      - boolean
    doc: Whether turn on the auto pair model process.
    default: false
    inputBinding:
      position: 101
      prefix: --fix-bimodal
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file (AUTO, BAM, SAM, BED, ELAND, ELANDMULTI, 
      ELANDEXPORT, BOWTIE, BAMPE, BEDPE, or FRAG).
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. Can be a number or shortcuts like 'hs', 'mm', 
      'ce', 'dm'.
    default: hs
    inputBinding:
      position: 101
      prefix: --gsize
  - id: keep_dup
    type:
      - 'null'
      - string
    doc: Controls the behavior towards duplicate tags at the exact same 
      location.
    default: '1'
    inputBinding:
      position: 101
      prefix: --keep-dup
  - id: llocal
    type:
      - 'null'
      - int
    doc: The large nearby region in basepairs to calculate dynamic lambda.
    default: 10000
    inputBinding:
      position: 101
      prefix: --llocal
  - id: max_count
    type:
      - 'null'
      - int
    doc: In FRAG format, the maximum count of fragments allowed at the same 
      location from the same barcode.
    inputBinding:
      position: 101
      prefix: --max-count
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap between significant sites to cluster them together.
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: mfold
    type:
      - 'null'
      - type: array
        items: int
    doc: Select the regions within MFOLD range of high-confidence enrichment 
      ratio to build model.
    default:
      - 5
      - 50
    inputBinding:
      position: 101
      prefix: --mfold
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of a peak.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: name
    type:
      - 'null'
      - string
    doc: Experiment name, which will be used to generate output file names.
    default: NA
    inputBinding:
      position: 101
      prefix: --name
  - id: nolambda
    type:
      - 'null'
      - boolean
    doc: If True, MACS will use fixed background lambda as local lambda for 
      every peak region.
    inputBinding:
      position: 101
      prefix: --nolambda
  - id: nomodel
    type:
      - 'null'
      - boolean
    doc: Whether or not to build the shifting model.
    default: false
    inputBinding:
      position: 101
      prefix: --nomodel
  - id: pvalue
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for peak detection.
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: qvalue
    type:
      - 'null'
      - float
    doc: Minimum FDR (q-value) cutoff for peak detection.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --qvalue
  - id: scale_to
    type:
      - 'null'
      - string
    doc: When set to 'small', scale the larger sample up to the smaller sample. 
      When set to 'large', scale the smaller sample up to the bigger sample.
    default: small
    inputBinding:
      position: 101
      prefix: --scale-to
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed while down sampling data.
    inputBinding:
      position: 101
      prefix: --seed
  - id: shift
    type:
      - 'null'
      - int
    doc: The arbitrary shift in bp.
    default: 0
    inputBinding:
      position: 101
      prefix: --shift
  - id: slocal
    type:
      - 'null'
      - int
    doc: The small nearby region in basepairs to calculate dynamic lambda.
    default: 1000
    inputBinding:
      position: 101
      prefix: --slocal
  - id: spmr
    type:
      - 'null'
      - boolean
    doc: If True, MACS will save signal per million reads for fragment pileup 
      profiles.
    default: false
    inputBinding:
      position: 101
      prefix: --SPMR
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Optional directory to store temp files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: trackline
    type:
      - 'null'
      - boolean
    doc: Instruct MACS to include trackline in the header of output files.
    inputBinding:
      position: 101
      prefix: --trackline
  - id: treatment
    type:
      type: array
      items: File
    doc: ChIP-seq treatment file. If multiple files are given, they will all be 
      read and pooled together.
    inputBinding:
      position: 101
      prefix: --treatment
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size/read length. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbose level of runtime message (0-3).
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
