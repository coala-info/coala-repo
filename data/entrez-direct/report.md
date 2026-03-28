# entrez-direct CWL Generation Report

## entrez-direct_esearch

### Tool Description
Query Specification

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Total Downloads**: 1.5M
- **Last updated**: 2025-05-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
esearch 24.0

Query Specification

  -db            Database name
  -query         Query string

Spell Check

  -spell         Correct misspellings in query

Query Translation

  -translate     Show automatic term mapping
  -component     Individual term mapping items

Document Order

  -sort          Result presentation order

Sort Choices by Database

  gene           Chromosome, Gene Weight, Name, Relevance

  geoprofiles    Default Order, Deviation, Mean Value, Outliers, Subgroup Effect

  pubmed         First Author, Journal, Last Author, Pub Date, Recently Added,
                 Relevance, Title

  (sequences)    Accession, Date Modified, Date Released, Default Order,
                 Organism Name, Taxonomy ID

  snp            Chromosome Base Position, Default Order, Heterozygosity,
                 Organism, SNP_ID, Success Rate

Note

  All efilter shortcuts can also be used with esearch

Examples

  esearch -db pubmed -query "opsin gene conversion OR tetrachromacy"

  esearch -db pubmed -query "Garber ED [AUTH] AND PNAS [JOUR]"

  esearch -db nuccore -query "MatK [GENE] AND NC_0:NC_999999999 [PACC]"

  esearch -db protein -query "amyloid* [PROT]" |
  elink -target pubmed -label prot_cit |
  esearch -db gene -query "apo* [GENE]" |
  elink -target pubmed -label gene_cit |
  esearch -query "(#prot_cit) AND (#gene_cit)" |
  efetch -format docsum |
  xtract -pattern DocumentSummary -element Id Title
```


## entrez-direct_efilter

### Tool Description
Filters search results based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

### Original Help Text
```text
efilter 24.0

Query Specification

  -query       Query string

Date Constraint

  -days        Number of days in the past
  -datetype    Date field abbreviation
  -mindate     Start of date range
  -maxdate     End of date range

Overview

  All efilter shortcuts can also be used with esearch

  Each shortcut is only legal for a specific database category

Publication Filters

  -pub         abstract, clinical, english, free, historical,
               journal, medline, preprint, published, retracted,
               retraction, review, structured
  -journal     pnas, "j bacteriol", ...
  -released    last_week, last_month, last_year, prev_years

Sequence Filters

  -country     usa:minnesota, united_kingdom, "pacific ocean", ...
  -feature     gene, mrna, cds, mat_peptide, ...
  -location    mitochondrion, chloroplast, plasmid, plastid
  -molecule    genomic, mrna, trna, rrna, ncrna
  -organism    animals, archaea, bacteria, eukaryotes, fungi,
               human, insects, mammals, plants, prokaryotes,
               protists, rodents, viruses
  -source      genbank, insd, pdb, pir, refseq, select, swissprot,
               tpa
  -division    bct, con, env, est, gss, htc, htg, inv, mam, pat,
               phg, pln, pri, rod, sts, syn, una, vrl, vrt
  -keyword     purpose
  -purpose     baseline, targeted

Gene Filters

  -status      alive
  -type        coding, pseudo

SNP Filters

  -class       acceptor, donor, coding, frameshift, indel,
               intron, missense, nonsense, synonymous

Assembly Filters

  -status      latest, replaced

Examples

  esearch -db pubmed -query "opsin gene conversion" |
  elink -related |
  efilter -query "tetrachromacy"

  esearch -db pubmed -query "opsin gene conversion" |
  efilter -mindate 2015
```


## entrez-direct_elink

### Tool Description
Finds links between records in different databases or within the same database.

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

### Original Help Text
```text
elink 24.0

Destination Database

  -related    Neighbors in same database
  -target     Links in different database

Direct Record Selection

  -db         Database name
  -id         Unique identifier(s)
  -input      Read identifier(s) from file instead of stdin

PubMed Citation Lookup*

  -cited      References to this paper
  -cites      Publication reference list

Command Mode

  -cmd        Command type

