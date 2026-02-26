# tbl2asn-forever CWL Generation Report

## tbl2asn-forever_tbl2asn

### Tool Description
tbl2asn 25.7

### Metadata
- **Docker Image**: quay.io/biocontainers/tbl2asn-forever:25.7.1f--0
- **Homepage**: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2
- **Package**: https://anaconda.org/channels/bioconda/packages/tbl2asn-forever/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbl2asn-forever/overview
- **Total Downloads**: 97.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
tbl2asn 25.7   arguments:

  -p  Path to Files [String]  Optional
  -r  Path for Results [String]  Optional
  -i  Single Input File [File In]  Optional
  -o  Single Output File [File Out]  Optional
  -x  Suffix [String]  Optional
    default = .fsa
  -E  Recurse [T/F]  Optional
    default = F
  -t  Template File [File In]  Optional
  -a  File Type
      a Any
      r20u Runs of 20+ Ns are gaps, 100 Ns are unknown length
      r20k Runs of 20+ Ns are gaps, 100 Ns are known length
      r10u Runs of 10+ Ns are gaps, 100 Ns are unknown length
      r10k Runs of 10+ Ns are gaps, 100 Ns are known length
      s FASTA Set (s Batch, s1 Pop, s2 Phy, s3 Mut, s4 Eco, s9 Small-genome)
      d FASTA Delta, di FASTA Delta with Implicit Gaps
      l FASTA+Gap Alignment (l Batch, l1 Pop, l2 Phy, l3 Mut, l4 Eco, l9 Small-genome)
      z FASTA with Gap Lines
      e PHRAP/ACE
      b ASN.1 for -M flag
 [String]  Optional
    default = a
  -s  Read FASTAs as Set [T/F]  Optional
    default = F
  -g  Genomic Product Set [T/F]  Optional
    default = F
  -J  Delayed Genomic Product Set [T/F]  Optional
    default = F
  -F  Feature ID Links
      o By Overlap
      p By Product
      l By Label and Location
      s Suppress links forced by -M
 [String]  Optional
  -A  Accession [String]  Optional
  -C  Genome Center Tag [String]  Optional
  -n  Organism Name [String]  Optional
  -j  Source Qualifiers [String]  Optional
  -y  Comment [String]  Optional
  -Y  Comment File [File In]  Optional
  -D  Descriptors File [File In]  Optional
  -f  Single Table File [File In]  Optional
  -k  CDS Flags (combine any of the following letters)
      c Annotate Longest ORF
      r Allow Runon ORFs
      m Allow Alternative Starts
      k Set Conflict on Mismatch
 [String]  Optional
  -V  Verification (combine any of the following letters)
      v Validate with Normal Stringency
      r Validate without Country Check
      c BarCode Validation
      b Generate GenBank Flatfile
      g Generate Gene Report
      t Validate with TSA Check
 [String]  Optional
  -v  Validate (obsolete: use -V v) [T/F]  Optional
    default = F
  -b  Generate GenBank File (obsolete: use -V b) [T/F]  Optional
    default = F
  -q  Seq ID from File Name [T/F]  Optional
    default = F
  -u  GenProdSet to NucProtSet [T/F]  Optional
    default = F
  -h  General ID to Note [T/F]  Optional
    default = F
  -G  Alignment Gap Flags (comma separated fields, e.g., p,-,-,-,?,. )
      n Nucleotide or p Protein,
      Begin, Middle, End Gap Characters,
      Missing Characters, Match Characters
 [String]  Optional
  -R  Remote Sequence Record Fetching from ID [T/F]  Optional
    default = F
  -S  Smart Feature Annotation [T/F]  Optional
    default = F
  -Q  mRNA Title Policy
      s Special mRNA Titles
      r RefSeq mRNA Titles
 [String]  Optional
  -U  Remove Unnecessary Gene Xref [T/F]  Optional
    default = F
  -L  Force Local protein_id/transcript_id [T/F]  Optional
    default = F
  -T  Remote Taxonomy Lookup [T/F]  Optional
    default = F
  -P  Remote Publication Lookup [T/F]  Optional
    default = F
  -W  Log Progress [T/F]  Optional
    default = F
  -K  Save Bioseq-set [T/F]  Optional
    default = F
  -H  Hold Until Publish
      y Hold for One Year
      mm/dd/yyyy
 [String]  Optional
  -Z  Discrepancy Report Output File [File Out]  Optional
  -c  Cleanup (combine any of the following letters)
      d Correct Collection Dates (assume month first)
      D Correct Collection Dates (assume day first)
      b Append note to coding regions that overlap other coding regions with similar product names and do not contain 'ABC'
      x Extend partial ends of features by one or two nucleotides to abut gaps or sequence ends
      p Add exception to non-extendable partials
      s Add exception to short introns
      f Fix product names
 [String]  Optional
  -z  Cleanup Log File [File Out]  Optional
  -X  Extra Flags (combine any of the following letters)
      A Automatic definition line generator
      C Apply comments in .cmt files to all sequences
      E Treat like eukaryota in the Discrepancy Report
 [String]  Optional
  -N  Project Version Number [Integer]  Optional
    default = 0
  -w  Single Structured Comment File (overrides the use of -X C) [File In]  Optional
  -M  Master Genome Flags
      n Normal
      b Big Sequence
      p Power Option
      t TSA
 [String]  Optional
  -l  Add type of evidence used to assert linkage across assembly gaps (only for TSA records). Must be one of the following:
      paired-ends
      align-genus
      align-xgenus
      align-trnscpt
      within-clone
      clone-contig
      map
      strobe
 [String]  Optional
  -m  Lineage to use for Discrepancy Report tests
 [String]  Optional
```

