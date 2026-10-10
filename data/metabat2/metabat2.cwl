cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabat2
label: metabat2
doc: "MetaBAT 2: metagenome binning based on abundance and tetranucleotide frequency.\n\nTool homepage: https://bitbucket.org/berkeleylab/metabat"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: in_file
    type: File
    doc: "Contigs in (gzipped) fasta file format [Mandatory]"
    inputBinding:
      position: 100
      prefix: --inFile
  - id: out_file
    type: string
    doc: "Base file name and path for each bin. The default output is fasta format. Use onlyLabel to output only contig names [Mandatory]"
    inputBinding:
      position: 100
      prefix: --outFile
  - id: abd_file
    type: 
      - 'null'
      - File
    doc: "A file having mean and variance of base coverage depth (tab delimited; first column contig names, first row is a header)"
    inputBinding:
      position: 100
      prefix: --abdFile
  - id: min_contig
    type: 
      - 'null'
      - int
    doc: "Minimum size of a contig for binning (should be >=1500). Default: 2500"
    inputBinding:
      position: 100
      prefix: --minContig
  - id: min_small_contig
    type: 
      - 'null'
      - int
    doc: "Minimum size of a small contig for recruiting into established bins (should be >=500). Default: 1000"
    inputBinding:
      position: 100
      prefix: --minSmallContig
  - id: max_p
    type: 
      - 'null'
      - int
    doc: "Percentage of 'good' contigs considered for binning decided by connection among contigs. Default: 95"
    inputBinding:
      position: 100
      prefix: --maxP
  - id: min_s
    type: 
      - 'null'
      - int
    doc: "Minimum score of a edge for binning (should be between 1 and 99). Default: 60"
    inputBinding:
      position: 100
      prefix: --minS
  - id: max_edges
    type: 
      - 'null'
      - int
    doc: "Maximum number of edges per node. Default: 200"
    inputBinding:
      position: 100
      prefix: --maxEdges
  - id: p_tnf
    type: 
      - 'null'
      - int
    doc: "TNF probability cutoff for building TNF graph; a value between 1 and 100 skips the auto preparation step (0: auto). Default: 0"
    inputBinding:
      position: 100
      prefix: --pTNF
  - id: no_add
    type: 
      - 'null'
      - boolean
    doc: "Turning off additional binning for lost or small contigs"
    inputBinding:
      position: 100
      prefix: --noAdd
  - id: min_recruiting_size
    type: 
      - 'null'
      - int
    doc: "Minimum cluster size for recruiting of small and leftover contigs (if not noAdd). Default: 10"
    inputBinding:
      position: 100
      prefix: --minRecruitingSize
  - id: recruit_to_abd_centroid
    type: 
      - 'null'
      - boolean
    doc: "[EXPERIMENTAL] Use the weighted-by-abundance centroid of a cluster to recruit small and lost contigs"
    inputBinding:
      position: 100
      prefix: --recruitToAbdCentroid
  - id: recruit_with_tnf
    type: 
      - 'null'
      - float
    doc: "[EXPERIMENTAL] If non-zero (and not noAdd), factor against the large-contig TNF threshold for small and lost contigs. Default: 0"
    inputBinding:
      position: 100
      prefix: --recruitWithTNF
  - id: cv_ext
    type: 
      - 'null'
      - boolean
    doc: "A coverage file without variance (from third party tools) is used instead of abdFile from jgi_summarize_bam_contig_depths"
    inputBinding:
      position: 100
      prefix: --cvExt
  - id: min_cv
    type: 
      - 'null'
      - float
    doc: "Minimum mean coverage of a contig in each library for binning. Default: 1"
    inputBinding:
      position: 100
      prefix: --minCV
  - id: min_cv_sum
    type: 
      - 'null'
      - float
    doc: "Minimum total effective mean coverage of a contig (sum of depth over minCV) for binning. Default: 1"
    inputBinding:
      position: 100
      prefix: --minCVSum
  - id: min_cls_size
    type: 
      - 'null'
      - int
    doc: "Minimum size of a bin as the output. Default: 200000"
    inputBinding:
      position: 100
      prefix: --minClsSize
  - id: num_threads
    type: 
      - 'null'
      - int
    doc: "Number of threads to use (0: use all cores). Default: 0"
    inputBinding:
      position: 100
      prefix: --numThreads
  - id: only_label
    type: 
      - 'null'
      - boolean
    doc: "Output only sequence labels as a list in a column without sequences"
    inputBinding:
      position: 100
      prefix: --onlyLabel
  - id: save_cls
    type: 
      - 'null'
      - boolean
    doc: "Save cluster memberships as a matrix format"
    inputBinding:
      position: 100
      prefix: --saveCls
  - id: unbinned
    type: 
      - 'null'
      - boolean
    doc: "Generate [outFile].unbinned.fa file for unbinned contigs"
    inputBinding:
      position: 100
      prefix: --unbinned
  - id: no_bin_out
    type: 
      - 'null'
      - boolean
    doc: "No bin output. Usually combined with saveCls to check only contig memberships"
    inputBinding:
      position: 100
      prefix: --noBinOut
  - id: no_sample_depths
    type: 
      - 'null'
      - boolean
    doc: "Do not include per-sample depths in bin fasta headers"
    inputBinding:
      position: 100
      prefix: --noSampleDepths
  - id: seed
    type: 
      - 'null'
      - int
    doc: "For exact reproducibility (0: use random seed). Default: 0"
    inputBinding:
      position: 100
      prefix: --seed
  - id: debug
    type: 
      - 'null'
      - boolean
    doc: "Debug output"
    inputBinding:
      position: 100
      prefix: --debug
  - id: quiet
    type: 
      - 'null'
      - boolean
    doc: "Be less verbose"
    inputBinding:
      position: 100
      prefix: --quiet
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "Be more verbose in output (on by default)"
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: bins
    type: File[]
    doc: "Bin fasta files (or contig name lists), plus unbinned/tooShort/lowDepth files when requested, and the cluster matrix"
    outputBinding:
      glob: $(inputs.out_file)*
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabat2:2.18--h6f16272_0
stdout: metabat2.out
stderr: metabat2.log
