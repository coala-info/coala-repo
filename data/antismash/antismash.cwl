cwlVersion: v1.2
class: CommandLineTool
baseCommand: antismash
label: antismash
doc: "antiSMASH 8.0.4\n\nTool homepage: http://antismash.secondarymetabolites.org/"
inputs:
  - id: sequence
    type:
      type: array
      items: File
    doc: GenBank/EMBL/FASTA file(s) containing DNA.
    inputBinding:
      position: 1
  - id: asf
    type:
      - 'null'
      - boolean
    doc: Run active site finder analysis.
    inputBinding:
      position: 102
      prefix: --asf
  - id: cassis
    type:
      - 'null'
      - boolean
    doc: Motif based prediction of SM gene cluster regions.
    inputBinding:
      position: 102
      prefix: --cassis
  - id: cb_general
    type:
      - 'null'
      - boolean
    doc: Compare identified clusters against a database of antiSMASH-predicted 
      clusters.
    inputBinding:
      position: 102
      prefix: --cb-general
  - id: cb_knownclusters
    type:
      - 'null'
      - boolean
    doc: Compare identified clusters against known gene clusters from the MIBiG 
      database.
    inputBinding:
      position: 102
      prefix: --cb-knownclusters
  - id: cb_subclusters
    type:
      - 'null'
      - boolean
    doc: Compare identified clusters against known subclusters responsible for 
      synthesising precursors.
    inputBinding:
      position: 102
      prefix: --cb-subclusters
  - id: cc_mibig
    type:
      - 'null'
      - boolean
    doc: Run a comparison against the MIBiG dataset
    inputBinding:
      position: 102
      prefix: --cc-mibig
  - id: clusterhmmer
    type:
      - 'null'
      - boolean
    doc: Run a cluster-limited HMMer analysis using Pfam profiles.
    inputBinding:
      position: 102
      prefix: --clusterhmmer
  - id: cpus
    type:
      - 'null'
      - int
    doc: How many CPUs to use in parallel.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Root directory of the databases
    default: /usr/local/lib/python3.11/site-packages/antismash/databases
    inputBinding:
      position: 102
      prefix: --databases
  - id: fullhmmer
    type:
      - 'null'
      - boolean
    doc: Run a whole-genome HMMer analysis using Pfam profiles.
    inputBinding:
      position: 102
      prefix: --fullhmmer
  - id: genefinding_gff3
    type:
      - 'null'
      - File
    doc: Specify GFF3 file to extract features from.
    inputBinding:
      position: 102
      prefix: --genefinding-gff3
  - id: genefinding_tool
    type:
      - 'null'
      - string
    doc: "Specify algorithm used for gene finding: Prodigal, Prodigal Metagenomic/Anonymous
      mode, or none. The 'error' option will raise an error if genefinding is attempted.
      The 'none' option will not run genefinding."
    default: error
    inputBinding:
      position: 102
      prefix: --genefinding-tool
  - id: genefunctions_mite_version
    type:
      - 'null'
      - string
    doc: MITE database version number to use (e.g. 1.3)
    default: latest
    inputBinding:
      position: 102
      prefix: --genefunctions-mite-version
  - id: html_description
    type:
      - 'null'
      - string
    doc: Custom description to add to the output.
    inputBinding:
      position: 102
      prefix: --html-description
  - id: html_ncbi_context
    type:
      - 'null'
      - boolean
    doc: Show NCBI genomic context links for genes
    default: false
    inputBinding:
      position: 102
      prefix: --html-ncbi-context
  - id: html_start_compact
    type:
      - 'null'
      - boolean
    doc: Use compact view by default for overview page.
    inputBinding:
      position: 102
      prefix: --html-start-compact
  - id: html_title
    type:
      - 'null'
      - string
    doc: Custom title for the HTML output page (default is input filename).
    inputBinding:
      position: 102
      prefix: --html-title
  - id: no_html_ncbi_context
    type:
      - 'null'
      - boolean
    doc: Hide NCBI genomic context links for genes
    inputBinding:
      position: 102
      prefix: --no-html-ncbi-context
  - id: output_basename
    type:
      - 'null'
      - string
    doc: Base filename to use for output files within the output directory.
    inputBinding:
      position: 102
      prefix: --output-basename
  - id: pfam2go
    type:
      - 'null'
      - boolean
    doc: Run Pfam to Gene Ontology mapping module.
    inputBinding:
      position: 102
      prefix: --pfam2go
  - id: rre
    type:
      - 'null'
      - boolean
    doc: Run RREFinder precision mode on all RiPP gene clusters.
    inputBinding:
      position: 102
      prefix: --rre
  - id: smcog_trees
    type:
      - 'null'
      - boolean
    doc: Generate phylogenetic trees of sec. met. cluster orthologous groups.
    inputBinding:
      position: 102
      prefix: --smcog-trees
  - id: taxon
    type:
      - 'null'
      - string
    doc: Taxonomic classification of input sequence.
    default: bacteria
    inputBinding:
      position: 102
      prefix: --taxon
  - id: tfbs
    type:
      - 'null'
      - boolean
    doc: Run TFBS finder on all gene clusters.
    inputBinding:
      position: 102
      prefix: --tfbs
  - id: tigrfam
    type:
      - 'null'
      - boolean
    doc: Annotate clusters using TIGRFam profiles.
    inputBinding:
      position: 102
      prefix: --tigrfam
  - id: tta_threshold
    type:
      - 'null'
      - float
    doc: Lowest GC content to annotate TTA codons at
    default: 0.65
    inputBinding:
      position: 102
      prefix: --tta-threshold
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write results to.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antismash:8.0.4--pyhdfd78af_0
