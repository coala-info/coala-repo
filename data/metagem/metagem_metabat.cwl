cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagem_metabat
label: metagem_metabat
doc: "Metagenome Binning based on Abundance and Tetranucleotide frequency\n\nTool
  homepage: https://github.com/franciscozorrilla/metaGEM"
inputs:
  - id: abd_file
    type:
      - 'null'
      - File
    doc: A file having mean and variance of base coverage depth (tab delimited; 
      the first column should be contig names, and the first row will be 
      considered as the header and be skipped)
    inputBinding:
      position: 101
      prefix: --abdFile
  - id: cv_ext
    type:
      - 'null'
      - boolean
    doc: When a coverage file without variance (from third party tools) is used 
      instead of abdFile from jgi_summarize_bam_contig_depths.
    inputBinding:
      position: 101
      prefix: --cvExt
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: Contigs in (gzipped) fasta file format
    inputBinding:
      position: 101
      prefix: --inFile
  - id: max_edges
    type:
      - 'null'
      - int
    doc: Maximum number of edges per node. The greater, the more sensitive.
    inputBinding:
      position: 101
      prefix: --maxEdges
  - id: max_p
    type:
      - 'null'
      - int
    doc: Percentage of 'good' contigs considered for binning decided by 
      connection among contigs. The greater, the more sensitive.
    inputBinding:
      position: 101
      prefix: --maxP
  - id: min_cls_size
    type:
      - 'null'
      - int
    doc: Minimum size of a bin as the output.
    inputBinding:
      position: 101
      prefix: --minClsSize
  - id: min_contig
    type:
      - 'null'
      - int
    doc: Minimum size of a contig for binning (should be >=1500)
    inputBinding:
      position: 101
      prefix: --minContig
  - id: min_cv
    type:
      - 'null'
      - float
    doc: Minimum mean coverage of a contig in each library for binning.
    inputBinding:
      position: 101
      prefix: --minCV
  - id: min_cv_sum
    type:
      - 'null'
      - float
    doc: Minimum total effective mean coverage of a contig (sum of depth over 
      minCV) for binning.
    inputBinding:
      position: 101
      prefix: --minCVSum
  - id: min_s
    type:
      - 'null'
      - int
    doc: Minimum score of a edge for binning (should be between 1 and 99). The 
      greater, the more specific.
    inputBinding:
      position: 101
      prefix: --minS
  - id: no_add
    type:
      - 'null'
      - boolean
    doc: Turning off additional binning for lost or small contigs.
    inputBinding:
      position: 101
      prefix: --noAdd
  - id: no_bin_out
    type:
      - 'null'
      - boolean
    doc: No bin output. Usually combined with --saveCls to check only contig 
      memberships
    inputBinding:
      position: 101
      prefix: --noBinOut
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (0: use all cores).'
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: only_label
    type:
      - 'null'
      - boolean
    doc: Output only sequence labels as a list in a column without sequences.
    inputBinding:
      position: 101
      prefix: --onlyLabel
  - id: output_file
    type: string
    doc: Base file name and path for each bin. The default output is fasta 
      format. Use -l option to output only contig names
    inputBinding:
      position: 101
      prefix: --outFile
  - id: p_tnf
    type:
      - 'null'
      - int
    doc: 'TNF probability cutoff for building TNF graph. Use it to skip the preparation
      step. (0: auto)'
    inputBinding:
      position: 101
      prefix: --pTNF
  - id: save_cls
    type:
      - 'null'
      - boolean
    doc: Save cluster memberships as a matrix format
    inputBinding:
      position: 101
      prefix: --saveCls
  - id: seed
    type:
      - 'null'
      - int
    doc: 'For exact reproducibility. (0: use random seed)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: unbinned
    type:
      - 'null'
      - boolean
    doc: Generate [outFile].unbinned.fa file for unbinned contigs
    inputBinding:
      position: 101
      prefix: --unbinned
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
stdout: metagem_metabat.out
