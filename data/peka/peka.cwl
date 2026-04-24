cwlVersion: v1.2
class: CommandLineTool
baseCommand: peka
label: peka
doc: "Search for enriched motifs around thresholded crosslinks in CLIP data.\n\nTool
  homepage: https://github.com/ulelab/peka"
inputs:
  - id: all_outputs
    type:
      - 'null'
      - boolean
    doc: controls the number of outputs, can be True or False
    inputBinding:
      position: 101
      prefix: --alloutputs
  - id: clusters
    type:
      - 'null'
      - int
    doc: how many enriched kmers to cluster and plot
    inputBinding:
      position: 101
      prefix: --clusters
  - id: distal_window
    type:
      - 'null'
      - int
    doc: window around enriched kmers to calculate distribution
    inputBinding:
      position: 101
      prefix: --distalwindow
  - id: genome_fasta
    type: File
    doc: genome fasta file, ideally the same as was used for read alignment
    inputBinding:
      position: 101
      prefix: --genomefasta
  - id: genome_index
    type: File
    doc: genome fasta index file (.fai)
    inputBinding:
      position: 101
      prefix: --genomeindex
  - id: input_peaks
    type: File
    doc: CLIP peaks (intervals of crosslinks) in BED file format
    inputBinding:
      position: 101
      prefix: --inputpeaks
  - id: input_xlsites
    type: File
    doc: CLIP crosslinks in BED file format
    inputBinding:
      position: 101
      prefix: --inputxlsites
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: kmer length
    inputBinding:
      position: 101
      prefix: --kmerlength
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: output folder
    inputBinding:
      position: 101
      prefix: --outputpath
  - id: percentile
    type:
      - 'null'
      - float
    doc: Percentile for considering thresholded crosslinks. Accepts a value 
      between 0 and 1 [0, 1). Percentile 0.7 means that a cDNA count threshold 
      is determined at which >=70 percent of the crosslink sites within the 
      region have a cDNA count equal or below the threshold. Thresholded 
      crosslinks have cDNA count above the threshold.
    inputBinding:
      position: 101
      prefix: --percentile
  - id: regions
    type: File
    doc: genome segmentation file produced as output of "iCount segment" 
      function
    inputBinding:
      position: 101
      prefix: --regions
  - id: relaxed_prtxn
    type:
      - 'null'
      - boolean
    doc: Whether to relax automatically calculated prtxn threshold or not. Can 
      be 'True' or 'False', default is 'True'. If 'True', more positions will be
      included for PEKA-score calculation across k-mers. Using relaxed threshold
      is recommended, unless you have data of very high complexity and are using
      k-mer length <=5. This argument can't be used together with -pos argument,
      which sets a user-defined threshold for relevant positions.
    inputBinding:
      position: 101
      prefix: --relaxed_prtxn
  - id: relevant_pos_threshold
    type:
      - 'null'
      - float
    doc: Percentile to set as threshold for relevant positions. Accepted values 
      are floats between 0 and 99 [0, 99]. If threshold is set to 0 then all 
      positions within the set window (-w, default 20 nt) will be considered for
      enrichment calculation. If threshold is not zero, it will be used to 
      determine relevant positions for enrichment calculation for each k-mer. If
      the -pos option is not set, then the threshold will be automatically 
      assigned based on k-mer lengthand number of crosslinks in region.
    inputBinding:
      position: 101
      prefix: --relevant_pos_threshold
  - id: repeats
    type:
      - 'null'
      - string
    doc: 'how to treat repeating regions within genome (options: "masked", "unmasked",
      "repeats_only", "remove_repeats"). When applying any of the options with the
      exception of repeats == "unmasked", a genome with soft-masked repeat sequences
      should be used for input, ie. repeats in lowercase letters.'
    inputBinding:
      position: 101
      prefix: --repeats
  - id: set_seeds
    type:
      - 'null'
      - boolean
    doc: If you want to ensure reproducibility of results the option set_seeds 
      must be set to True. Can be True or False [DEFAULT True]. Note that 
      setting seeds reduces the randomness of background sampling.
    inputBinding:
      position: 101
      prefix: --set_seeds
  - id: smoothing
    type:
      - 'null'
      - int
    doc: window used for smoothing kmer positional distribution curves
    inputBinding:
      position: 101
      prefix: --smoothing
  - id: specific_region
    type:
      - 'null'
      - type: array
        items: string
    doc: choose to run PEKA on a specific region only, to specify multiple 
      regions enter them space separated
    inputBinding:
      position: 101
      prefix: --specificregion
  - id: subsample
    type:
      - 'null'
      - boolean
    doc: if the crosslinks file is very large, they can be subsampled to reduce 
      runtime, can be True/False
    inputBinding:
      position: 101
      prefix: --subsample
  - id: top_n
    type:
      - 'null'
      - int
    doc: number of kmers ranked by z-score in descending order for clustering 
      and plotting
    inputBinding:
      position: 101
      prefix: --topn
  - id: window
    type:
      - 'null'
      - int
    doc: window around thresholded crosslinks for finding enriched kmers
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peka:1.0.2--pyhdfd78af_0
stdout: peka.out