-cmd Options

  edirect     Instantiate results in ENTREZ_DIRECT message
  uid         Return results as sorted and uniqued UID list
  history     Save results in Entrez history server
  neighbor    Neighbors or links
  score       Neighbors with computed similarity scores
  acheck      All links available
  ncheck      Existence of neighbors
  lcheck      Existence of external links (LinkOuts)
  llinks      Non-library LinkOut providers
  llibs       All LinkOut providers
  prlinks     Primary LinkOut provider

Restrict Neighbor Links

  -name       Link name (e.g., pubmed_protein_refseq, pubmed_pubmed_citedin)

Note

  * -cited and -cites use the NIH Open Citation Collection
    dataset (see PMID 31600197) to follow reference lists

Examples

  esearch -db pubmed -query "lycopene cyclase" |
  elink -related |
  elink -target protein |
  efilter -organism rodents -source refseq |
  efetch -format docsum |
  xtract -pattern DocumentSummary -element AccessionVersion Title |
  grep -i carotene

  esearch -db pubmed -query "Beadle GW [AUTH] AND Tatum EL [AUTH]" |
  elink -cited |
  efilter -days 365 |
  efetch -format abstract

  esearch -db pubmed -query "conotoxin AND dopamine [MAJR]" |
  elink -target protein -cmd neighbor |
  xtract -pattern LinkSet -if Link/Id -element IdList/Id Link/Id

  elink -db pubmed -id 20210808 -cmd score |
  xtract -pattern LinkSet -max Link/Score

  elink -db assembly -id GCF_000001405.25,GCF_000001215.3 -cmd acheck |
  xtract -pattern LinkSet -sep "\n" -element Id,LinkName

  elink -db pubmed -id 19880848 -cmd prlinks |
  xtract -pattern LinkSet -first Id -element ObjUrl/Url

  esearch -timer -db biosample -query "package mims metagenome/environmental, water version 5 0 [PROP]" |
  efilter -query "ncbi [FILT] AND biosample sra [FILT]" |
  elink -target bioproject -log |
  efetch -format native
```


## entrez-direct_efetch

### Tool Description
Fetch records from NCBI databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

### Original Help Text
```text
efetch 24.0

Format Selection

  -format        Format of record or report
  -mode          text, xml, asn, binary, json
  -style         master, conwithfeat

Direct Record Selection

  -db            Database name
  -id            Unique identifier or accession number
  -input         Read identifier(s) from file instead of stdin

Sequence Range

  -seq_start     First sequence position to retrieve
  -seq_stop      Last sequence position to retrieve
  -strand        1 = forward DNA strand, 2 = reverse complement
                   (otherwise strand minus is set if start > stop)
  -forward       Force strand 1
  -revcomp       Force strand 2

Gene Range

  -chr_start     Sequence range from 0-based coordinates
  -chr_stop        in gene docsum GenomicInfoType object

Sequence Flags

  -complexity    0 = default, 1 = bioseq, 3 = nuc-prot set
  -extend        Extend sequence retrieval in both directions
  -extrafeat     Bit flag specifying extra features
  -showgaps      Propagate component gaps

Subset Retrieval

  -start         First record to fetch
  -stop          Last record to fetch

Miscellaneous

  -raw           Skip database-specific XML modifications
  -express       Direct sequence retrieval in groups of 5 
  -immediate     Express mode on a single record at a time 

