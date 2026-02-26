cwlVersion: v1.2
class: CommandLineTool
baseCommand: alevin
label: salmon_alevin
doc: "salmon-based processing of single-cell RNA-seq data.\n\nTool homepage: https://github.com/COMBINE-lab/salmon"
inputs:
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: barcode length Parameter for unknown protocol. (end, umiLength, 
      barcodeLength) should all be provided if using this option
    inputBinding:
      position: 101
      prefix: --barcodeLength
  - id: bc_geometry
    type:
      - 'null'
      - string
    doc: format string describing the geometry of the cell barcode
    inputBinding:
      position: 101
      prefix: --bc-geometry
  - id: celseq
    type:
      - 'null'
      - boolean
    doc: Use CEL-Seq Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --celseq
  - id: celseq2
    type:
      - 'null'
      - boolean
    doc: Use CEL-Seq2 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --celseq2
  - id: chromium
    type:
      - 'null'
      - boolean
    doc: Use 10x chromium v2 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --chromium
  - id: chromium_v3
    type:
      - 'null'
      - boolean
    doc: Use 10x chromium v3 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --chromiumV3
  - id: citeseq
    type:
      - 'null'
      - boolean
    doc: Use CITESeq Single Cell protocol for the library, 16 CB, 12 UMI and 
      features.
    inputBinding:
      position: 101
      prefix: --citeseq
  - id: dropseq
    type:
      - 'null'
      - boolean
    doc: Use DropSeq Single Cell protocol for the library
    inputBinding:
      position: 101
      prefix: --dropseq
  - id: dump_arborescences
    type:
      - 'null'
      - boolean
    doc: dump the gene-v-cell matrix for the total number of fragments used in 
      the UMI deduplicaiton.
    inputBinding:
      position: 101
      prefix: --dumpArborescences
  - id: dump_bfh
    type:
      - 'null'
      - boolean
    doc: dump the big hash with all the barcodes and the UMI sequence.
    inputBinding:
      position: 101
      prefix: --dumpBfh
  - id: dump_cell_eq
    type:
      - 'null'
      - boolean
    doc: dump the per cell level deduplicated equivalence classes.
    inputBinding:
      position: 101
      prefix: --dumpCellEq
  - id: dump_features
    type:
      - 'null'
      - boolean
    doc: Dump features for whitelist and downstream analysis.
    inputBinding:
      position: 101
      prefix: --dumpFeatures
  - id: dump_mtx
    type:
      - 'null'
      - boolean
    doc: Dump cell v transcripts count matrix in sparse mtx format.
    inputBinding:
      position: 101
      prefix: --dumpMtx
  - id: dump_umi_graph
    type:
      - 'null'
      - boolean
    doc: dump the per cell level Umi Graph.
    inputBinding:
      position: 101
      prefix: --dumpUmiGraph
  - id: dumpfq
    type:
      - 'null'
      - boolean
    doc: Dump barcode modified fastq file for downstream analysis by using coin 
      toss for multi-mapping.
    inputBinding:
      position: 101
      prefix: --dumpfq
  - id: end
    type:
      - 'null'
      - string
    doc: Cell-Barcodes end (5 or 3) location in the read sequence from where 
      barcode has to be extracted. (end, umiLength, barcodeLength) should all be
      provided if using this option
    inputBinding:
      position: 101
      prefix: --end
  - id: expect_cells
    type:
      - 'null'
      - int
    doc: define a close upper bound on expected number of cells
    default: 0
    inputBinding:
      position: 101
      prefix: --expectCells
  - id: feature_length
    type:
      - 'null'
      - int
    doc: This flag should be used with citeseq and specifies the length of the 
      feature barcode.
    inputBinding:
      position: 101
      prefix: --featureLength
  - id: feature_start
    type:
      - 'null'
      - int
    doc: This flag should be used with citeseq and specifies the starting index 
      of the feature barcode on Read2.
    inputBinding:
      position: 101
      prefix: --featureStart
  - id: force_cells
    type:
      - 'null'
      - int
    doc: Explicitly specify the number of cells.
    default: 0
    inputBinding:
      position: 101
      prefix: --forceCells
  - id: freq_threshold
    type:
      - 'null'
      - int
    doc: threshold for the frequency of the barcodes
    default: 10
    inputBinding:
      position: 101
      prefix: --freqThreshold
  - id: gemcode
    type:
      - 'null'
      - boolean
    doc: Use 10x gemcode v1 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --gemcode
  - id: hash
    type:
      - 'null'
      - File
    doc: Secondary input point for Alevin using Big freaking Hash (bfh.txt) 
      file. Works Only with --chromium
    inputBinding:
      position: 101
      prefix: --hash
  - id: index
    type:
      - 'null'
      - string
    doc: salmon index
    inputBinding:
      position: 101
      prefix: --index
  - id: keep_cb_fraction
    type:
      - 'null'
      - float
    doc: fraction of CB to keep, value must be in range (0,1], use 1 to quantify
      all CB.
    default: 0
    inputBinding:
      position: 101
      prefix: --keepCBFraction
  - id: lib_type
    type:
      - 'null'
      - string
    doc: Format string describing the library type
    inputBinding:
      position: 101
      prefix: --libType
  - id: low_region_min_num_barcodes
    type:
      - 'null'
      - int
    doc: 'Minimum Number of CB to use for learning Low confidence region (Default:
      200).'
    default: 200
    inputBinding:
      position: 101
      prefix: --lowRegionMinNumBarcodes
  - id: mates1
    type:
      - 'null'
      - File
    doc: 'File containing the #1 mates'
    inputBinding:
      position: 101
      prefix: --mates1
  - id: mates2
    type:
      - 'null'
      - File
    doc: 'File containing the #2 mates'
    inputBinding:
      position: 101
      prefix: --mates2
  - id: max_num_barcodes
    type:
      - 'null'
      - int
    doc: 'Maximum allowable limit to process the cell barcodes. (Default: 100000)'
    default: 100000
    inputBinding:
      position: 101
      prefix: --maxNumBarcodes
  - id: mrna
    type:
      - 'null'
      - File
    doc: path to a file containing mito-RNA gene, one per line
    inputBinding:
      position: 101
      prefix: --mrna
  - id: no_em
    type:
      - 'null'
      - boolean
    doc: do not run em
    inputBinding:
      position: 101
      prefix: --noem
  - id: no_quant
    type:
      - 'null'
      - boolean
    doc: Don't run downstream barcode-salmon model.
    inputBinding:
      position: 101
      prefix: --noQuant
  - id: num_cell_bootstraps
    type:
      - 'null'
      - int
    doc: Generate mean and variance for cell x gene matrix quantification 
      estimates.
    default: 0
    inputBinding:
      position: 101
      prefix: --numCellBootstraps
  - id: num_cell_gibbs_samples
    type:
      - 'null'
      - int
    doc: Generate mean and variance for cell x gene matrix quantification by 
      running gibbs chain estimates.
    default: 0
    inputBinding:
      position: 101
      prefix: --numCellGibbsSamples
  - id: quartzseq2
    type:
      - 'null'
      - boolean
    doc: Use Quartz-Seq2 v3.2 Single Cell protocol for the library assumes 15 
      length barcode and 8 length UMI.
    inputBinding:
      position: 101
      prefix: --quartzseq2
  - id: rad
    type:
      - 'null'
      - boolean
    doc: just selectively align the data and write the results to a RAD file. Do
      not perform the rest of the quantification procedure.
    inputBinding:
      position: 101
      prefix: --rad
  - id: read_geometry
    type:
      - 'null'
      - string
    doc: format string describing the geometry of the read
    inputBinding:
      position: 101
      prefix: --read-geometry
  - id: rrna
    type:
      - 'null'
      - File
    doc: path to a file containing ribosomal RNA, one per line
    inputBinding:
      position: 101
      prefix: --rrna
  - id: sciseq3
    type:
      - 'null'
      - boolean
    doc: Use sci-RNA-seq3 protocol for the library.
    inputBinding:
      position: 101
      prefix: --sciseq3
  - id: sketch
    type:
      - 'null'
      - boolean
    doc: perform sketching rather than selective alignment and write the results
      to a RAD file. Requires the `--rad` flag. Do not perform the rest of the 
      quantification procedure.
    inputBinding:
      position: 101
      prefix: --sketch
  - id: splitseq_v1
    type:
      - 'null'
      - boolean
    doc: Use Split-SeqV1 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --splitseqV1
  - id: splitseq_v2
    type:
      - 'null'
      - boolean
    doc: Use Split-SeqV2 Single Cell protocol for the library.
    inputBinding:
      position: 101
      prefix: --splitseqV2
  - id: tg_map
    type:
      - 'null'
      - File
    doc: transcript to gene map tsv file
    inputBinding:
      position: 101
      prefix: --tgMap
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use concurrently.
    default: 5
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_edit_distance
    type:
      - 'null'
      - int
    doc: Maximum allowble edit distance to collapse UMIs, Expect delay in 
      running time if != 1
    default: 1
    inputBinding:
      position: 101
      prefix: --umiEditDistance
  - id: umi_geometry
    type:
      - 'null'
      - string
    doc: format string describing the genometry of the umi
    inputBinding:
      position: 101
      prefix: --umi-geometry
  - id: umi_length
    type:
      - 'null'
      - int
    doc: umi length Parameter for unknown protocol. (end, umiLength, 
      barcodeLength) should all be provided if using this option
    inputBinding:
      position: 101
      prefix: --umiLength
  - id: unmated_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: List of files containing unmated reads of (e.g. single-end reads)
    inputBinding:
      position: 101
      prefix: --unmatedReads
  - id: whitelist
    type:
      - 'null'
      - File
    doc: File containing white-list barcodes
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output quantification directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
