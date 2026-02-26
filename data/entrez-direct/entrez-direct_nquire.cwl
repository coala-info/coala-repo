cwlVersion: v1.2
class: CommandLineTool
baseCommand: nquire
label: entrez-direct_nquire
doc: "Query Commands\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs:
  - id: TXT
    type:
      - 'null'
      - boolean
    doc: Return format TXT
    inputBinding:
      position: 101
      prefix: -TXT
  - id: XML
    type:
      - 'null'
      - boolean
    doc: Return format XML
    inputBinding:
      position: 101
      prefix: -XML
  - id: accession
    type:
      - 'null'
      - type: array
        items: string
    doc: Accession number for datasets
    inputBinding:
      position: 101
      prefix: -accession
  - id: always_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Fields to always list
    inputBinding:
      position: 101
      prefix: -always_list
  - id: annotation_report
    type:
      - 'null'
      - boolean
    doc: Request annotation report
    inputBinding:
      position: 101
      prefix: -annotation_report
  - id: asp
    type:
      - 'null'
      - boolean
    doc: Uses Aspera download, if configured
    inputBinding:
      position: 101
      prefix: -asp
  - id: asp_value
    type:
      - 'null'
      - string
    doc: FTP data to download using Aspera
    inputBinding:
      position: 101
      prefix: -asp
  - id: bioproject
    type:
      - 'null'
      - string
    doc: BioProject ID for datasets
    inputBinding:
      position: 101
      prefix: -bioproject
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check virus accession
    inputBinding:
      position: 101
      prefix: -check
  - id: cid
    type:
      - 'null'
      - string
    doc: Compound ID for search
    inputBinding:
      position: 101
      prefix: -cid
  - id: cids
    type:
      - 'null'
      - boolean
    doc: Return compound IDs
    inputBinding:
      position: 101
      prefix: -cids
  - id: citmatch
    type:
      - 'null'
      - boolean
    doc: Integrated Shortcuts
    inputBinding:
      position: 101
      prefix: -citmatch
  - id: citmatch_value
    type:
      - 'null'
      - string
    doc: Integrated shortcut value
    inputBinding:
      position: 101
      prefix: -citmatch
  - id: cmd
    type:
      - 'null'
      - string
    doc: Command for the query
    inputBinding:
      position: 101
      prefix: -cmd
  - id: compound
    type:
      - 'null'
      - boolean
    doc: Compound search type
    inputBinding:
      position: 101
      prefix: -compound
  - id: content_type
    type:
      - 'null'
      - string
    doc: Content type for the request
    inputBinding:
      position: 101
      prefix: -content-type
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Request counts for taxon
    inputBinding:
      position: 101
      prefix: -counts
  - id: data
    type:
      - 'null'
      - boolean
    doc: Data type for pugview
    inputBinding:
      position: 101
      prefix: -data
  - id: dataset_report
    type:
      - 'null'
      - boolean
    doc: Request dataset report
    inputBinding:
      position: 101
      prefix: -dataset_report
  - id: datasets
    type:
      - 'null'
      - boolean
    doc: https://api.ncbi.nlm.nih.gov/datasets/v2alpha
    inputBinding:
      position: 101
      prefix: -datasets
  - id: datasets_value
    type:
      - 'null'
      - string
    doc: NCBI Datasets URL shortcut
    inputBinding:
      position: 101
      prefix: -datasets
  - id: db
    type:
      - 'null'
      - string
    doc: Database to query
    inputBinding:
      position: 101
      prefix: -db
  - id: dbfrom
    type:
      - 'null'
      - string
    doc: Database to query from
    inputBinding:
      position: 101
      prefix: -dbfrom
  - id: description
    type:
      - 'null'
      - string
    doc: Description for compound search
    inputBinding:
      position: 101
      prefix: -description
  - id: description_value
    type:
      - 'null'
      - string
    doc: Description for compound search
    inputBinding:
      position: 101
      prefix: -description
  - id: dir
    type:
      - 'null'
      - boolean
    doc: FTP listing with file sizes
    inputBinding:
      position: 101
      prefix: -dir
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download datasets
    inputBinding:
      position: 101
      prefix: -download
  - id: download_summary
    type:
      - 'null'
      - boolean
    doc: Request download summary
    inputBinding:
      position: 101
      prefix: -download_summary
  - id: dwn
    type:
      - 'null'
      - boolean
    doc: Downloads FTP data to file
    inputBinding:
      position: 101
      prefix: -dwn
  - id: dwn_value
    type:
      - 'null'
      - string
    doc: FTP data to download to file
    inputBinding:
      position: 101
      prefix: -dwn
  - id: eutils
    type:
      - 'null'
      - boolean
    doc: https://eutils.ncbi.nlm.nih.gov/entrez/eutils
    inputBinding:
      position: 101
      prefix: -eutils
  - id: eutils_value
    type:
      - 'null'
      - string
    doc: EUtils URL shortcut
    inputBinding:
      position: 101
      prefix: -eutils
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: Fields to retrieve
    inputBinding:
      position: 101
      prefix: -fields
  - id: fq
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter query for Solr
    inputBinding:
      position: 101
      prefix: -fq
  - id: ftp
    type:
      - 'null'
      - boolean
    doc: Retrieves data from FTP site
    inputBinding:
      position: 101
      prefix: -ftp
  - id: ftp_host
    type:
      - 'null'
      - string
    doc: FTP host
    inputBinding:
      position: 101
      prefix: -ftp
  - id: ftp_path
    type:
      - 'null'
      - type: array
        items: string
    doc: FTP path
    inputBinding:
      position: 101
      prefix: -ftp
  - id: ftp_value
    type:
      - 'null'
      - string
    doc: FTP site to retrieve data from
    inputBinding:
      position: 101
      prefix: -ftp
  - id: gene
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets Gene shortcut
    inputBinding:
      position: 101
      prefix: -gene
  - id: gene_accession
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene accession for datasets
    inputBinding:
      position: 101
      prefix: -gene
  - id: gene_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene ID for datasets
    inputBinding:
      position: 101
      prefix: -gene_id
  - id: gene_id_datasets
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene ID for datasets
    inputBinding:
      position: 101
      prefix: -gene
  - id: gene_symbol
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene symbol for datasets
    inputBinding:
      position: 101
      prefix: -gene
  - id: gene_taxon
    type:
      - 'null'
      - string
    doc: Gene taxon for datasets
    inputBinding:
      position: 101
      prefix: -gene
  - id: gene_to_pathway
    type:
      - 'null'
      - boolean
    doc: Integrated Shortcuts
    inputBinding:
      position: 101
      prefix: -gene-to-pathway
  - id: gene_to_pathway_value
    type:
      - 'null'
      - string
    doc: Integrated shortcut value
    inputBinding:
      position: 101
      prefix: -gene-to-pathway
  - id: gene_value
    type:
      - 'null'
      - string
    doc: NCBI Datasets Gene shortcut value
    inputBinding:
      position: 101
      prefix: -gene
  - id: genome
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets Genome shortcut
    inputBinding:
      position: 101
      prefix: -genome
  - id: genome
    type:
      - 'null'
      - boolean
    doc: Request genome data
    inputBinding:
      position: 101
      prefix: -genome
  - id: genome_accession
    type:
      - 'null'
      - type: array
        items: string
    doc: Genome accession for datasets
    inputBinding:
      position: 101
      prefix: -genome
  - id: genome_bioproject
    type:
      - 'null'
      - string
    doc: BioProject ID for genome datasets
    inputBinding:
      position: 101
      prefix: -genome
  - id: genome_value
    type:
      - 'null'
      - string
    doc: NCBI Datasets Genome shortcut value
    inputBinding:
      position: 101
      prefix: -genome
  - id: get
    type:
      - 'null'
      - boolean
    doc: Uses HTTP GET instead of POST
    inputBinding:
      position: 101
      prefix: -get
  - id: get_value
    type:
      - 'null'
      - string
    doc: URL for the GET request
    inputBinding:
      position: 101
      prefix: -get
  - id: heading
    type:
      - 'null'
      - string
    doc: Heading for pugview
    inputBinding:
      position: 101
      prefix: -heading
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: ID(s) for the query
    inputBinding:
      position: 101
      prefix: -id
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs for datasets
    inputBinding:
      position: 101
      prefix: -ids
  - id: inchi
    type:
      - 'null'
      - string
    doc: InChI string for compound search
    inputBinding:
      position: 101
      prefix: -inchi
  - id: inchi_value
    type:
      - 'null'
      - string
    doc: InChI string for compound search
    inputBinding:
      position: 101
      prefix: -inchi
  - id: inchikey
    type:
      - 'null'
      - string
    doc: InChIKey for compound search
    inputBinding:
      position: 101
      prefix: -inchikey
  - id: inchikey_value
    type:
      - 'null'
      - string
    doc: InChIKey for compound search
    inputBinding:
      position: 101
      prefix: -inchikey
  - id: latitude
    type:
      - 'null'
      - float
    doc: Latitude for reverse geocoding
    inputBinding:
      position: 101
      prefix: -latitude
  - id: len
    type:
      - 'null'
      - boolean
    doc: Content length of HTTP file
    inputBinding:
      position: 101
      prefix: -len
  - id: len_value
    type:
      - 'null'
      - int
    doc: Content length of HTTP file
    inputBinding:
      position: 101
      prefix: -len
  - id: linkname
    type:
      - 'null'
      - string
    doc: Link name for the query
    inputBinding:
      position: 101
      prefix: -linkname
  - id: links
    type:
      - 'null'
      - boolean
    doc: Request links
    inputBinding:
      position: 101
      prefix: -links
  - id: list_return
    type:
      - 'null'
      - string
    doc: Return format for list results
    inputBinding:
      position: 101
      prefix: -list_return
  - id: list_return_value
    type:
      - 'null'
      - string
    doc: Return format for list results
    inputBinding:
      position: 101
      prefix: -list_return
  - id: litvar
    type:
      - 'null'
      - boolean
    doc: Integrated Shortcuts
    inputBinding:
      position: 101
      prefix: -litvar
  - id: litvar_value
    type:
      - 'null'
      - string
    doc: Integrated shortcut value
    inputBinding:
      position: 101
      prefix: -litvar
  - id: longitude
    type:
      - 'null'
      - float
    doc: Longitude for reverse geocoding
    inputBinding:
      position: 101
      prefix: -longitude
  - id: lst
    type:
      - 'null'
      - boolean
    doc: Lists contents of FTP site
    inputBinding:
      position: 101
      prefix: -lst
  - id: method
    type:
      - 'null'
      - string
    doc: Method for citation matching
    inputBinding:
      position: 101
      prefix: -method
  - id: method_value
    type:
      - 'null'
      - string
    doc: Method for citation matching
    inputBinding:
      position: 101
      prefix: -method
  - id: name
    type:
      - 'null'
      - string
    doc: Compound name for search
    inputBinding:
      position: 101
      prefix: -name
  - id: ncbi
    type:
      - 'null'
      - boolean
    doc: https://www.ncbi.nlm.nih.gov
    inputBinding:
      position: 101
      prefix: -ncbi
  - id: ncbi_value
    type:
      - 'null'
      - string
    doc: NCBI URL shortcut
    inputBinding:
      position: 101
      prefix: -ncbi
  - id: orthologs
    type:
      - 'null'
      - boolean
    doc: Request orthologs
    inputBinding:
      position: 101
      prefix: -orthologs
  - id: pathway
    type:
      - 'null'
      - boolean
    doc: Integrated Shortcuts
    inputBinding:
      position: 101
      prefix: -pathway
  - id: pathway_value
    type:
      - 'null'
      - string
    doc: Integrated shortcut value
    inputBinding:
      position: 101
      prefix: -pathway
  - id: pmids
    type:
      - 'null'
      - type: array
        items: string
    doc: PubMed IDs
    inputBinding:
      position: 101
      prefix: -pmids
  - id: post_gene
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets POST query for gene
    inputBinding:
      position: 101
      prefix: -datasets gene
  - id: post_gene_download
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets POST query for gene download
    inputBinding:
      position: 101
      prefix: -datasets gene download
  - id: post_gene_download_summary
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets POST query for gene download summary
    inputBinding:
      position: 101
      prefix: -datasets gene download_summary
  - id: post_gene_links
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets POST query for gene links
    inputBinding:
      position: 101
      prefix: -datasets gene links
  - id: post_virus_genome_download
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets POST query for virus genome download
    inputBinding:
      position: 101
      prefix: -datasets virus genome download
  - id: pubchem
    type:
      - 'null'
      - boolean
    doc: https://pubchem.ncbi.nlm.nih.gov
    inputBinding:
      position: 101
      prefix: -pubchem
  - id: pubchem_value
    type:
      - 'null'
      - string
    doc: PubChem URL shortcut
    inputBinding:
      position: 101
      prefix: -pubchem
  - id: puglist
    type:
      - 'null'
      - boolean
    doc: Fetch list from pugrest
    inputBinding:
      position: 101
      prefix: -puglist
  - id: puglist_value
    type:
      - 'null'
      - string
    doc: Fetch list from pugrest
    inputBinding:
      position: 101
      prefix: -puglist
  - id: pugrest
    type:
      - 'null'
      - boolean
    doc: https://pubchem.ncbi.nlm.nih.gov/rest/pug
    inputBinding:
      position: 101
      prefix: -pugrest
  - id: pugrest_value
    type:
      - 'null'
      - string
    doc: PugREST URL shortcut
    inputBinding:
      position: 101
      prefix: -pugrest
  - id: pugview
    type:
      - 'null'
      - boolean
    doc: https://pubchem.ncbi.nlm.nih.gov/rest/pug_view
    inputBinding:
      position: 101
      prefix: -pugview
  - id: pugview_value
    type:
      - 'null'
      - string
    doc: PugView URL shortcut
    inputBinding:
      position: 101
      prefix: -pugview
  - id: pugwait
    type:
      - 'null'
      - boolean
    doc: Wait for pugrest job to complete
    inputBinding:
      position: 101
      prefix: -pugwait
  - id: pugwait_value
    type:
      - 'null'
      - string
    doc: Wait for pugrest job to complete
    inputBinding:
      position: 101
      prefix: -pugwait
  - id: q
    type:
      - 'null'
      - string
    doc: Query for Solr
    inputBinding:
      position: 101
      prefix: -q
  - id: query
    type:
      - 'null'
      - string
    doc: Query for datasets
    inputBinding:
      position: 101
      prefix: -query
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Raw query
    inputBinding:
      position: 101
      prefix: -raw
  - id: raw_text
    type:
      - 'null'
      - string
    doc: Raw text for citation matching
    inputBinding:
      position: 101
      prefix: -raw-text
  - id: raw_text_value
    type:
      - 'null'
      - string
    doc: Raw text for citation matching
    inputBinding:
      position: 101
      prefix: -raw-text
  - id: raw_value
    type:
      - 'null'
      - string
    doc: Raw query value
    inputBinding:
      position: 101
      prefix: -raw
  - id: smarts
    type:
      - 'null'
      - string
    doc: SMARTS string for substructure search
    inputBinding:
      position: 101
      prefix: -smarts
  - id: smarts_value
    type:
      - 'null'
      - string
    doc: SMARTS string for substructure search
    inputBinding:
      position: 101
      prefix: -smarts
  - id: smiles
    type:
      - 'null'
      - string
    doc: SMILES string for compound search
    inputBinding:
      position: 101
      prefix: -smiles
  - id: smiles_value
    type:
      - 'null'
      - string
    doc: SMILES string for compound search
    inputBinding:
      position: 101
      prefix: -smiles
  - id: superstructure
    type:
      - 'null'
      - string
    doc: Superstructure search
    inputBinding:
      position: 101
      prefix: -superstructure
  - id: superstructure_value
    type:
      - 'null'
      - string
    doc: Superstructure search
    inputBinding:
      position: 101
      prefix: -superstructure
  - id: symbol
    type:
      - 'null'
      - type: array
        items: string
    doc: Gene symbol for datasets
    inputBinding:
      position: 101
      prefix: -symbol
  - id: taxon
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxon ID for datasets
    inputBinding:
      position: 101
      prefix: -taxon
  - id: taxon_human
    type:
      - 'null'
      - boolean
    doc: Specify human taxon
    inputBinding:
      position: 101
      prefix: -taxon_human
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets Taxonomy shortcut
    inputBinding:
      position: 101
      prefix: -taxonomy
  - id: taxonomy_taxon
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxon ID for taxonomy datasets
    inputBinding:
      position: 101
      prefix: -taxonomy
  - id: taxonomy_value
    type:
      - 'null'
      - string
    doc: NCBI Datasets Taxonomy shortcut value
    inputBinding:
      position: 101
      prefix: -taxonomy
  - id: term
    type:
      - 'null'
      - string
    doc: Search term
    inputBinding:
      position: 101
      prefix: -term
  - id: url
    type:
      - 'null'
      - boolean
    doc: Sends query with HTTP POST
    inputBinding:
      position: 101
      prefix: -url
  - id: url_value
    type:
      - 'null'
      - string
    doc: URL for the query
    inputBinding:
      position: 101
      prefix: -url
  - id: virus
    type:
      - 'null'
      - boolean
    doc: NCBI Datasets Virus shortcut
    inputBinding:
      position: 101
      prefix: -virus
  - id: virus_accession
    type:
      - 'null'
      - type: array
        items: string
    doc: Virus accession for datasets
    inputBinding:
      position: 101
      prefix: -virus
  - id: virus_value
    type:
      - 'null'
      - string
    doc: NCBI Datasets Virus shortcut value
    inputBinding:
      position: 101
      prefix: -virus
  - id: voucher
    type:
      - 'null'
      - string
    doc: Voucher for the query
    inputBinding:
      position: 101
      prefix: -voucher
  - id: wt
    type:
      - 'null'
      - string
    doc: Writer type for Solr
    inputBinding:
      position: 101
      prefix: -wt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_nquire.out
