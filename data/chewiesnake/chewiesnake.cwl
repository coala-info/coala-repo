cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewiesnake
label: chewiesnake
doc: "chewiesnake is a pipeline for cgMLST analysis.\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/chewieSnake"
inputs:
  - id: address_range
    type:
      - 'null'
      - string
    doc: 'A comma separated set of cutoff values for defining the clustering address
      (Default: 1,5,10,20,50,100,200,1000)'
    default: 1,5,10,20,50,100,200,1000
    inputBinding:
      position: 101
      prefix: --address_range
  - id: allele_length_threshold
    type:
      - 'null'
      - float
    doc: Maximum tolerated allele length deviance compared to median allele 
      length of locus; choose integer for "absolute frameshift mode and float 
      (0..1) for "relative" frameshift mode ; default=0.1
    default: 0.1
    inputBinding:
      position: 101
      prefix: --allele_length_threshold
  - id: assembler
    type:
      - 'null'
      - string
    doc: 'Assembler to use in shovill, choose from megahit velvet skesa spades (default:
      spades)'
    default: spades
    inputBinding:
      position: 101
      prefix: --assembler
  - id: bsr_threshold
    type:
      - 'null'
      - float
    doc: blast scoring ratio threshold to use , default = 0.6
    default: 0.6
    inputBinding:
      position: 101
      prefix: --bsr_threshold
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: The agglomeration method to be used for hierarchical clustering. This 
      should be (an unambiguous abbreviation of) one of "ward.D", "ward.D2", 
      "single", "complete", "average" (= UPGMA), "mcquitty" (= WPGMA), "median" 
      (= WPGMC) or "centroid" (= UPGMC); default = single
    default: single
    inputBinding:
      position: 101
      prefix: --clustering_method
  - id: comparison
    type:
      - 'null'
      - boolean
    doc: Compare these results to pre-computed allele database
    inputBinding:
      position: 101
      prefix: --comparison
  - id: comparison_db
    type:
      - 'null'
      - Directory
    doc: Path to pre-computed allele database for comparison
    inputBinding:
      position: 101
      prefix: --comparison_db
  - id: conda_frontend
    type:
      - 'null'
      - boolean
    doc: Do not mamba but conda as frontend to create individual module' 
      software environments
    inputBinding:
      position: 101
      prefix: --conda_frontend
  - id: condaprefix
    type:
      - 'null'
      - Directory
    doc: Path of default conda environment, enables recycling built 
      environments, default is in folder conda_env in repository directory.
    inputBinding:
      position: 101
      prefix: --condaprefix
  - id: distance_method
    type:
      - 'null'
      - int
    doc: Grapetree distance method; default = 3
    default: 3
    inputBinding:
      position: 101
      prefix: --distance_method
  - id: distance_threshold
    type:
      - 'null'
      - int
    doc: A single distance threshold for the extraction of sub-trees; default = 
      10
    default: 10
    inputBinding:
      position: 101
      prefix: --distance_threshold
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Snakemake dryrun. Only calculate graph without executing anything
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: forceall
    type:
      - 'null'
      - boolean
    doc: Snakemake force. Force recalculation of all steps
    inputBinding:
      position: 101
      prefix: --forceall
  - id: frameshift_mode
    type:
      - 'null'
      - string
    doc: Whether to consider absolute or relative differences of allele length 
      for frameshifts removal. Choose from "absolute" and "relative", 
      default="relative"
    default: relative
    inputBinding:
      position: 101
      prefix: --frameshift_mode
  - id: joining_threshold
    type:
      - 'null'
      - int
    doc: A distance threshold for joining data with comparsion_db; default = 30
    default: 30
    inputBinding:
      position: 101
      prefix: --joining_threshold
  - id: logdir
    type:
      - 'null'
      - Directory
    doc: Path to directory whete .snakemake output is to be saved
    inputBinding:
      position: 101
      prefix: --logdir
  - id: min_trimmed_length
    type:
      - 'null'
      - int
    doc: Minimum length of a read to keep, default = 15
    default: 15
    inputBinding:
      position: 101
      prefix: --min_trimmed_length
  - id: prodigal
    type: File
    doc: Path to prodigal_training_file (e.g. provided in chewbbaca, 
      path/to/chewieSnake/chewBBACA/CHEWBBACA/prodigal_training_file, e.g. 
      /usr/local/opt/chewiesnake/chewBBACA/CHEWBBACA/prodigal_training_files/Salmonella_enterica.trn
    inputBinding:
      position: 101
      prefix: --prodigal
  - id: reads
    type:
      - 'null'
      - boolean
    doc: Input data is reads. Assemble (using shovill) prior to allele calling 
      (default is contigs)
    inputBinding:
      position: 101
      prefix: --reads
  - id: remove_frameshifts
    type:
      - 'null'
      - boolean
    doc: remove frameshift alleles by deviating allele length
    inputBinding:
      position: 101
      prefix: --remove_frameshifts
  - id: report
    type:
      - 'null'
      - boolean
    doc: Create html report
    inputBinding:
      position: 101
      prefix: --report
  - id: sample_list
    type: File
    doc: List of samples to analyze, as a two column tsv file with columns 
      sample and assembly. Can be generated with provided script 
      create_sampleSheet,sh
    inputBinding:
      position: 101
      prefix: --sample_list
  - id: scheme
    type: Directory
    doc: Path to directory of the cgmlst scheme
    inputBinding:
      position: 101
      prefix: --scheme
  - id: shovill_depth
    type:
      - 'null'
      - int
    doc: 'Sub-sample --R1/--R2 to this depth. Disable with --depth 0 (default: 100)'
    default: 100
    inputBinding:
      position: 101
      prefix: --shovill_depth
  - id: shovill_extraopts
    type:
      - 'null'
      - string
    doc: 'Extra options for shovill (default: "")'
    default: ''
    inputBinding:
      position: 101
      prefix: --shovill_extraopts
  - id: shovill_modules
    type:
      - 'null'
      - string
    doc: 'Module options for shovill, choose from --noreadcorr --trim --nostitch --nocorr
      --noreadcorr (default: "--noreadcorr")'
    default: --noreadcorr
    inputBinding:
      position: 101
      prefix: --shovill_modules
  - id: shovill_output_options
    type:
      - 'null'
      - string
    doc: 'Extra output options for shovill (default: "")'
    default: ''
    inputBinding:
      position: 101
      prefix: --shovill_output_options
  - id: shovill_tmpdir
    type:
      - 'null'
      - Directory
    doc: 'Fast temporary directory (default: "")'
    default: ''
    inputBinding:
      position: 101
      prefix: --shovill_tmpdir
  - id: size_threshold
    type:
      - 'null'
      - float
    doc: size threshold, default at 0.2 means alleles with size variation of 
      +-20 percent will be tagged as ASM/ALM , default = 0.2
    default: 0.2
    inputBinding:
      position: 101
      prefix: --size_threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use. Note that samples can only be processed 
      sequentially due to the required database access. However the allele 
      calling can be executed in parallel for the different loci, default = 10
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: threads_sample
    type:
      - 'null'
      - int
    doc: Number of Threads to use per sample, default = 10
    default: 10
    inputBinding:
      position: 101
      prefix: --threads_sample
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: unlock snakemake
    inputBinding:
      position: 101
      prefix: --unlock
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Utilize "--useconda" option, i.e. all software dependencies are 
      available in a single env
    inputBinding:
      position: 101
      prefix: --use_conda
  - id: working_directory
    type: Directory
    doc: Working directory where results are saved
    inputBinding:
      position: 101
      prefix: --working_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewiesnake:3.0.0--hdfd78af_2
stdout: chewiesnake.out