Format Examples

  -db            -format            -mode    Report Type
  ___            _______            _____    ___________

  (all)
                 docsum                      DocumentSummarySet XML
                 docsum             json     DocumentSummarySet JSON
                 full                        Same as native except for mesh
                 uid                         Unique Identifier List
                 edirect                     Id fields in ENTREZ_DIRECT message
                 url                         Entrez URL for multiple UIDs
                 urls                        Individual URLs
                 xml                         Same as -format full -mode xml

  bioproject
                 native                      BioProject Report
                 native             xml      RecordSet XML

  biosample
                 native                      BioSample Report
                 native             xml      BioSampleSet XML

  clinvar
                 variation                   Older Format
                 variationid                 Transition Format
                 vcv                         VCV Report
                 clinvarset                  RCV Report

  gds
                 native             xml      RecordSet XML
                 summary                     Summary

  gene
                 full_report                 Detailed Report
                 gene_table                  Gene Table
                 native                      Gene Report
                 native             asn      Entrezgene ASN.1
                 native             xml      Entrezgene-Set XML
                 tabular                     Tabular Report

  homologene
                 alignmentscores             Alignment Scores
                 fasta                       FASTA
                 homologene                  Homologene Report
                 native                      Homologene List
                 native             asn      HG-Entry ASN.1
                 native             xml      Entrez-Homologene-Set XML

  mesh
                 full                        Full Record
                 native                      MeSH Report
                 native             xml      RecordSet XML

  nlmcatalog
                 native                      Full Record
                 native             xml      NLMCatalogRecordSet XML

  pmc
                 bioc                        PubTator Central BioC XML
                 medline                     MEDLINE
                 native             xml      pmc-articleset XML

  pubmed
                 abstract                    Abstract
                 apa                         PMID plus APA citation
                 bioc                        PubTator Central BioC XML
                 medline                     MEDLINE
                 native             asn      Pubmed-entry ASN.1
                 native             xml      PubmedArticleSet XML

  (sequences)
                 acc                         Accession Number
                 est                         EST Report
                 fasta                       FASTA
                 fasta              xml      TinySeq XML
                 fasta_cds_aa                FASTA of CDS Products
                 fasta_cds_na                FASTA of Coding Regions
                 ft                          Feature Table
                 gb                          GenBank Flatfile
                 gb                 xml      GBSet XML
                 gbc                xml      INSDSet XML
                 gene_fasta                  FASTA of Gene
                 gp                          GenPept Flatfile
                 gp                 xml      GBSet XML
                 gpc                xml      INSDSet XML
                 gss                         GSS Report
                 ipg                         Identical Protein Report
                 ipg                xml      IPGReportSet XML
                 asn                         Seq-entry ASN.1
                 asn                binary   Binary Seq-entry ASN.1
                 native             text     Seq-entry ASN.1
                 native             xml      Bioseq-set XML
                 seqid                       Seq-id ASN.1

  snp
                 json                        Reference SNP Report

  sra
                 native             xml      EXPERIMENT_PACKAGE_SET XML
                 runinfo            xml      SraRunInfo XML

  structure
                 mmdb                        Ncbi-mime-asn1 strucseq ASN.1
                 native                      MMDB Report
                 native             xml      RecordSet XML

  taxonomy
                 native                      Taxonomy List
                 native             xml      TaxaSet XML

Examples

  efetch -db pubmed -id 6271474,5685784,4882854,6243420 -format xml |
  xtract -pattern PubmedArticle -element MedlineCitation/PMID "#Author" \
    -block Author -position first -sep " " -element Initials,LastName \
    -block Article -element ArticleTitle

  efetch -db nuccore -id CM000177.6 -format gb -style conwithfeat -showgaps

  efetch -db nuccore -id 1121073309 -format gbc -style master

  efetch -db nuccore -id JABRPF010000000 -format gb

  efetch -db nuccore -id JABRPF010000001 -format gb

  efetch -db protein -id 3OQZ_a -format fasta

  esearch -db protein -query "conotoxin AND mat_peptide [FKEY]" |
  efetch -format fasta -start 1 -stop 5

  esearch -db protein -query "conotoxin AND mat_peptide [FKEY]" |
  efetch -format gpc |
  xtract -insd complete mat_peptide "%peptide" product mol_wt peptide |
  grep -i conotoxin | sort -t $'\t' -u -k 2,2n | head -n 8

  esearch -db gene -query "DDT [GENE] AND mouse [ORGN]" |
  efetch -format docsum |
  xtract -pattern GenomicInfoType -element ChrAccVer ChrStart ChrStop |
  xargs -n 3 sh -c 'efetch -db nuccore -format gb \
    -id "$0" -chr_start "$1" -chr_stop "$2"'

  efetch -db sra -format docsum -id SRA030738,SRA030736 |
  xtract -pattern DocumentSummary -element Run@acc
```


## entrez-direct_xtract

### Tool Description
Xtract uses command-line arguments to convert XML data into a tab-delimited table.

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

### Original Help Text
```text
xtract 24.0

