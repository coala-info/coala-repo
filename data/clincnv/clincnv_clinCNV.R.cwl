cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinCNV.R
label: clincnv_clinCNV.R
doc: "Run the clinCNV R script. Requires absolute paths for input files. At least
  normal coverages and a BED file path must be specified.\n\nTool homepage: https://github.com/imgag/ClinCNV"
inputs:
  - id: baf_folder
    type:
      - 'null'
      - Directory
    doc: folder where you put BAF frequencies (one per normal, one per tumor 
      sample)
    inputBinding:
      position: 101
      prefix: --bafFolder
  - id: bed
    type: File
    doc: bed file with panel description (chr start end gc_content annotation). 
      has to use same notation as .cov files.
    inputBinding:
      position: 101
      prefix: --bed
  - id: bed_offtarget
    type:
      - 'null'
      - File
    doc: offtarget bed file with panel description (chr start end gc_content 
      annotation). has to use same notation as .cov files.
    inputBinding:
      position: 101
      prefix: --bedOfftarget
  - id: clonality_for_checking
    type:
      - 'null'
      - float
    doc: Starting from which clonality BAF-based QC-control has to be applied 
      (no allelic balanced variants with smaller purity will be detected!)
    inputBinding:
      position: 101
      prefix: --clonalityForChecking
  - id: clone_penalty
    type:
      - 'null'
      - int
    doc: penalty for each additional clone (if you feel that you have some false
      positive clones, increase this value from default 300)
    inputBinding:
      position: 101
      prefix: --clonePenalty
  - id: cluster_provided
    type:
      - 'null'
      - File
    doc: Use external clustering (file with lines, sample ID cluster ID
    inputBinding:
      position: 101
      prefix: --clusterProvided
  - id: col_num
    type:
      - 'null'
      - int
    doc: column where coverages start
    inputBinding:
      position: 101
      prefix: --colNum
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debugging information while running.
    inputBinding:
      position: 101
      prefix: --debug
  - id: degrees_of_freedom_student
    type:
      - 'null'
      - int
    doc: number of degrees of freedom of Student's distribution for somatic 
      analysis (a lot of outliers => reduce the default value of 1000 to e.g. 
      10)
    inputBinding:
      position: 101
      prefix: --degreesOfFreedomStudent
  - id: fdr_germline
    type:
      - 'null'
      - int
    doc: number of iterations for FDR check (more - better, but slower, 0 = no 
      FDR correction)
    inputBinding:
      position: 101
      prefix: --fdrGermline
  - id: filter_step
    type:
      - 'null'
      - int
    doc: This value indicates if ClinCNV should perform QC internally (starting 
      from threshold specified by --clonalityForChecking). Value 0 means no, 
      value 1 - only for finding clonality, value 2 - for clonality and final 
      calls too
    inputBinding:
      position: 101
      prefix: --filterStep
  - id: folder_with_script
    type:
      - 'null'
      - Directory
    doc: folder where you put script
    inputBinding:
      position: 101
      prefix: --folderWithScript
  - id: guide_baseline
    type:
      - 'null'
      - string
    doc: For complex samples with potential whole-genome duplication - string 
      denoting which region you suspect to be diploid so tool will take it is a 
      baseline (format chrN:12345-67890)
    inputBinding:
      position: 101
      prefix: --guideBaseline
  - id: hg38
    type:
      - 'null'
      - boolean
    doc: Work with hg38 cytobands switch
    inputBinding:
      position: 101
      prefix: --hg38
  - id: length_g
    type:
      - 'null'
      - int
    doc: minimum threshold for length of germline variants
    inputBinding:
      position: 101
      prefix: --lengthG
  - id: length_s
    type:
      - 'null'
      - int
    doc: minimum threshold for length of somatic variants
    inputBinding:
      position: 101
      prefix: --lengthS
  - id: max_num_germ_cnvs
    type:
      - 'null'
      - int
    doc: maximum number of germline CNVs allowed (increase thresholds if does 
      not meet criteria)
    inputBinding:
      position: 101
      prefix: --maxNumGermCNVs
  - id: max_num_iter
    type:
      - 'null'
      - int
    doc: maximum number of iterations of variant calling
    inputBinding:
      position: 101
      prefix: --maxNumIter
  - id: max_num_som_cnas
    type:
      - 'null'
      - int
    doc: maximum number of somatic CNAs allowed (increase thresholds if does not
      meet criteria)
    inputBinding:
      position: 101
      prefix: --maxNumSomCNAs
  - id: maximum_somatic_cn
    type:
      - 'null'
      - int
    doc: The highest allowed somatic copy-number (higher = more accurate, but 
      slower), [default= 30]
    inputBinding:
      position: 101
      prefix: --maximumSomaticCN
  - id: minimum_num_of_elems_in_cluster
    type:
      - 'null'
      - int
    doc: minimum number of elements in cluster (done for germline), default=100,
      clustering happens only if number of samples bigger than 3 by number of 
      elements in cluster
    inputBinding:
      position: 101
      prefix: --minimumNumOfElemsInCluster
  - id: minimum_purity
    type:
      - 'null'
      - float
    doc: minimum purity for somatic samples
    inputBinding:
      position: 101
      prefix: --minimumPurity
  - id: mosaicism
    type:
      - 'null'
      - boolean
    doc: if mosaic calling should be performed
    inputBinding:
      position: 101
      prefix: --mosaicism
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Do not perform additional plotting
    inputBinding:
      position: 101
      prefix: --noPlot
  - id: normal
    type: File
    doc: path to table with normal coverages
    inputBinding:
      position: 101
      prefix: --normal
  - id: normal_offtarget
    type:
      - 'null'
      - File
    doc: path to table with normal offtarget coverages
    inputBinding:
      position: 101
      prefix: --normalOfftarget
  - id: normal_sample
    type:
      - 'null'
      - string
    doc: name of normal sample to analyse (if only one sample has to be 
      analysed)
    inputBinding:
      position: 101
      prefix: --normalSample
  - id: not_complex_tumor
    type:
      - 'null'
      - boolean
    doc: Sometimes some CNAs happen in the same region twice and leave the 
      signature unrecognizable by simple models. Specify this flag if you don't 
      want the 2nd CNAs to be recognized by ClinCNV.
    inputBinding:
      position: 101
      prefix: --notComplexTumor
  - id: number_of_threads
    type:
      - 'null'
      - int
    doc: number of threads used for some bottleneck parts, default=1
    inputBinding:
      position: 101
      prefix: --numberOfThreads
  - id: only_tumor
    type:
      - 'null'
      - boolean
    doc: if tumor only calling is to be performed
    inputBinding:
      position: 101
      prefix: --onlyTumor
  - id: out
    type:
      - 'null'
      - Directory
    doc: output folder path
    inputBinding:
      position: 101
      prefix: --out
  - id: pair
    type:
      - 'null'
      - File
    doc: file with pairing information, 1st column = tumor, 2nd column = normal
    inputBinding:
      position: 101
      prefix: --pair
  - id: panel_gc
    type:
      - 'null'
      - boolean
    doc: Remove less GC extreme regions, useful for panels, almost does not 
      effect for genomes
    inputBinding:
      position: 101
      prefix: --panelGC
  - id: par
    type:
      - 'null'
      - string
    doc: coordinates of chrX paralogous regions (format 
      chrX:60001-2699520;chrX:154931044-155260560 )
    inputBinding:
      position: 101
      prefix: --par
  - id: pnealty_higher_copy
    type:
      - 'null'
      - int
    doc: 'How big should be penalty for higher copy? This is penalty for each additional
      copy, one per CNV. (smaller values: more big copy-number allowed, lower clonal
      cancer cell fraction)'
    inputBinding:
      position: 101
      prefix: --pnealtyHigherCopy
  - id: pnealty_higher_copy_one_segment
    type:
      - 'null'
      - int
    doc: 'How big should be penalty for higher copy? This is penalty for each additional
      copy, one per region in CNV. (smaller values: more big copy-number allowed,
      lower clonal cancer cell fraction)'
    inputBinding:
      position: 101
      prefix: --pnealtyHigherCopyOneSegment
  - id: polymorphic_calling
    type:
      - 'null'
      - string
    doc: should calling of polymorphic regions be performed, YES = calling is 
      performed, NO = no polymorphic calling (default), any other string = mCNVs
      taken from the file with that path (it must have at least 3 columns 
      chrom-start-end)
    inputBinding:
      position: 101
      prefix: --polymorphicCalling
  - id: polymorphic_genotyping
    type:
      - 'null'
      - string
    doc: should genotyping of polymorphic regions be performed, YES = genotyping
      is performed, NO = no genotyping. The BED file with polymorphic regions 
      should be supplied via --polymorphicCalling command!
    inputBinding:
      position: 101
      prefix: --polymorphicGenotyping
  - id: purity_step
    type:
      - 'null'
      - float
    doc: step of purity we investigate (from 5% to 100% with the step you 
      specify, default=2.5)
    inputBinding:
      position: 101
      prefix: --purityStep
  - id: reanalyse_cohort
    type:
      - 'null'
      - boolean
    doc: if specified, reanalyses whole cohort
    inputBinding:
      position: 101
      prefix: --reanalyseCohort
  - id: score_g
    type:
      - 'null'
      - float
    doc: minimum threshold for significance germline variants
    inputBinding:
      position: 101
      prefix: --scoreG
  - id: score_s
    type:
      - 'null'
      - float
    doc: minimum threshold for significance somatic variants
    inputBinding:
      position: 101
      prefix: --scoreS
  - id: sex
    type:
      - 'null'
      - string
    doc: override the sample's gender (active only when you specify 
      --normalSample flag)
    inputBinding:
      position: 101
      prefix: --sex
  - id: shift_to_try
    type:
      - 'null'
      - int
    doc: change only if you have a sample with lots of allelic imbalance (if you
      think that the diploid baseline should be different, number of options for
      choosing will be provided during calling)
    inputBinding:
      position: 101
      prefix: --shiftToTry
  - id: super_recall
    type:
      - 'null'
      - boolean
    doc: Super recall mode - after calling normal CNVs it tries to find CNVs 
      with any length that are better than pre-specified threshold
    inputBinding:
      position: 101
      prefix: --superRecall
  - id: trios_file
    type:
      - 'null'
      - File
    doc: file with information about trios, child-father-mother
    inputBinding:
      position: 101
      prefix: --triosFile
  - id: tumor
    type: File
    doc: path to table with tumor coverages
    inputBinding:
      position: 101
      prefix: --tumor
  - id: tumor_offtarget
    type:
      - 'null'
      - File
    doc: path to table with tumor offtarget coverages
    inputBinding:
      position: 101
      prefix: --tumorOfftarget
  - id: tumor_sample
    type:
      - 'null'
      - string
    doc: name of tumor sample to analyse (if only one sample has to be analysed,
      normal has to be provided too)
    inputBinding:
      position: 101
      prefix: --tumorSample
  - id: visulization_igv
    type:
      - 'null'
      - boolean
    doc: if you dont need IGV tracks as output, specify this flag (as printing 
      out IGV tracks slows down the program)
    inputBinding:
      position: 101
      prefix: --visulizationIGV
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clincnv:1.19.1--hdfd78af_0
stdout: clincnv_clinCNV.R.out
