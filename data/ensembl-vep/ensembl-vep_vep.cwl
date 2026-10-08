cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vep
label: ensembl-vep_vep
doc: "ENSEMBL VARIANT EFFECT PREDICTOR\n\nDetermines the effect of variants (SNPs, insertions, deletions, CNVs or structural variants) on genes, transcripts, protein sequence and regulatory regions.\n\nTool homepage: https://www.ensembl.org/info/docs/tools/vep/index.html"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwriting of output file"
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: species
    type:
      - 'null'
      - string
    doc: "Species to use [default: \"human\"]"
    inputBinding:
      position: 101
      prefix: --species
  - id: everything
    type:
      - 'null'
      - boolean
    doc: "Shortcut switch to turn on commonly used options. See web documentation for details [default: off]"
    inputBinding:
      position: 101
      prefix: --everything
  - id: fork
    type:
      - 'null'
      - int
    doc: "Use forking to improve script runtime"
    inputBinding:
      position: 101
      prefix: --fork
  - id: cache
    type:
      - 'null'
      - boolean
    doc: "Use the cache of transcript models and variants"
    inputBinding:
      position: 101
      prefix: --cache
  - id: offline
    type:
      - 'null'
      - boolean
    doc: "Run in offline mode: no database connection, uses the cache or custom annotation"
    inputBinding:
      position: 101
      prefix: --offline
  - id: database
    type:
      - 'null'
      - boolean
    doc: "Use the Ensembl database instead of a cache"
    inputBinding:
      position: 101
      prefix: --database
  - id: dir_cache
    type:
      - 'null'
      - Directory
    doc: "Cache directory (contains the <species>/<version>_<assembly> folders)"
    inputBinding:
      position: 101
      prefix: --dir_cache
  - id: cache_version
    type:
      - 'null'
      - int
    doc: "Version of the cache to use"
    inputBinding:
      position: 101
      prefix: --cache_version
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Assembly version to use (for example GRCh38)"
    inputBinding:
      position: 101
      prefix: --assembly
  - id: format
    type:
      - 'null'
      - string
    doc: "Input file format: ensembl, vcf, hgvs, id, region, spdi"
    inputBinding:
      position: 101
      prefix: --format
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: "Write output in VCF format"
    inputBinding:
      position: 101
      prefix: --vcf
  - id: tab
    type:
      - 'null'
      - boolean
    doc: "Write output in tab-delimited format"
    inputBinding:
      position: 101
      prefix: --tab
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Write output in JSON format"
    inputBinding:
      position: 101
      prefix: --json
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference FASTA file, used for HGVS and reference checks and for custom annotation without a database"
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff
    type:
      - 'null'
      - File
    doc: "Use GFF transcript annotations as a source of transcript models (bgzipped and tabix indexed); needs --fasta"
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --gff
  - id: gtf
    type:
      - 'null'
      - File
    doc: "Use GTF transcript annotations as a source of transcript models (bgzipped and tabix indexed); needs --fasta"
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --gtf
  - id: no_stats
    type:
      - 'null'
      - boolean
    doc: "Do not generate a stats file"
    inputBinding:
      position: 101
      prefix: --no_stats
  - id: stats_file
    type:
      - 'null'
      - string
    doc: "Summary stats file name"
    inputBinding:
      position: 101
      prefix: --stats_file
  - id: stats_text
    type:
      - 'null'
      - boolean
    doc: "Write stats file in a text format"
    inputBinding:
      position: 101
      prefix: --stats_text
  - id: warning_file
    type:
      - 'null'
      - string
    doc: "File name to write warnings and errors to"
    inputBinding:
      position: 101
      prefix: --warning_file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress status and warning messages"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out a bit more information while running"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: "Sets the number of variants read into memory at once [default: 5000]"
    inputBinding:
      position: 101
      prefix: --buffer_size
  - id: distance
    type:
      - 'null'
      - int
    doc: "Modify the distance up and down stream to report transcripts [default: 5000]"
    inputBinding:
      position: 101
      prefix: --distance
  - id: symbol
    type:
      - 'null'
      - boolean
    doc: "Adds the gene symbol where available"
    inputBinding:
      position: 101
      prefix: --symbol
  - id: hgvs
    type:
      - 'null'
      - boolean
    doc: "Add HGVS nomenclature based on Ensembl stable identifiers; needs --fasta"
    inputBinding:
      position: 101
      prefix: --hgvs
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: "Adds a flag indicating if the transcript is the canonical transcript for the gene"
    inputBinding:
      position: 101
      prefix: --canonical
  - id: mane
    type:
      - 'null'
      - boolean
    doc: "Adds a flag indicating if the transcript is the MANE Select or MANE Plus Clinical transcript"
    inputBinding:
      position: 101
      prefix: --mane
  - id: biotype
    type:
      - 'null'
      - boolean
    doc: "Adds the biotype of the transcript or regulatory feature"
    inputBinding:
      position: 101
      prefix: --biotype
  - id: numbers
    type:
      - 'null'
      - boolean
    doc: "Adds affected exon and intron numbering"
    inputBinding:
      position: 101
      prefix: --numbers
  - id: protein
    type:
      - 'null'
      - boolean
    doc: "Add the Ensembl protein identifier to the output"
    inputBinding:
      position: 101
      prefix: --protein
  - id: variant_class
    type:
      - 'null'
      - boolean
    doc: "Output the Sequence Ontology variant class"
    inputBinding:
      position: 101
      prefix: --variant_class
  - id: sift
    type:
      - 'null'
      - string
    doc: "SIFT prediction: p (prediction), s (score) or b (both)"
    inputBinding:
      position: 101
      prefix: --sift
  - id: polyphen
    type:
      - 'null'
      - string
    doc: "PolyPhen prediction: p (prediction), s (score) or b (both)"
    inputBinding:
      position: 101
      prefix: --polyphen
  - id: regulatory
    type:
      - 'null'
      - boolean
    doc: "Look for overlaps with regulatory regions"
    inputBinding:
      position: 101
      prefix: --regulatory
  - id: check_existing
    type:
      - 'null'
      - boolean
    doc: "Checks for the existence of known variants that are co-located with your input"
    inputBinding:
      position: 101
      prefix: --check_existing
  - id: af
    type:
      - 'null'
      - boolean
    doc: "Add the global allele frequency from 1000 Genomes Phase 3 data"
    inputBinding:
      position: 101
      prefix: --af
  - id: max_af
    type:
      - 'null'
      - boolean
    doc: "Report the highest allele frequency observed in any population"
    inputBinding:
      position: 101
      prefix: --max_af
  - id: pick
    type:
      - 'null'
      - boolean
    doc: "Pick one line or block of consequence data per variant, including transcript-specific columns"
    inputBinding:
      position: 101
      prefix: --pick
  - id: pick_allele
    type:
      - 'null'
      - boolean
    doc: "Like --pick, but chooses one line per variant allele"
    inputBinding:
      position: 101
      prefix: --pick_allele
  - id: per_gene
    type:
      - 'null'
      - boolean
    doc: "Output only the most severe consequence per gene"
    inputBinding:
      position: 101
      prefix: --per_gene
  - id: most_severe
    type:
      - 'null'
      - boolean
    doc: "Output only the most severe consequence per variant"
    inputBinding:
      position: 101
      prefix: --most_severe
  - id: flag_pick
    type:
      - 'null'
      - boolean
    doc: "As --pick, but adds the PICK flag to the chosen block instead of filtering out the others"
    inputBinding:
      position: 101
      prefix: --flag_pick
  - id: coding_only
    type:
      - 'null'
      - boolean
    doc: "Only return consequences that fall in the coding regions of transcripts"
    inputBinding:
      position: 101
      prefix: --coding_only
  - id: no_intergenic
    type:
      - 'null'
      - boolean
    doc: "Excludes intergenic consequences from the output"
    inputBinding:
      position: 101
      prefix: --no_intergenic
  - id: terms
    type:
      - 'null'
      - string
    doc: "Type of consequence terms to output: SO, display or NCBI"
    inputBinding:
      position: 101
      prefix: --terms
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: "Use the RefSeq transcript set in the cache"
    inputBinding:
      position: 101
      prefix: --refseq
  - id: merged
    type:
      - 'null'
      - boolean
    doc: "Use the merged Ensembl and RefSeq cache"
    inputBinding:
      position: 101
      prefix: --merged
  - id: gencode_basic
    type:
      - 'null'
      - boolean
    doc: "Limit your analysis to transcripts belonging to the GENCODE basic set"
    inputBinding:
      position: 101
      prefix: --gencode_basic
  - id: individual
    type:
      - 'null'
      - string
    doc: "Consider only alternate alleles present in the genotypes of the specified individuals (comma-separated, or \"all\")"
    inputBinding:
      position: 101
      prefix: --individual
  - id: allow_non_variant
    type:
      - 'null'
      - boolean
    doc: "Prevents VEP from skipping rows that have no variant alleles in a VCF input file"
    inputBinding:
      position: 101
      prefix: --allow_non_variant
  - id: skip_db_check
    type:
      - 'null'
      - boolean
    doc: "Skip the check that the cache and the database versions match"
    inputBinding:
      position: 101
      prefix: --skip_db_check
  - id: no_check_variants_order
    type:
      - 'null'
      - boolean
    doc: "Do not check that the input variants are sorted"
    inputBinding:
      position: 101
      prefix: --no_check_variants_order
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: "Convert alleles to their most minimal representation before consequence calculation"
    inputBinding:
      position: 101
      prefix: --minimal
  - id: fields
    type:
      - 'null'
      - string
    doc: "Configure the output format using a comma-separated list of fields"
    inputBinding:
      position: 101
      prefix: --fields
  - id: compress_output
    type:
      - 'null'
      - string
    doc: "Write output compressed with gzip or bgzip"
    inputBinding:
      position: 101
      prefix: --compress_output
  - id: plugin
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --plugin
    doc: "Use a VEP plugin, with parameters separated by commas (repeat for several plugins)"
    inputBinding:
      position: 101
  - id: custom
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --custom
    doc: "Add custom annotation from a file (repeat for several; value is file,short_name,file_type,annotation_type,force_report_coordinates,fields)"
    inputBinding:
      position: 101
  - id: host
    type:
      - 'null'
      - string
    doc: "Manually define the database host"
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: "Manually define the database port"
    inputBinding:
      position: 101
      prefix: --port
  - id: user
    type:
      - 'null'
      - string
    doc: "Database username"
    inputBinding:
      position: 101
      prefix: --user
  - id: password
    type:
      - 'null'
      - string
    doc: "Database password"
    inputBinding:
      position: 101
      prefix: --password
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stats_html
    type:
      - 'null'
      - File
    doc: Summary statistics file (<output>_summary.html), written unless --no_stats is set
    outputBinding:
      glob: '*_summary.*'
  - id: warnings
    type:
      - 'null'
      - File
    doc: Warnings file (<output>_warnings.txt)
    outputBinding:
      glob: '*_warnings.txt'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