Overview

  Xtract uses command-line arguments to convert XML data into a tab-delimited table.

  -pattern places the data from individual records into separate rows.

  -element extracts values from specified fields into separate columns.

  -group, -block, and -subset limit element exploration to selected XML subregions.

Processing Flags

  -strict          Remove HTML and MathML tags
  -mixed           Allow mixed content XML

  -self            Allow detection of empty self-closing tags

  -accent          Excise Unicode accents and diacritical marks
  -ascii           Unicode to numeric HTML character entities
  -compress        Compress runs of spaces

  -stops           Retain stop words in selected phrases

Data Source

  -input           Read XML from file instead of stdin
  -transform       File of substitutions for -translate
  -aliases         Mappings file for -classify operation

Exploration Argument Hierarchy

  -pattern         Name of record within set
  -group             Use of different argument
  -block               names allows command-line
  -subset                control of nested looping

Path Navigation

  -path            Explore by list of adjacent object names

Exploration Constructs

  Object           DateRevised
  Parent/Child     Book/AuthorList
  Path             MedlineCitation/Article/Journal/JournalIssue/PubDate
  Heterogeneous    "PubmedArticleSet/*"
  Exhaustive       "History/**"
  Nested           "*/Taxon"
  Recursive        "**/Gene-commentary"
  Current          "*"

Conditional Execution

  -if              Element [@attribute] required
  -unless          Skip if element matches
  -and             All tests must pass
  -or              Any passing test suffices
  -else            Execute if conditional test failed
  -position        [first|last|outer|inner|even|odd|all]

String Constraints

  -equals          String must match exactly
  -contains        Substring must be present
  -mimics          Containment test after converting punctuation to space
  -excludes        Substring must be absent
  -includes        Substring must match at word boundaries
  -is-within       String must be present
  -starts-with     Substring must be at beginning
  -ends-with       Substring must be at end
  -is-not          String must not match
  -is-before       First string < second string
  -is-after        First string > second string
  -consists-of     String must only contain specified characters
  -matches         Matches without commas, semicolons, or accents
  -resembles       Requires all words, but in any order

Object Constraints

  -is-equal-to     Object values must match
  -differs-from    Object values must differ

Numeric Constraints

  -gt              Greater than
  -ge              Greater than or equal to
  -lt              Less than
  -le              Less than or equal to
  -eq              Equal to
  -ne              Not equal to

Format Customization

  -ret             Override line break between patterns
  -tab             Replace tab character between fields
  -sep             Separator between group members
  -pfx             Prefix to print before group
  -sfx             Suffix to print after group
  -rst             Reset -sep through -elg
  -clr             Clear queued tab separator
  -pfc             Preface combines -clr and -pfx
  -deq             Delete and replace queued tab separator
  -def             Default placeholder for missing fields
  -lbl             Insert arbitrary text

XML Generation

  -set             XML tag for entire set
  -rec             XML tag for each record

  -wrp             Wrap elements in XML object

  -enc             Encase instance in XML object
  -plg             Prologue to print before instance
  -elg             Epilogue to print after instance

  -pkg             Package subset in XML object
  -fwd             Foreword to print before subset
  -awd             Afterword to print after subset

Tag and Attribute Construction

  -tag             Start with "<" + object name
  -att             Attribute key and literal string
  -atr             Attribute key and element name
  -cls             Close with ">"
  -slf             Self-close with " />"
  -end             End contents with "</" + object name + ">"

FASTA Parsable Fields

  -bkt             Wrap elements in bracketed fields

Element Selection

  -element         Print all items that match tag name
  -first           Only print value of first item
  -last            Only print value of last item
  -even            Only print value of even items
  -odd             Only print value of odd items
  -backward        Print values in reverse order

Variable Recording

  -NAME            Record value in named variable
  --STATS          Accumulate values into variable

-element Constructs

  Tag              Caption
  Group            Initials,LastName
  Parent/Child     MedlineCitation/PMID
  Unrestricted     "PubDate/*"
  Attribute        DescriptorName@MajorTopicYN
  Range            MedlineDate[1:4]
  Substring        "Title[phospholipase | rattlesnake]"
  Alternative      "Construct[can contain ^ vertical bar]"
  Object Count     "#Author"
  Item Length      "%Title"
  Element Depth    "^PMID"
  Variable         "&NAME"

