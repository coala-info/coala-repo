cwlVersion: v1.2
class: CommandLineTool
baseCommand: KaKsAnalysis
label: plant_tribes_kaks_analysis_KaKsAnalysis
doc: "Determine pairwise sequence synonymous substitutions (Ks) and significant duplication components: find homologous pairs within one species (paralogs) or between two species (orthologs) and compute Ka and Ks with codeml. Results are written to the kaksAnalysis_dir folder in the working directory.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: coding_sequences_species_1
    type: File
    doc: 'Coding sequences (CDS) fasta file for the first species (species1.fna)'
    inputBinding:
      position: 101
      prefix: --coding_sequences_species_1
      valueFrom: $(self.path)
  - id: proteins_species_1
    type: File
    doc: 'Amino acids (proteins) sequences fasta file for the first species (species1.faa)'
    inputBinding:
      position: 101
      prefix: --proteins_species_1
      valueFrom: $(self.path)
  - id: comparison
    type: string
    doc: 'pairwise sequence comparison to determine homologous pairs: paralogs (one species) or orthologs (needs second species data)'
    inputBinding:
      position: 101
      prefix: --comparison
  - id: coding_sequences_species_2
    type:
      - 'null'
      - File
    doc: 'Coding sequences (CDS) fasta file for the second species (species2.fna); needs comparison orthologs'
    inputBinding:
      position: 101
      prefix: --coding_sequences_species_2
      valueFrom: $(self.path)
  - id: proteins_species_2
    type:
      - 'null'
      - File
    doc: 'Amino acids (proteins) sequences fasta file for the second species (species2.faa); needs comparison orthologs'
    inputBinding:
      position: 101
      prefix: --proteins_species_2
      valueFrom: $(self.path)
  - id: crb_blast
    type:
      - 'null'
      - string
    doc: 'Use conditional reciprocal best BLAST to determine cross-species orthologs instead of the default reciprocal best BLAST (needs comparison orthologs)'
    inputBinding:
      position: 101
      prefix: --crb_blast
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum sequence pairwise coverage length between homologous pairs, 0.3 to 1.0 (default 0.5)'
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: recalibration_rate
    type:
      - 'null'
      - float
    doc: 'Recalibrate synonymous substitution (ks) rates of a species using a predetermined evolutionary rate (mainly for paralogous ks analysis)'
    inputBinding:
      position: 101
      prefix: --recalibration_rate
  - id: codeml_ctl_file
    type:
      - 'null'
      - File
    doc: 'PAML codeml control file; the defaults of the codeml.ctl.args template are used if not provided'
    inputBinding:
      position: 101
      prefix: --codeml_ctl_file
      valueFrom: $(self.path)
  - id: fit_components
    type:
      - 'null'
      - boolean
    doc: 'Fit a mixture model of multivariate normal components to the synonymous (ks) distribution to identify significant duplication events'
    inputBinding:
      position: 101
      prefix: --fit_components
  - id: num_of_components
    type:
      - 'null'
      - int
    doc: 'Number of components to fit to the ks distribution (required with fit_components)'
    inputBinding:
      position: 101
      prefix: --num_of_components
  - id: min_ks
    type:
      - 'null'
      - float
    doc: 'Lower limit of synonymous substitutions (ks)'
    inputBinding:
      position: 101
      prefix: --min_ks
  - id: max_ks
    type:
      - 'null'
      - float
    doc: 'Upper limit of synonymous substitutions (ks)'
    inputBinding:
      position: 101
      prefix: --max_ks
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads (CPUs), default 1'
    inputBinding:
      position: 101
      prefix: --num_threads
outputs:
  - id: kaks_dir
    type: Directory
    doc: 'Ka/Ks analysis results'
    outputBinding:
      glob: 'kaksAnalysis_dir'
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_kaks_analysis:1.0.4--0
stdout: KaKsAnalysis.log
