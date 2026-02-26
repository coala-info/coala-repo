# table2asn CWL Generation Report

## table2asn

### Tool Description
Converts files of various formats to ASN.1

### Metadata
- **Docker Image**: quay.io/biocontainers/table2asn:1.28.1179--he45da00_1
- **Homepage**: https://www.ncbi.nlm.nih.gov/genbank/table2asn/
- **Package**: https://anaconda.org/channels/bioconda/packages/table2asn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/table2asn/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE
  table2asn [-h] [-help] [-help-full] [-xmlhelp] [-indir Directory]
    [-outdir Directory] [-E] [-x String] [-i InFile] [-aln-file InFile]
    [-aln-gapchar STRING] [-aln-missing STRING] [-aln-alphabet STRING]
    [-o OutFile] [-out-suffix String] [-binary] [-t InFile] [-a String] [-J]
    [-A String] [-C String] [-j String] [-src-file InFile] [-accum-mods]
    [-y String] [-Y InFile] [-D InFile] [-f InFile] [-V String] [-q] [-U] [-T]
    [-P] [-W] [-K] [-H String] [-Z] [-split-dr] [-c String] [-z OutFile]
    [-N String] [-w InFile] [-M String] [-l String]
    [-linkage-evidence-file InFile] [-gap-type String] [-m String]
    [-ft-url String] [-ft-url-mod String] [-gaps-min Integer]
    [-gaps-unknown Integer] [-postprocess-pubs] [-locus-tag-prefix String]
    [-no-locus-tags-needed] [-euk] [-suspect-rules String] [-allow-acc]
    [-intronless] [-refine-prt-alignments]
    [-prt-alignment-filter-query String] [-logfile LogFile] [-logxml LogFile]
    [-split-logs] [-verbose] [-huge] [-disable-huge] [-usemt String] [-r]
    [-genbank] [-gb-method GBMethod] [-gb-snp enable] [-gb-wgs enable]
    [-gb-cdd enable] [-vdb] [-novdb] [-vdb-path Path] [-sra] [-sra-acc AddSra]
    [-sra-file AddSra] [-fetchall] [-conffile File_Name] [-version]
    [-version-full] [-version-full-xml] [-version-full-json]

DESCRIPTION
   Converts files of various formats to ASN.1