Special -element Operations

  Parent Index     "+"
  Object Name      "?"
  Object Value     "~"
  XML Subtree      "*"
  Children         "$"
  Attributes       "@"
  ASN.1 Record     "."
  JSON Record      "%"

Numeric (Integer) Processing

  -num             Count
  -len             Length
  -sum             Sum
  -acc             Accumulator
  -min             Minimum
  -max             Maximum
  -inc             Increment
  -dec             Decrement
  -sub             Difference
  -avg             Arithmetic Mean
  -dev             Deviation
  -med             Median
  -mul             Product
  -div             Quotient
  -mod             Remainder
  -geo             Geometric Mean
  -hrm             Harmonic Mean
  -rms             Root Mean Square
  -sqt             Square Root
  -lge             Natural Logarithm
  -lg2             Logarithm Base 2
  -log             Logarithm Base 10
  -bin             Binary
  -oct             Octal
  -hex             Hexadecimal
  -bit             Number of Bits Set

Leading Zero Padding

  -pad             0-Pad to 8 digits

Character Processing

  -encode          XML-encode <, >, &, ", and ' characters
  -decode          Base64-decode object embedded in XML
  -upper           Convert text to upper-case
  -lower           Convert text to lower-case
  -chain           Change_spaces_to_underscores
  -title           Capitalize initial letters of words
  -mirror          Reverse order of letters
  -alpha           Non-alphabetic characters to space
  -alnum           Non-alphanumeric characters to space

String Processing

  -basic           Convert superscripts and subscripts
  -plain           Remove embedded mixed-content markup tags
  -simple          Normalize accented letters, spell Greek letters
  -author          Multi-step author cleanup
  -journal         Journal capitalization and punctuation cleanup
  -prose           Text conversion to ASCII

Text Processing

  -terms           Partition text at spaces
  -words           Split at punctuation marks
  -pairs           Adjacent informative words
  -split           Split using -with for delimiter
  -order           Rearrange words in sorted order
  -reverse         Reverse words in string
  -letters         Separate individual letters
  -clauses         Break at phrase separators
  -pentamers       Sliding window of pentamers

Citation Functions

  -year            Extract first 4-digit year from string
  -month           Match first month name, return as integer
  -date            YYYY/MM/DD from -unit "PubDate" -date "*"
  -page            Get digits (and letters) of first page number
  -auth            Changed GenBank authors to Medline form
  -initials        Parse initials from forename or given name

Miscellaneous Functions

  -trim            Remove extra spaces and leading zeros
  -wct             Count number of -words in a string
  -doi             Add https://doi.org/ prefix, URL encode
  -accession       Allow indexing of full accession.version
  -numeric         Only accept items that are entirely digits

Value Transformation

  -translate       Substitute values with -transform table
  -classify        Substring word or phrase matches to -aliases table

Regular Expression

  -replace         Substitute text using regular expressions

  -reg             Target expression
  -exp             Replacement pattern

Sequence Processing

  -fasta           Split sequence into blocks of 70 uppercase letters

Nucleotide Processing

  -revcomp         Reverse complement nucleotide sequence
  -nucleic         Subrange determines forward or revcomp
  -ncbi2na         Expand ncbi2na to iupac
  -ncbi4na         Expand ncbi4na to iupac
                     (May need to truncate result to actual sequence length)
  -cds2prot        Translate coding region using -gcode and (1-based) -frame

Protein Processing

  -molwt           Calculate molecular weight of peptide
  -molwt-m         Molecular weight retaining initial methionine
  -molwt-f         Keep initial M residue as formyl-methionine

  -pept            Split amino acid runs at *, -, x, or X

Sequence Coordinates

  -0-based         Zero-Based
  -1-based         One-Based
  -ucsc-based      Half-Open

Command Generator

  -insd            Generate INSDSeq extraction commands
  -insdx           Process -insd output table into XML

