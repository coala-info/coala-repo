cwlVersion: v1.2
class: CommandLineTool
baseCommand: efilter
label: entrez-direct_efilter
doc: "Filters search results based on various criteria.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: class
    type:
      - 'null'
      - string
    doc: Class filter (acceptor, donor, coding, frameshift, indel, intron, 
      missense, nonsense, synonymous)
    inputBinding:
      position: 101
      prefix: -class
  - id: country
    type:
      - 'null'
      - string
    doc: Country filter (e.g., usa:minnesota, united_kingdom, "pacific ocean")
    inputBinding:
      position: 101
      prefix: -country
  - id: datetype
    type:
      - 'null'
      - string
    doc: Date field abbreviation
    inputBinding:
      position: 101
      prefix: -datetype
  - id: days
    type:
      - 'null'
      - int
    doc: Number of days in the past
    inputBinding:
      position: 101
      prefix: -days
  - id: division
    type:
      - 'null'
      - string
    doc: Division filter (bct, con, env, est, gss, htc, htg, inv, mam, pat, phg,
      pln, pri, rod, sts, syn, una, vrl, vrt)
    inputBinding:
      position: 101
      prefix: -division
  - id: feature
    type:
      - 'null'
      - string
    doc: Feature filter (gene, mrna, cds, mat_peptide)
    inputBinding:
      position: 101
      prefix: -feature
  - id: journal
    type:
      - 'null'
      - string
    doc: Journal filter (e.g., pnas, "j bacteriol")
    inputBinding:
      position: 101
      prefix: -journal
  - id: keyword
    type:
      - 'null'
      - string
    doc: Keyword filter
    inputBinding:
      position: 101
      prefix: -keyword
  - id: location
    type:
      - 'null'
      - string
    doc: Location filter (mitochondrion, chloroplast, plasmid, plastid)
    inputBinding:
      position: 101
      prefix: -location
  - id: maxdate
    type:
      - 'null'
      - string
    doc: End of date range
    inputBinding:
      position: 101
      prefix: -maxdate
  - id: mindate
    type:
      - 'null'
      - string
    doc: Start of date range
    inputBinding:
      position: 101
      prefix: -mindate
  - id: molecule
    type:
      - 'null'
      - string
    doc: Molecule filter (genomic, mrna, trna, rrna, ncrna)
    inputBinding:
      position: 101
      prefix: -molecule
  - id: organism
    type:
      - 'null'
      - string
    doc: Organism filter (animals, archaea, bacteria, eukaryotes, fungi, human, 
      insects, mammals, plants, prokaryotes, protists, rodents, viruses)
    inputBinding:
      position: 101
      prefix: -organism
  - id: pub
    type:
      - 'null'
      - string
    doc: Publication filter (abstract, clinical, english, free, historical, 
      journal, medline, preprint, published, retracted, retraction, review, 
      structured)
    inputBinding:
      position: 101
      prefix: -pub
  - id: purpose
    type:
      - 'null'
      - string
    doc: Purpose filter (baseline, targeted)
    inputBinding:
      position: 101
      prefix: -purpose
  - id: query
    type:
      - 'null'
      - string
    doc: Query string
    inputBinding:
      position: 101
      prefix: -query
  - id: released
    type:
      - 'null'
      - string
    doc: Release date filter (last_week, last_month, last_year, prev_years)
    inputBinding:
      position: 101
      prefix: -released
  - id: source
    type:
      - 'null'
      - string
    doc: Source filter (genbank, insd, pdb, pir, refseq, select, swissprot, tpa)
    inputBinding:
      position: 101
      prefix: -source
  - id: status
    type:
      - 'null'
      - string
    doc: Status filter (alive for Gene Filters, latest, replaced for Assembly 
      Filters)
    inputBinding:
      position: 101
      prefix: -status
  - id: type
    type:
      - 'null'
      - string
    doc: Type filter (coding, pseudo)
    inputBinding:
      position: 101
      prefix: -type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_efilter.out
