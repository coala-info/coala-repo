cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smap
  - design
label: ngs-smap_smap_design
doc: "Returns per gene specific amplicons with or without one or more guides\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: fasta_file
    type: File
    doc: "Path to the Fasta file containing all genes to screen"
    inputBinding:
      position: 1
  - id: gff_file
    type: File
    doc: "Path to the GFF3 file containing at least the CDS feature with positions relative to the fasta file"
    inputBinding:
      position: 2
  - id: gRNAfile
    type:
      - 'null'
      - File
    doc: "CRISPOR, FlashFry or other gRNA design program output file.The CRISPOR and Flashfry file must contain a header and 12 columns. Check the manual for specifics"
    inputBinding:
      position: 10
      prefix: --gRNAfile
  - id: gRNAsource
    type:
      - 'null'
      - string
    doc: "What is the source of the gRNA file? Enter \"CRISPOR\", \"FlashFry\" or \"other\" (default = FlashFry)"
    inputBinding:
      position: 10
      prefix: --gRNAsource
  - id: output
    type:
      - 'null'
      - string
    doc: "Name of the output files (default = SMAPdesign)"
    inputBinding:
      position: 10
      prefix: --output
  - id: numberAmplicons
    type:
      - 'null'
      - int
    doc: "The maximum number of non-overlapping amplicons per gene in the output (default = 2)"
    inputBinding:
      position: 10
      prefix: --numberAmplicons
  - id: numbergRNAs
    type:
      - 'null'
      - int
    doc: "Maximum number of gRNAs to retain per amplicon (default = 2)"
    inputBinding:
      position: 10
      prefix: --numbergRNAs
  - id: minimumAmpliconLength
    type:
      - 'null'
      - int
    doc: "The minimum length of the amplicons in base pairs (default = 120)"
    inputBinding:
      position: 10
      prefix: --minimumAmpliconLength
  - id: maximumAmpliconLength
    type:
      - 'null'
      - int
    doc: "The maximum length of the amplicons in base pairs (default = 150)"
    inputBinding:
      position: 10
      prefix: --maximumAmpliconLength
  - id: primerMaxLibraryMispriming
    type:
      - 'null'
      - int
    doc: "The maximum allowed weighted similarity of a primer with any sequence in the target gene set (Primer3 setting) (dault = 12)"
    inputBinding:
      position: 10
      prefix: --primerMaxLibraryMispriming
  - id: primerPairMaxLibraryMispriming
    type:
      - 'null'
      - int
    doc: "The maximum allowed sum of similarities of a primer pair (one similarity for each primer) with any single sequence in the target gene set (Primer3 setting) (default = 24)"
    inputBinding:
      position: 10
      prefix: --primerPairMaxLibraryMispriming
  - id: primerMaxTemplateMispriming
    type:
      - 'null'
      - int
    doc: "The maximum allowed similarity of a primer to ectopic sites in the template (Primer3 setting) (default = 12)"
    inputBinding:
      position: 10
      prefix: --primerMaxTemplateMispriming
  - id: primerPairMaxTemplateMispriming
    type:
      - 'null'
      - int
    doc: "The maximum allowed summed similarity of both primers to ectopic sites in the template (Primer3 setting) (default = 24)"
    inputBinding:
      position: 10
      prefix: --primerPairMaxTemplateMispriming
  - id: homopolymer
    type:
      - 'null'
      - int
    doc: "The minimum number of repeated identical nucleotides in an amplicon to be discarded. E.g. if this parameter is set to 8, amplicons containing a polymer of 8 As (-...AAAAAAAA...-), Ts, Gs, or Cs or more will not be used (default = 10)"
    inputBinding:
      position: 10
      prefix: --homopolymer
  - id: summary
    type:
      - 'null'
      - boolean
    doc: "Write summary file and plot of the output"
    inputBinding:
      position: 10
      prefix: --summary
  - id: selectGenes
    type:
      - 'null'
      - File
    doc: "List of genes (one per line) to which amplicons and guides must be designed. The other genes in the fasta file will be used to check for specificity only (default: for all genes in the fasta the design is done)"
    inputBinding:
      position: 10
      prefix: --selectGenes
  - id: distance
    type:
      - 'null'
      - int
    doc: "Minimum number of bases between primer and gRNA (default = 15)"
    inputBinding:
      position: 10
      prefix: --distance
  - id: gRNAoverlap
    type:
      - 'null'
      - int
    doc: "The minimum number of bases between the start of two gRNAs (default = 5)"
    inputBinding:
      position: 10
      prefix: --gRNAoverlap
  - id: generateAmplicons
    type:
      - 'null'
      - int
    doc: "Number of amplicons to generate per gene by Primer3 (default = 150). To generate 50 amplicons per 1000 bases per gene enter -1"
    inputBinding:
      position: 10
      prefix: --generateAmplicons
  - id: threshold
    type:
      - 'null'
      - int
    doc: "Minimum gRNA MIT score allowed (default = 80)"
    inputBinding:
      position: 10
      prefix: --threshold
  - id: borderLength
    type:
      - 'null'
      - int
    doc: "The length of the borders (for SMAP haplotype window) (default = 10)"
    inputBinding:
      position: 10
      prefix: --borderLength
  - id: ampliconLabel
    type:
      - 'null'
      - boolean
    doc: "Number the amplicons from left to right instead of from best to worst"
    inputBinding:
      position: 10
      prefix: --ampliconLabel
  - id: gRNAlabel
    type:
      - 'null'
      - boolean
    doc: "Number the gRNAs from left to right instead of from best to worst"
    inputBinding:
      position: 10
      prefix: --gRNAlabel
  - id: SMAPfiles
    type:
      - 'null'
      - boolean
    doc: "Write additional files for downstream analysis with other SMAP packages (a gff and bed border files and fasta gRNA file"
    inputBinding:
      position: 10
      prefix: --SMAPfiles
  - id: targetRegion5
    type:
      - 'null'
      - float
    doc: "The fraction of the coding sequence that cannot be targeted at the 5' end as indicated by a float between 0 and 1 (default = 0.2)"
    inputBinding:
      position: 10
      prefix: --targetRegion5
  - id: targetRegion3
    type:
      - 'null'
      - float
    doc: "The fraction of the coding sequence that cannot be targeted at the 3' end as indicated by a float between 0 and 1 (default = 0.2)"
    inputBinding:
      position: 10
      prefix: --targetRegion3
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Keep track of the primer design while the program is running"
    inputBinding:
      position: 10
      prefix: --verbose
  - id: allAmplicons
    type:
      - 'null'
      - boolean
    doc: "Return all amplicons with their respective gRNAs per gene (extra file)"
    inputBinding:
      position: 10
      prefix: --allAmplicons
  - id: targetSpecificRegion
    type:
      - 'null'
      - string
    doc: "Only target a specific region in the gene indicated by the feature name in the GFF file"
    inputBinding:
      position: 10
      prefix: --targetSpecificRegion
  - id: misPrimingAllowed
    type:
      - 'null'
      - boolean
    doc: "Do not check for mispriming in the gene set when designing primers. By default Primer3 will not allow primers that can prime at other genes in the gene set"
    inputBinding:
      position: 10
      prefix: --misPrimingAllowed
  - id: restrictPrimerDesign
    type:
      - 'null'
      - boolean
    doc: "This option will restrict primer design in large introns, increasing the speed of amplicon design."
    inputBinding:
      position: 10
      prefix: --restrictPrimerDesign
  - id: promoter
    type:
      - 'null'
      - string
    doc: "Give the last 6 bases of the promoter that will be used to express the gRNA. This will be taken into account when checking for BsaI or BbsI sites in the gRNA (default: U6 promoter = TGATTG)"
    inputBinding:
      position: 10
      prefix: --promoter
  - id: scaffold
    type:
      - 'null'
      - string
    doc: "Give the first 6 bases of the scaffold that will be used. This will be taken into account when checking for BsaI or BbsI sites in the gRNA (default = GTTTTA)"
    inputBinding:
      position: 10
      prefix: --scaffold
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Give a gff file with all amplicons designed by Primer3 and all gRNAs before filtering"
    inputBinding:
      position: 10
      prefix: --debug
  - id: preSelectedPrimers
    type:
      - 'null'
      - File
    doc: "Give a set of amplicons/primers for which you want to find gRNAs. The primers should be given in a gff with featurenames Primer_forward and Primer_reverse. The forward primer should be occur before the corresponding reverse primer in the gff file"
    inputBinding:
      position: 10
      prefix: --preSelectedPrimers
  - id: polyT
    type:
      - 'null'
      - int
    doc: "Minimum number of repeated Ts (in a poly-T) in the gRNA to avoid (default = 4)"
    inputBinding:
      position: 10
      prefix: --polyT
  - id: restrictionSite
    type:
      - 'null'
      - boolean
    doc: "Do not filter out gRNAs that contain a BsaI or BbsI restriction site"
    inputBinding:
      position: 10
      prefix: --restrictionSite
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Amplicon and gRNA design tables and files written by SMAP design"
    outputBinding:
      glob:
        - "*.tsv"
        - "*.gff"
        - "*.gff3"
        - "*.bed"
        - "*.png"
        - "*.pdf"
        - "*.fasta"
        - "*.fa"
        - "*.txt"
        - "*.csv"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