-insd Argument Order

  Descriptors      INSDSeq_sequence INSDSeq_definition INSDSeq_division
  Flags            [complete|partial]
  Feature(s)       CDS,mRNA
  Qualifiers       INSDFeature_key "#INSDInterval" gene product feat_location sub_sequence

Variation Processing

  -hgvs            Convert sequence variation format to XML

Frequency Table

  -histogram       Collects data for sort-uniq-count on entire set of records

Entrez Indexing

  -indexer         Positional index using -wrp for field name

Output Organization

  -head            Print before everything else
  -tail            Print after everything else
  -hd              Print before each record
  -tl              Print after each record

Record Selection

  -select          Select record subset by conditions
  -in              File of identifiers to use for selection

Record Rearrangement

  -sort            Element to use as sort key
  -sort-fwd        Alias of original -sort
  -sort-rev        Sort records in reverse order

Reformatting

  -format          [copy|compact|flush|indent|expand]

Validation

  -verify          Report XML data integrity problems

  -test            Check field for visible combining accent and invisible Unicode

Summary

  -outline         Display outline of XML structure
  -synopsis        Display individual XML paths
  -contour         Display XML paths to leaf nodes
                     [delimiter]

Full Exploration Command Precedence

  -pattern
  -path
  -division
  -group
  -branch
  -block
  -section
  -subset
  -unit
  -element

Documentation

  -help            Print this document
  -examples        Examples of EDirect and xtract usage
  -unix            Common Unix command arguments
  -version         Print version number

