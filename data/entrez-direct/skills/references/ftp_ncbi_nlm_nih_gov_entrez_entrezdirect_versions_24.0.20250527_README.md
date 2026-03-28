ENTREZ DIRECT: COMMAND LINE ACCESS TO NCBI ENTREZ DATABASES
Searching, retrieving, and parsing data from NCBI databases through the Unix command line.
INTRODUCTION
Entrez Direct (EDirect) provides access to Entrez, the NCBI's suite of interconnected databases, from a Unix terminal window. Search terms are entered as command-line arguments. Individual operations are connected with Unix pipes to construct multi-step queries. Selected records can then be retrieved in a variety of formats.
PROGRAMMATIC ACCESS
EDirect connects to Entrez through the Entrez Programming Utilities interface. It supports searching by indexed terms, looking up precomputed neighbors or links, filtering results by date or category, and downloading record summaries or reports.
Navigation programs (esearch, elink, efilter, and efetch) communicate by means of a small structured message, which can be passed invisibly between operations with a Unix pipe. The message includes the current database, so it does not need to be given as an argument after the first step.
Accessory programs (nquire, transmute, and xtract) can help eliminate the need for writing custom software to answer ad hoc questions. Queries can move seamlessly between EDirect programs and Unix utilities or scripts to perform actions that cannot be accomplished entirely within Entrez.
NAVIGATION FUNCTIONS
Esearch performs a new Entrez search using terms in indexed fields. It requires a -db argument for the database name and uses -query for the search terms. For PubMed, without field qualifiers, the server uses automatic term mapping to compose a search strategy by translating the supplied query:
esearch -db pubmed -query "selective serotonin reuptake inhibitor"
Search terms can also be qualified with a bracketed field name to match within the specified index:
esearch -db nuccore -query "insulin [PROT] AND rodents [ORGN]"
Elink looks up precomputed neighbors within a database, or finds associated records in other databases, or uses the NIH Open Citation Collection service (PMID 31600197) to follow reference lists:
elink -related
elink -target gene
elink -cited
elink -cites
Efilter limits the results of a previous query, with shortcuts that can also be used in esearch:
efilter -molecule genomic -location chloroplast -country sweden -mindate 1985
Efetch downloads selected records or reports in a style designated by -format:
efetch -format abstract
Individual query commands are connected by a Unix vertical bar pipe symbol:
esearch -db pubmed -query "tn3 transposition immunity" | efetch -format apa
The vertical bar also allows query steps to be placed on separate lines:
esearch -db pubmed -query "raynaud disease AND fish oil" |
efetch -format medline
Each program has a -help command that prints detailed information about available arguments.
EDirect programs are designed to work on large sets of data. There is no need to use a script to loop over records in small groups, or write code to retry a query after a transient network or server failure, or add a time delay between requests. All of those features are already built into the system.
ACCESSORY PROGRAMS
Nquire retrieves data from remote servers with URLs constructed from command line arguments:
nquire -get https://icite.od.nih.gov api/pubs -pmids 2539356 |
Transmute converts a concatenated stream of JSON objects or other structured formats into XML:
transmute -j2x |
Xtract uses waypoints to navigate complex XML hierarchies, and obtains data values by field name:
xtract -pattern data -element cited\_by |
The resulting output can be post-processed by Unix utilities or scripts:
fmt -w 1 | sort -V | uniq
INSTALLATION
EDirect consists of a set of scripts and programs that are downloaded to the user's computer. To install the software, open a terminal window and execute one of the following two commands:
sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
sh -c "$(wget -q https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"
One installation is complete, run the following to set the PATH for the current terminal session:
export PATH=${HOME}/edirect:${PATH}
For best performance, obtain an API Key from NCBI, and place the following line in your .bash\_profile and .zshrc configuration files:
export NCBI\_API\_KEY=unique\_api\_key
DISCOVERY BY NAVIGATION
PubMed related articles are identified by a statistical text retrieval algorithm using the title, abstract, and medical subject headings (MeSH terms). The connections between papers can be used for making discoveries. An example of this is finding the last enzymatic step in the vitamin A biosynthetic pathway.
Lycopene cyclase in plants converts lycopene into beta-carotene, the immediate biochemical precursor of vitamin A. Beta-Carotene is an essential nutrient, required in the diet of herbivores. This indicates that lycopene cyclase is not present in animals (with a few exceptions caused by horizontal gene transfer), and that the enzyme responsible for converting beta-carotene into vitamin A is not present in plants.
An initial search on the lycopene cyclase enzyme finds 306 articles. Looking up precomputed neighbors returns 19,146 papers, some of which might be expected to discuss other enzymes in the pathway:
esearch -db pubmed -query "lycopene cyclase" | elink -related |
We cannot reliably limit the results to animals in PubMed, but we can for sequence records, which are indexed by the NCBI taxonomy. Linking the publication neighbors to their associated protein records finds 604,878 sequences. Restricting those to mice excludes plants, fungi, and bacteria, which eliminates the earlier enzymes:
elink -target protein | efilter -organism mouse -source refseq |
This matches only 32 sequences, which is small enough to examine by retrieving the individual records:
efetch -format fasta
As anticipated, the results include the enzyme that splits beta-carotene into two molecules of retinal:
...
>NP\_067461.2 beta,beta-carotene 15,15'-dioxygenase isoform 1 [Mus musculus]
MEIIFGQNKKEQLEPVQAKVTGSIPAWLQGTLLRNGPGMHTVGESKYNHWFDGLALLHSFSIRDGEVFYR
SKYLQSDTYIANIEANRIVVSEFGTMAYPDPCKNIFSKAFSYLSHTIPDFTDNCLINIMKCGEDFYATTE
...
A better example used Entrez protein neighbors to instantly rediscover the similarity between a human colon cancer gene and microbial DNA repair genes. Unfortunately, precomputed BLAST links were discontinued due to the exponential growth of the sequence databases.
XML DATA EXTRACTION
The ability to obtain Entrez records in structured format, and to easily extract the underlying data, allows the user to ask novel questions that are not addressed by existing analysis software.
The xtract program uses command-line arguments to direct the conversion of data in eXtensible Markup Language format. It allows record detection, path exploration, element selection, conditional processing, and report formatting to be controlled independently.
The -pattern command partitions an XML stream by object name into individual records that are processed separately. Within each record, the -element command does an exhaustive, depth-first search to find data content by field name.
Neither explicit object paths nor complicated path formulas are needed for element identification.
FORMAT CUSTOMIZATION
By default, the -pattern argument divides the results into rows, while placement of data into columns is controlled by -element, to create a tab-delimited table.
Formatting commands allow extensive customization of the output. The line break between -pattern rows is changed with -ret, while the tab character between -element columns is modified by -tab.
Multiple instances of the same element are distinguished using -sep, which controls their separation independently of the -tab command. The following query:
efetch -db pubmed -id 6271474,6092233,16589597 -format docsum |
xtract -pattern DocumentSummary -sep "|" -element Id PubDate Name
returns a tab-delimited table with individual author names separated by vertical bars:
6271474 1981 Casadaban MJ|Chou J|Lemaux P|Tu CP|Cohen SN
6092233 1984 Jul-Aug Calderon IL|Contopoulou CR|Mortimer RK
16589597 1954 Dec Garber ED
The -sep value also applies to distinct -element arguments that are grouped with commas. This can be used to keep data from multiple related fields in the same column:
-sep " " -element Initials,LastName
The -def command sets a default placeholder to be printed when none of the comma-separated fields in an -element clause are present:
-def "-" -sep " " -element Year,Month,MedlineDate
Repackaging commands (-wrp, -enc, and -pkg) wrap extracted data values with bracketed XML tags given only the object name. For example, "-wrp Word" issues the following formatting instructions:
-pfx "" -sep "" -sfx ""
It also sets an internal flag to ensure that data values containing encoded ampersands, angle brackets, apostrophes, and quotation marks remain properly encoded inside the new XML.
ELEMENT VARIANTS
Derivatives of -element were created to avoid the inconvenience of having to write post-processing scripts to perform trivial modifications or integer calculations on extracted data. Other variants were added for content normalization, report formatting, or index generation. They are subdivided into several categories. Substitute for -element as needed. A representative selection is shown below:
Positional: -first, -last, -even, -odd, -backward
Numeric: -num, -len, -inc, -dec, -mod, -bin, -hex, -bit, -sqt, -lge, -lg2, -log
Statistics: -sum, -acc, -min, -max, -dev, -med, -avg, -geo, -hrm, -rms
Character: -upper, -lower, -title, -mirror, -alpha, -alnum
Text: -terms, words, -pairs, -letters, -split, -order, -reverse, -prose
Sequence: -revcomp, -fasta, -ncbi2na, -cds2prot, -molwt, -pept, -nucleic
Citation: -year, -month, -date, -auth, -initials, -page, -author, -journal
Other: -doi, -wct, -trim, -pad, -accession, -numeric
The original -element prefix shortcuts, "#" and "%", are redirected to -num and -len, respectively.
VALUE SUBSTITUTION
External values can be inserted by reading a two-column, precomputed file or ad hoc conversion table with -transform, and then requesting a replacement by applying -translate to an element:
xtract -transform accn-to-uid.txt ... -translate Accession
xtract -transform <( echo -e "Genomic\t1\nCoding\t2\nProtein\t3\n" ) ...
PARSING FIELDS
The -with and -split commands can parse multiple clauses that are packed into a single field:
-wrp Item -with ";" -split Attributes
SUBSTRING LIMITS
When square brackets follow an element name, a colon separates internal substring start and stop positions, while a vertical bar separates prefix and suffix endpoints for removal of flanking strings:
-author Initials[1:1],LastName -prose "Title[phospholipase | rattlesnake]"
-wrp Tag -element "Item[|=]" -wrp Val -element "Item[=|]"
LOCAL CONTEXT
An -element argument can use the parent / child construct to limit selection when items can only be disambiguated by position, not by name. In this case it prevents the display of additional PMIDs that might be present in CommentsCorrections objects deeper in the MedlineCitation container:
xtract -pattern PubmedArticle -element MedlineCitation/PMID
EXPLORATION CONTROL
Exploration commands allow precise control over the order in which XML record contents are examined, by separately presenting each instance of the chosen subregion. This limits what subsequent commands "see" at any one time, allowing related fields in an object to be kept together.
Unlike the simpler DocumentSummary format, records retrieved as PubmedArticle XML:
efetch -db pubmed -id 1413997 -format xml |
have authors with separate fields for last name and initials:
Mortimer
RK
Without being given any guidance about context, an -element command on initials and last names:
xtract -pattern PubmedArticle -element Initials LastName
will explore the current record for each argument in turn, printing all initials followed by all last names:
RK CR JS Mortimer Contopoulou King
Inserting a -block command adds another exploration layer between -pattern and -element, and redirects data exploration to present the authors one at a time:
xtract -pattern PubmedArticle -block Author -element Initials LastName
Each time through the loop, the -element command only sees the current author's values. This restores the correct association of initials and last names in the output:
RK Mortimer CR Contopoulou JS King
Grouping the two author subfields with a comma, and adjusting the -sep and -tab values:
xtract -pattern PubmedArticle -block Author \
-sep " " -tab ", " -element Initials,LastName
produces a more traditional formatting of author names:
RK Mortimer, CR Contopoulou, JS King
NESTED EXPLORATION
Exploration command names (-group, -block, and -subset) are assigned to a precedence hierarchy:
-pattern > -group > -block > -subset > -element
and are combined in ranked order to control object iteration at progressively deeper levels in the XML data structure. Each command argument acts as a "nested for-loop" control variable, retaining information about the context, or state of exploration, at its level.
A nucleotide or protein sequence record can have multiple features. Each feature can have multiple qualifiers. And every qualifier has separate name and value nodes. Exploring this natural data hierarchy, with -pattern for the sequence, -group for the feature, and -block for the qualifier:
efetch -db nuccore -id NM\_021486.4 -format gbc |
xtract -pattern INSDSeq -element INSDSeq\_accession-version \
-group INSDFeature -deq "\n\t" -element INSDFeature\_key \
-block INSDQualifier -deq "\n\t\t" \
-element INSDQualifier\_name INSDQualifier\_value
keeps qualifiers, such as gene and product, associated with their parent features, and keeps qualifier names and values together on the same line:
NM\_021486.4
source
organism Mus musculus
mol\_type mRNA
gene
gene Bco1
CDS
gene Bco1
product beta,beta-carotene 15,15'-dioxygenase isoform 1
protein\_id NP\_067461.2
translation MEIIFGQNKKEQLEPVQAKVTGSIPAWLQGTLLRNGPGM ...
...
SAVING DATA IN VARIABLES
A value can be recorded in a variable and used wherever needed. Variables are created by a hyphen followed by a name consisting of a string of capital letters or digits (e.g., -KEY). Stored values are retrieved by placing an ampersand before the variable name (e.g., "&KEY") in an -element statement:
efetch -db nuccore -id NM\_021486.4 -format gbc |
xtract -pattern INSDSeq -element INSDSeq\_accession-version \
-group INSDFeature -KEY INSDFeature\_key \
-block INSDQualifier -deq "\n\t" \
-element "&KEY" INSDQualifier\_name INSDQualifier\_value
This prints the feature key on each line before the qualifier name and value, even though the feature key is now outside of the visibility scope (which is the current qualifier):
NM\_021486.4
source organism Mus musculus
source mol\_type mRNA
gene gene Bco1
CDS gene Bco1
CDS product beta,beta-carotene 15,15'-dioxygenase isoform 1
CDS protein\_id NP\_067461.2
C