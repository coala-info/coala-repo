cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabat1
label: metabat2_metabat1
doc: "MetaBAT 1: metagenome binning based on abundance and tetranucleotide frequency (legacy version).\n\nTool homepage: https://bitbucket.org/berkeleylab/metabat"
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
    doc: "Base file name for each bin. The default output is fasta format. Use onlyLabel to output only contig names [Mandatory]"
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
  - id: cv_ext
    type: 
      - 'null'
      - boolean
    doc: "A coverage file without variance (from third party tools) is used instead of abdFile"
    inputBinding:
      position: 100
      prefix: --cvExt
  - id: pair_file
    type: 
      - 'null'
      - File
    doc: "A file having paired reads mapping information (tab delimited: contig index, mate contig index, supporting mean read coverage)"
    inputBinding:
      position: 100
      prefix: --pairFile
  - id: p1
    type: 
      - 'null'
      - int
    doc: "Probability cutoff for bin seeding (percentage 0-100). Default: 0"
    inputBinding:
      position: 100
      prefix: --p1
  - id: p2
    type: 
      - 'null'
      - int
    doc: "Probability cutoff for secondary neighbors (percentage 0-100). Default: 0"
    inputBinding:
      position: 100
      prefix: --p2
  - id: min_prob
    type: 
      - 'null'
      - int
    doc: "Minimum probability for binning consideration (percentage 0-100). Default: 0"
    inputBinding:
      position: 100
      prefix: --minProb
  - id: min_binned
    type: 
      - 'null'
      - int
    doc: "Minimum proportion of already binned neighbors for one's membership inference (percentage 0-100). Default: 0"
    inputBinding:
      position: 100
      prefix: --minBinned
  - id: verysensitive
    type: 
      - 'null'
      - boolean
    doc: "Shortcut for --p1 90 --p2 85 --pB 20 --minProb 75 --minBinned 20 --minCorr 90"
    inputBinding:
      position: 100
      prefix: --verysensitive
  - id: sensitive
    type: 
      - 'null'
      - boolean
    doc: "Better sensitivity [default]; shortcut for --p1 90 --p2 90 --pB 20 --minProb 80 --minBinned 40 --minCorr 92"
    inputBinding:
      position: 100
      prefix: --sensitive
  - id: specific
    type: 
      - 'null'
      - boolean
    doc: "Better specificity; shortcut for --p1 90 --p2 90 --pB 30 --minProb 80 --minBinned 40 --minCorr 96"
    inputBinding:
      position: 100
      prefix: --specific
  - id: veryspecific
    type: 
      - 'null'
      - boolean
    doc: "Greater specificity; shortcut for --p1 90 --p2 90 --pB 40 --minProb 80 --minBinned 40"
    inputBinding:
      position: 100
      prefix: --veryspecific
  - id: superspecific
    type: 
      - 'null'
      - boolean
    doc: "Best specificity; shortcut for --p1 95 --p2 90 --pB 50 --minProb 80 --minBinned 20"
    inputBinding:
      position: 100
      prefix: --superspecific
  - id: min_corr
    type: 
      - 'null'
      - int
    doc: "Minimum pearson correlation coefficient for binning missed contigs (percentage; 0 disables). Default: 0"
    inputBinding:
      position: 100
      prefix: --minCorr
  - id: min_samples
    type: 
      - 'null'
      - int
    doc: "Minimum number of sample sizes for considering correlation based recruiting. Default: 10"
    inputBinding:
      position: 100
      prefix: --minSamples
  - id: min_cv
    type: 
      - 'null'
      - float
    doc: "Minimum mean coverage of a contig to consider for abundance distance calculation in each library. Default: 1"
    inputBinding:
      position: 100
      prefix: --minCV
  - id: min_cv_sum
    type: 
      - 'null'
      - float
    doc: "Minimum total mean coverage of a contig (sum of all libraries). Default: 2"
    inputBinding:
      position: 100
      prefix: --minCVSum
  - id: min_cls_size
    type: 
      - 'null'
      - int
    doc: "Minimum size of a bin to be considered as the output. Default: 200000"
    inputBinding:
      position: 100
      prefix: --minClsSize
  - id: min_contig
    type: 
      - 'null'
      - int
    doc: "Minimum size of a contig to be considered for binning (should be >=1500). Default: 2500"
    inputBinding:
      position: 100
      prefix: --minContig
  - id: min_contig_by_corr
    type: 
      - 'null'
      - int
    doc: "Minimum size of a contig to be considered for recruiting by pearson correlation coefficients. Default: 1000"
    inputBinding:
      position: 100
      prefix: --minContigByCorr
  - id: num_threads
    type: 
      - 'null'
      - int
    doc: "Number of threads to use (0: use all cores). Default: 0"
    inputBinding:
      position: 100
      prefix: --numThreads
  - id: min_shared
    type: 
      - 'null'
      - int
    doc: "Percentage cutoff for merging fuzzy contigs. Default: 50"
    inputBinding:
      position: 100
      prefix: --minShared
  - id: fuzzy
    type: 
      - 'null'
      - boolean
    doc: "Binning with fuzziness which assigns multiple memberships of a contig to bins (only with pairFile)"
    inputBinding:
      position: 100
      prefix: --fuzzy
  - id: only_label
    type: 
      - 'null'
      - boolean
    doc: "Output only sequence labels as a list in a column without sequences"
    inputBinding:
      position: 100
      prefix: --onlyLabel
  - id: sum_low_cv
    type: 
      - 'null'
      - boolean
    doc: "Every sample that falls below the minCV will be used in an aggregate sample"
    inputBinding:
      position: 100
      prefix: --sumLowCV
  - id: max_var_ratio
    type: 
      - 'null'
      - float
    doc: "Ignore any contigs where variance / mean exceeds this ratio (0 disables). Default: 0"
    inputBinding:
      position: 100
      prefix: --maxVarRatio
  - id: save_tnf
    type: 
      - 'null'
      - string
    doc: "File to save (or load if exists) TNF matrix for each contig in input"
    inputBinding:
      position: 100
      prefix: --saveTNF
  - id: save_distance
    type: 
      - 'null'
      - string
    doc: "File to save (or load if exists) distance graph at lowest probability cutoff"
    inputBinding:
      position: 100
      prefix: --saveDistance
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
  - id: bootstraps
    type: 
      - 'null'
      - int
    doc: "Number of bootstrapping for ensemble binning (recommended >=20). Default: 20"
    inputBinding:
      position: 100
      prefix: --B
  - id: p_b
    type: 
      - 'null'
      - int
    doc: "Proportion of shared membership in bootstrapping (percentage 0-100). Default: 50"
    inputBinding:
      position: 100
      prefix: --pB
  - id: seed
    type: 
      - 'null'
      - int
    doc: "For reproducibility in ensemble binning (0: use random seed). Default: 0"
    inputBinding:
      position: 100
      prefix: --seed
  - id: keep
    type: 
      - 'null'
      - boolean
    doc: "Keep the intermediate files for later usage"
    inputBinding:
      position: 100
      prefix: --keep
  - id: debug
    type: 
      - 'null'
      - boolean
    doc: "Debug output"
    inputBinding:
      position: 100
      prefix: --debug
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "Verbose output"
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: bins
    type: File[]
    doc: "Bin fasta files (or contig name lists) and other files with the output prefix"
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
stdout: metabat1.out
stderr: metabat1.log