Notes

  String constraints use case-insensitive comparisons.

  Numeric constraints and selection arguments use integer values.

  -num and -len selections are synonyms for Object Count (#) and Item Length (%).

  -words, -pairs, -reverse, and -indexer convert to lower case.

  See transmute -help for data conversion and modification functions.

Xtract Examples

  -pattern DocumentSummary -element Id -first Name Title

  -pattern "PubmedArticleSet/*" -block Author -sep " " -element Initials,LastName

  -pattern PubmedArticle -block MeshHeading -if "@MajorTopicYN" -equals Y -sep " / " -element DescriptorName,QualifierName

  -pattern GenomicInfoType -element ChrAccVer ChrStart ChrStop

  -pattern Taxon -block "*/Taxon" -unless Rank -equals "no rank" -tab "\n" -element Rank,ScientificName

  -pattern Entrezgene -block "**/Gene-commentary"

  -block INSDReference -position 2

  -subset INSDInterval -position last -POS INSDInterval_to -element "&SEQ[&POS+1:]"

  -if Author -and Title

  -if "#Author" -lt 6 -and "%Title" -le 70

  -if DateRevised/Year -gt 2005

  -if ChrStop -lt ChrStart

  -if CommonName -contains mouse

  -if "&ABST" -starts-with "Transposable elements"

  -if MapLocation -element MapLocation -else -lbl "\-"

  -if inserted_sequence -differs-from deleted_sequence

  -min ChrStart,ChrStop

  -max ExonCount

  -inc position -element inserted_sequence

  -1-based ChrStart

  -tag Item -att type journal -cls -encode Source -end Item

  -tag Item -att type journal -atr name Source -slf

  -insd CDS gene product protein_id translation

  -insd complete mat_peptide "%peptide" product peptide

  -insd CDS INSDInterval_iscomp@value INSDInterval_from INSDInterval_to

  -insd source organism taxid -insd CDS gene product feat_intervals sub_sequence

  -pattern PubmedArticle -select PubDate/Year -eq 2015

  -pattern PubmedArticle -select MedlineCitation/PMID -in file_of_pmids.txt

  -wrp PubmedArticleSet -pattern PubmedArticle -sort MedlineCitation/PMID

  -set PubmedArticleSet -pattern PubmedArticle -split 1000 -prefix "subset" -suffix "xml"

  -set PubmedArticleSet -pattern PubmedArticle -allot 500000 -prefix "subset" -suffix "xml"

  -pattern PubmedBookArticle -path BookDocument.Book.AuthorList.Author -element LastName

  -pattern PubmedArticle -group MedlineCitation/Article/Journal/JournalIssue/PubDate -year "PubDate/*"

  -mixed -verify -find MedlineCitation/PMID -html -max 50

Transmute Examples

  transmute -j2x -set - -rec GeneRec

  transmute -t2x -set Set -rec Rec -skip 1 Code Name

  transmute -filter ExpXml decode content

  transmute -filter LocationHist remove object

  transmute -normalize pubmed

  transmute -head "<PubmedArticleSet>" -tail "</PubmedArticleSet>" -pattern "PubmedArticleSet/*" -format
```


## entrez-direct_nquire

### Tool Description
Query Commands

### Metadata
- **Docker Image**: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
- **Package**: https://anaconda.org/channels/bioconda/packages/entrez-direct/overview
- **Validation**: PASS

### Original Help Text
```text
nquire 24.0

Query Commands

  -url         Sends query with HTTP POST
  -get         Uses HTTP GET instead of POST

  -len         Content length of HTTP file

FTP Commands

  -lst         Lists contents of FTP site
  -dir         FTP listing with file sizes

  -ftp         Retrieves data from FTP site

File Downloads

  -dwn         Downloads FTP data to file
  -asp         Uses Aspera download, if configured

-url Shortcuts

  -ncbi        https://www.ncbi.nlm.nih.gov
  -eutils      https://eutils.ncbi.nlm.nih.gov/entrez/eutils
  -pubchem     https://pubchem.ncbi.nlm.nih.gov
  -pugrest     https://pubchem.ncbi.nlm.nih.gov/rest/pug
  -pugview     https://pubchem.ncbi.nlm.nih.gov/rest/pug_view
  -datasets    https://api.ncbi.nlm.nih.gov/datasets/v2alpha

Examples

  nquire -url https://eutils.ncbi.nlm.nih.gov/entrez/eutils/einfo.fcgi |
  xtract -pattern DbList -sep "\n" -element DbName | sort -f

  nquire -url https://eutils.ncbi.nlm.nih.gov entrez/eutils elink.fcgi \
    -dbfrom pubmed -db pubmed -cmd neighbor -linkname pubmed_pubmed -id 2539356 |
  transmute -format

  nquire -eutils esearch.fcgi -db pubmed -term "tn3 transposition immunity" |
  xtract -pattern eSearchResult -element QueryTranslation

  nquire -get https://icite.od.nih.gov/api/pubs -pmids 1937004 10838572 |
  transmute -j2x |
  xtract -pattern opt -element cited_by references |
  accn-at-a-time

  nquire -get "http://collections.mnh.si.edu/services/resolver/resolver.php" \
    -voucher "Birds:625456" |
  xtract -pattern Result -element ScientificName Country

  nquire -get http://w1.weather.gov/xml/current_obs/KSFO.xml |
  xtract -pattern current_observation -tab "\n" \
    -element weather temp_f wind_dir wind_mph

  nquire -get https://api.bigdatacloud.net/data/reverse-geocode-client \
    -latitude 41.7909 -longitude "\-87.5994" |
  transmute -j2x |
  xtract -pattern opt -element countryCode \
    -block administrative -if description -starts-with "state " -element name \
    -block administrative -if description -starts-with "city " -element name |
  tr '\t' '\n'

  nquire -get https://rest.ensembl.org/sequence/id/ENSAPLG00000012763 \
    -content-type application/json

  nquire -get http://mygene.info/v3 query -q 'symbol:OPN1MW AND taxid:9606' \
    -fetch_all TRUE |
  xtract -pattern hits -element _id

  nquire -url http://mygene.info/v3 gene -ids 2652 -fields pathway.wikipathways \
    -always_list pathway.wikipathways |
  xtract -pattern anon -path pathway.wikipathways.id -tab "\n" -element "id"

  nquire -ftp ftp.ncbi.nlm.nih.gov pub/gdp ideogram_9606_GCF_000001305.14_850_V1 |
  grep acen | cut -f 1,2,6,7 | awk '/^X\t/'

  nquire -lst ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/converters/by_program/

  nquire -lst ftp://nlmpubs.nlm.nih.gov online/mesh/MESH_FILES/xmlmesh

  nquire -dwn ftp.nlm.nih.gov online/mesh/MESH_FILES/xmlmesh desc2021.zip

  nquire -dwn ftp.ncbi.nlm.nih.gov asn1-converters by_program asn2flat mac.asn2flat.gz

  for sect in baseline updatefiles
  do
    nquire -lst ftp.ncbi.nlm.nih.gov pubmed "$sect" |
    grep -v ".md5" | grep "xml.gz" |
    skip-if-file-exists | tee /dev/tty |
    nquire -asp ftp.ncbi.nlm.nih.gov pubmed "$sect"
  done

  nquire -raw -get http://golr-aux.geneontology.io/solr/select \
    -fq document_category:\"ontology_class\" -q *:* -fq id:\"GO:0030182\" \
    -wt json |
  transmute -j2x |
  xtract -pattern opt -element neighborhood_limited_graph_json topology_graph_json |
  transmute -j2x |
  xtract -pattern opt -num nodes edges

  nquire -pugrest compound name catechol cids TXT

  nquire -pugrest compound smiles description XML \
    -smiles "C1=CC=C(C(=C1)O)O" |
  xtract -pattern Information -element Title

  nquire -pugrest compound inchi synonyms TXT \
    -inchi "1S/C6H6O2/c7-5-3-1-2-4-6(5)8/h1-4,7-8H"

  nquire -pugrest compound inchikey cids JSON \
    -inchikey "YCIMNLLNPGFGHC-UHFFFAOYSA-N"

  nquire -pugrest compound/fastsubstructure/smarts/cids/XML \
    -smarts "[#7]-[#6]-1=[#6]-[#6](C#C)=[#6](-[#6]-[#8])-[#6]=[#6]-1" \
    -list_return listkey |
  nquire -puglist |
  efetch -format docsum

  nquire -pugrest compound superstructure cid 2244 XML |
  nquire -pugwait

  nquire -pugview data compound 289 XML -heading "Substances by Category"

  nquire -get https://pubmed.ncbi.nlm.nih.gov/api/citmatch -method heuristic \
    -raw-text "nucleotide+sequences+required+for+tn3+transposition+immunity"

Integrated Shortcuts

  nquire -litvar rs11549407

  nquire -pathway Reactome:R-HSA-70171

  nquire -gene-to-pathway 1956

  nquire -citmatch "nucleotide sequences required for tn3 transposition immunity"

NCBI Datasets Shortcuts

 Gene

  nquire -datasets gene accession NM_020107.5,NP_001334352.2 |
  xtract -pattern reports -element gene_id query symbol description

  nquire -datasets gene id 2652,3043 | json2xml

  nquire -datasets gene id 2652 orthologs

  nquire -datasets gene id 2652,3043 links

  nquire -datasets gene id 2562,3043 download > pair.zip

  nquire -datasets gene id 2562,3043 download - | jsonl2xml

  nquire -datasets gene id 2562,3043 download_summary

  nquire -datasets gene symbol CFTR,HBB,HFE,IL9R,MT-ATP6,PRNP taxon human |
  xtract -pattern reports -sort symbol |
  xtract -pattern reports -if gene/type -is-not PSEUDO -def "-" \
    -element symbol -sep "," -element chromosomes \
    -rst -first genomic_range/orientation |
  align-columns -g 4

  nquire -datasets gene taxon 9606

  nquire -datasets gene taxon human counts

 Genome

  nquire -datasets genome accession GCF_000001405 dataset_report

  nquire -datasets genome accession GCF_000001405 links

  nquire -datasets genome bioproject PRJEB33226 dataset_report

 Virus

  nquire -datasets virus accession NC_063383.1 check

  nquire -datasets virus accession NC_063383.1 annotation_report

  nquire -datasets virus accession NC_063383.1 dataset_report

  nquire -datasets virus accession NC_063383.1,NC_045512.2 genome download > pair.zip

 Taxonomy

  nquire -datasets taxonomy taxon 9606,10090 

NCBI Datasets POST Queries

 echo 2652,3043 |

  nquire -datasets gene

  nquire -datasets gene links

  nquire -datasets gene download > pair.zip

 echo 2652 |

  nquire -datasets gene download_summary

 echo NC_063383.1,NC_045512.2 |

  nquire -datasets virus genome download > pair.zip
```


## Metadata
- **Skill**: generated
