cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_kaks_analysis_KaKsAnalysis
label: plant_tribes_kaks_analysis_KaKsAnalysis
doc: "DETERMINE PAIRWISE SEQUENCE SYNONYMOUS SUBSTITUTIONS (Ks) AND SIGNIFICANT DUPLICATION
  COMPONENTS\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs:
  - id: codeml_ctl_file
    type:
      - 'null'
      - string
    doc: "PAML's codeml control file to carry out ML analysis of protein-coding DNA
      sequences using codon \n                                            substitution
      models. The defaults in the \"codeml.ctl.args\" template in the config directory
      of\n                                            the installation will be used
      if not provided. NOTE: input (seqfile, treefile) and output (outfile)\n    \
      \                                        parameters of codeml are not included
      in the template."
    inputBinding:
      position: 101
      prefix: --codeml_ctl_file
  - id: coding_sequences_species_1
    type: string
    doc: Coding sequences (CDS) fasta file for the first species (species1.fna)
    inputBinding:
      position: 101
      prefix: --coding_sequences_species_1
  - id: coding_sequences_species_2
    type:
      - 'null'
      - string
    doc: "Coding sequences (CDS) fasta file for the first species (species2.fna)\n\
      \                                            requires \"--comparison\" to be
      set to \"orthologs\""
    inputBinding:
      position: 101
      prefix: --coding_sequences_species_2
  - id: comparison
    type: string
    doc: "pairwise sequence comparison to determine homolgous pairs\n            \
      \                                If self species comparison: paralogs\n    \
      \                                        If cross species comparison: orthologs
      (requires second species data)"
    inputBinding:
      position: 101
      prefix: --comparison
  - id: crb_blast
    type:
      - 'null'
      - string
    doc: "Use conditional reciprocal best BLAST to determine for cross-species orthologs\n\
      \                                            instead of the default reciprocal
      best BLAST\n                                            requires \"--comparison\"\
      \ to be set to \"orthologs\""
    inputBinding:
      position: 101
      prefix: --crb_blast
  - id: fit_components
    type:
      - 'null'
      - boolean
    doc: "Fit a mixture model of multivariate normal components to synonymous (ks)
      distribution to identify\n                                            significant
      duplication event(s) in a genome"
    inputBinding:
      position: 101
      prefix: --fit_components
  - id: max_ks
    type:
      - 'null'
      - float
    doc: "Upper limit of synonymous substitutions (ks) - necessary if fitting components
      to the distribution to\n                                            exclude
      likey ancient paralogous pairs."
    inputBinding:
      position: 101
      prefix: --max_ks
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: "Minimum sequence pairwise coverage length between homologous pairs\n   \
      \                                         Default: 0.5 (50% coverage) - [0.3
      to 1.0]"
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_ks
    type:
      - 'null'
      - float
    doc: "Lower limit of synonymous substitutions (ks) - necessary if fitting components
      to the distribution to\n                                            reduce background
      noise from young paralogous pairs due to normal gene births and deaths in a
      genome."
    inputBinding:
      position: 101
      prefix: --min_ks
  - id: num_of_components
    type:
      - 'null'
      - int
    doc: Number components to fit to synonymous substitutions (ks) distribution 
      - required if "--fit_components"
    inputBinding:
      position: 101
      prefix: --num_of_components
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "number of threads (CPUs)\n                                            Default:
      1"
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: proteins_species_1
    type: string
    doc: Amino acids (proteins) sequences fasta file for the first species 
      (species1.faa)
    inputBinding:
      position: 101
      prefix: --proteins_species_1
  - id: proteins_species_2
    type:
      - 'null'
      - string
    doc: "Amino acids (proteins) sequences fasta file for the first species (species2.faa)\n\
      \                                            requires \"--comparison\" to be
      set to \"orthologs\""
    inputBinding:
      position: 101
      prefix: --proteins_species_2
  - id: recalibration_rate
    type:
      - 'null'
      - float
    doc: "Recalibrate synonymous substitution (ks) rates of a species using a predetermined
      evolutionary rate that\n                                            can be determined
      from a species tree inferred from a collection single copy genes from taxa of
      interest\n                                            (Cui et al., 2006) - mainly
      applies only paralogous ks analysis"
    inputBinding:
      position: 101
      prefix: --recalibration_rate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_kaks_analysis:1.0.4--0
stdout: plant_tribes_kaks_analysis_KaKsAnalysis.out