OPTIONAL ARGUMENTS
 -h
   Print USAGE and DESCRIPTION;  ignore all other parameters
 -help
   Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
 -help-full
   Print USAGE, DESCRIPTION and ARGUMENTS, including hidden ones; ignore all
   other parameters
 -xmlhelp
   Print USAGE, DESCRIPTION and ARGUMENTS in XML format; ignore all other
   parameters
 -indir <File_In>
   Path to input files
 -outdir <File_Out>
   Path to results
 -E
   Recurse
 -x <String>
   Suffix
   Default = `.fsa'
 -i <File_In>
   Single Input File
    * Incompatible with:  aln-file
 -aln-file <File_In>
   Alignment input file
    * Incompatible with:  i
 -aln-gapchar <String>
   Alignment missing indicator
   Default = `-'
 -aln-missing <String>
   Alignment missing indicator
   Default = `'
 -aln-alphabet <String, `nuc', `prot'>
   Alignment alphabet
   Default = `prot'
 -o <File_Out>
   Single Output File
 -out-suffix <String>
   ASN.1 files suffix
   Default = `.sqn'
 -binary
   Output binary ASN.1
 -t <File_In>
   Template File
 -a <String>
   File Type
         a Any
         s FASTA Set
         d FASTA Delta, di FASTA Delta with Implicit Gaps
         z FASTA with Gap Lines
   Default = `a'
 -J
   Delayed Genomic Product Set 
 -A <String>
   Accession
 -C <String>
   Genome Center Tag
 -j <String>
   Source Qualifiers.
   These qualifier values override any conflicting values read from a file
   (See -src-file)
 -src-file <File_In>
   Single source qualifiers file. The qualifiers in this file override any
   conflicting qualifiers automically read from a .src file, which, in turn,
   take precedence over source qualifiers specified in a fasta defline
 -accum-mods
   Accumulate non-conflicting modifier values from different sources. For
   example, with this option, a 'note' modifier specified on the command line
   no longer overwrites a 'note' modifier read from a .src file. Both notes
   will appear in the output ASN.1. If modifier values conflict, the rules of
   precedence specified above apply
 -y <String>
   Comment
 -Y <File_In>
   Comment File
 -D <File_In>
   Descriptors File
 -f <File_In>
   Single 5 column table file or other annotations
 -V <String>
   Verification (combine any of the following letters)
         v Validate with Normal Stringency
         b Generate GenBank Flatfile
         t Validate with TSA Check
 -q
   Seq ID from File Name
 -U
   Remove Unnecessary Gene Xref
 -T
   Remote Taxonomy Lookup
 -P
   Remote Publication Lookup
 -W
   Log Progress
 -K
   Save Bioseq-set
 -H <String>
   Hold Until Publish
         y Hold for One Year
         mm/dd/yyyy
 -Z
   Output discrepancy report
 -split-dr
   Create unique discrepancy report for each output file
 -c <String>
   Cleanup (combine any of the following letters)
         b Basic cleanup (default)
         e Extended cleanup
         f Fix product names
         s Add exception to short introns
         w WGS cleanup (only needed when using a GFF3 file)
         d Correct Collection Dates (assume month first)
         D Correct Collection Dates(assume day first)
         x Extend ends of features by one or two nucleotides to abut gaps or
   sequence ends
         - avoid cleanup
 -z <File_Out>
   Cleanup Log File
 -N <String>
   Project Version Number
 -w <File_In>
   Single Structured Comment File
 -M <String>
   Master Genome Flags
         n Normal
         t TSA
 -l <String>
   Add type of evidence used to assert linkage across assembly gaps. May be
   used multiple times. Must be one of the following:
         paired-ends
         align-genus
         align-xgenus
         align-trnscpt
         within-clone
         clone-contig
         map
         strobe
         unspecified
         pcr
         proximity-ligation
 -linkage-evidence-file <File_In>
   File listing linkage evidence for gaps of different lengths
 -gap-type <String>
   Set gap type for runs of Ns. Must be one of the following:
         scaffold
         short-arm
         heterochromatin
         centromere
         telomere
         repeat
         contamination
         contig
         unknown (obsolete)
         fragment
         clone
         other (for future use)
 -m <String>
   Lineage to use for Discrepancy Report tests
 -ft-url <String>
   FileTrack URL for the XML file retrieval
 -ft-url-mod <String>
   FileTrack URL for the XML file base modifications
 -gaps-min <Integer>
   minimum run of Ns recognised as a gap
 -gaps-unknown <Integer>
   exact number of Ns recognised as a gap with unknown length
 -postprocess-pubs
   Postprocess pubs: convert authors to standard
 -locus-tag-prefix <String>
   Add prefix to locus tags in annotation files
 -no-locus-tags-needed
   Submission data does not require locus tags
 -euk
   Assume eukaryote, and create missing mRNA features
 -suspect-rules <String>
   Path to a file containing suspect rules set. Overrides environment variable
   PRODUCT_RULES_LIST
 -allow-acc
   Allow accession recognition in sequence IDs. Default is local
 -intronless
   Intronless alignments
 -refine-prt-alignments
   Refine ProSplign aligments when processing .prt input
 -prt-alignment-filter-query <String>
   Filter query string for .prt alignments
 -logfile <File_Out>
   Error Log File
    * Incompatible with:  logxml
 -logxml <File_Out>
   XML Error Log File
    * Incompatible with:  logfile
 -split-logs
   Create unique log file for each output file
 -verbose
   Be verbose on reporting
 -huge
   Execute in huge-file mode
    * Incompatible with:  disable-huge
 -disable-huge
   Explicitly disable huge-files mode
    * Incompatible with:  huge
 -usemt <String>
   Try to use as many threads as:
         one
         two
         many
 -version
   Print version number;  ignore other arguments
 -version-full
   Print extended version data;  ignore other arguments
 -version-full-xml
   Print extended version data in XML format;  ignore other arguments
 -version-full-json
   Print extended version data in JSON format;  ignore other arguments

 *** Data source and object manager options
 -r
   Enable remote data retrieval
 -genbank
   Enable remote data retrieval using the Genbank data loader
 -gb-method <String>
   Semicolon-separated list of Genbank loader method(s)
    * Requires:  genbank
 -gb-snp <Boolean>
   Genbank SNP processor
    * Requires:  genbank
 -gb-wgs <Boolean>
   Genbank WGS processor
    * Requires:  genbank
 -gb-cdd <Boolean>
   Genbank SNP processor
    * Requires:  genbank
 -vdb
   Use VDB data loader.
    * Incompatible with:  novdb
 -novdb
   Do not use VDB data loader.
    * Incompatible with:  vdb
 -vdb-path <String>
   Root path for VDB look-up
 -sra
   Add the SRA data loader with no options.
    * Incompatible with:  sra-acc, sra-file
 -sra-acc <String>
   Add the SRA data loader, specifying an accession.
    * Incompatible with:  sra, sra-file
 -sra-file <String>
   Add the SRA data loader, specifying an sra file.
    * Incompatible with:  sra, sra-acc

 *** General application arguments
 -fetchall
   Search data in all available databases
 -conffile <File_In>
   Program's configuration (registry) data file
   Default = `table2asn.conf'
```

