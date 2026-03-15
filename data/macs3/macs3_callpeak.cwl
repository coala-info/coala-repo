cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - callpeak
label: macs3_callpeak
doc: Model-based Analysis of ChIP-Seq (MACS) for identifying transcript factor 
  binding sites.
inputs:
  - id: treatment
    type:
      type: array
      items: File
    doc: ChIP-seq treatment file. If multiple files are given as '-t A B C', 
      then they will all be read and pooled together.
    inputBinding:
      position: 101
      prefix: --treatment
  - id: control
    type:
      - 'null'
      - type: array
        items: File
    doc: Control file. If multiple files are given as '-c A B C', they will be 
      pooled to estimate ChIP-seq background noise.
    inputBinding:
      position: 101
      prefix: --control
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file (AUTO, BAM, SAM, BED, ELAND, ELANDMULTI, 
      ELANDEXPORT, BOWTIE, BAMPE, BEDPE, or FRAG).
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. Can be a number or shortcuts like 'hs', 'mm', 
      'ce', 'dm'.
    inputBinding:
      position: 101
      prefix: --gsize
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size/read length. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
  - id: keep_dup
    type:
      - 'null'
      - string
    doc: Controls the behavior towards duplicate tags at the exact same 
      location.
    inputBinding:
      position: 101
      prefix: --keep-dup
  - id: barcodes
    type:
      - 'null'
      - File
    doc: A plain text file containing the barcodes for the fragment file while 
      the format is 'FRAG'.
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: max_count
    type:
      - 'null'
      - int
    doc: In the FRAG format file, the limit for fragment counts at the same 
      location from the same barcode.
    inputBinding:
      position: 101
      prefix: --max-count
  - id: outdir
    type: string
    doc: If specified all output files will be written to that directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: name
    type:
      - 'null'
      - string
    doc: Experiment name, which will be used to generate output file names.
    inputBinding:
      position: 101
      prefix: --name
  - id: bdg
    type:
      - 'null'
      - boolean
    doc: Whether or not to save extended fragment pileup, and local lambda 
      tracks into a bedGraph file.
    inputBinding:
      position: 101
      prefix: --bdg
  - id: trackline
    type:
      - 'null'
      - boolean
    doc: Instruct MACS to include trackline in the header of output files.
    inputBinding:
      position: 101
      prefix: --trackline
  - id: spmr
    type:
      - 'null'
      - boolean
    doc: If True, MACS will SAVE signal per million reads for fragment pileup 
      profiles. Requires -B.
    inputBinding:
      position: 101
      prefix: --SPMR
  - id: nomodel
    type:
      - 'null'
      - boolean
    doc: Whether or not to build the shifting model.
    inputBinding:
      position: 101
      prefix: --nomodel
  - id: shift
    type:
      - 'null'
      - int
    doc: The arbitrary shift in bp.
    inputBinding:
      position: 101
      prefix: --shift
  - id: extsize
    type:
      - 'null'
      - int
    doc: The arbitrary extension size in bp.
    inputBinding:
      position: 101
      prefix: --extsize
  - id: bw
    type:
      - 'null'
      - int
    doc: Band width for picking regions to compute fragment size.
    inputBinding:
      position: 101
      prefix: --bw
  - id: d_min
    type:
      - 'null'
      - int
    doc: Minimum fragment size in basepair.
    inputBinding:
      position: 101
      prefix: --d-min
  - id: mfold
    type:
      - 'null'
      - type: array
        items: int
    doc: Select the regions within MFOLD range of high-confidence enrichment 
      ratio to build model.
    inputBinding:
      position: 101
      prefix: --mfold
  - id: fix_bimodal
    type:
      - 'null'
      - boolean
    doc: Whether turn on the auto pair model process.
    inputBinding:
      position: 101
      prefix: --fix-bimodal
  - id: qvalue
    type:
      - 'null'
      - float
    doc: Minimum FDR (q-value) cutoff for peak detection.
    inputBinding:
      position: 101
      prefix: --qvalue
  - id: pvalue
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for peak detection.
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: scale_to
    type:
      - 'null'
      - string
    doc: When set to 'small', scale the larger sample up to the smaller sample. 
      When set to 'large', scale the smaller sample up to the bigger sample.
    inputBinding:
      position: 101
      prefix: --scale-to
  - id: down_sample
    type:
      - 'null'
      - boolean
    doc: When set, random sampling method will scale down the bigger sample.
    inputBinding:
      position: 101
      prefix: --down-sample
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed while down sampling data.
    inputBinding:
      position: 101
      prefix: --seed
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Optional directory to store temp files.
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: nolambda
    type:
      - 'null'
      - boolean
    doc: If True, MACS will use fixed background lambda as local lambda for 
      every peak region.
    inputBinding:
      position: 101
      prefix: --nolambda
  - id: slocal
    type:
      - 'null'
      - int
    doc: The small nearby region in basepairs to calculate dynamic lambda.
    inputBinding:
      position: 101
      prefix: --slocal
  - id: llocal
    type:
      - 'null'
      - int
    doc: The large nearby region in basepairs to calculate dynamic lambda.
    inputBinding:
      position: 101
      prefix: --llocal
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap between significant sites to cluster them together.
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of a peak.
    inputBinding:
      position: 101
      prefix: --min-length
  - id: broad
    type:
      - 'null'
      - boolean
    doc: If set, MACS will try to call broad peaks using the --broad-cutoff 
      setting.
    inputBinding:
      position: 101
      prefix: --broad
  - id: broad_cutoff
    type:
      - 'null'
      - float
    doc: Cutoff for broad region. This option is not available unless --broad is
      set.
    inputBinding:
      position: 101
      prefix: --broad-cutoff
  - id: cutoff_analysis
    type:
      - 'null'
      - boolean
    doc: While set, MACS3 will analyze number or total length of peaks that can 
      be called by different p-value cutoff.
    inputBinding:
      position: 101
      prefix: --cutoff-analysis
  - id: call_summits
    type:
      - 'null'
      - boolean
    doc: If set, MACS will use a more sophisticated signal processing approach 
      to find subpeak summits.
    inputBinding:
      position: 101
      prefix: --call-summits
  - id: fe_cutoff
    type:
      - 'null'
      - float
    doc: When set, the value will be used as the minimum requirement to filter 
      out peaks with low fold-enrichment.
    inputBinding:
      position: 101
      prefix: --fe-cutoff
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    inputBinding:
      position: 101
      prefix: --buffer-size
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
