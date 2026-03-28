![U.S. flag](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/favicons/favicon-57.png)

An official website of the United States government

Here's how you know

![Dot gov](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-dot-gov.svg)

**The .gov means it’s official.**

Federal government websites often end in .gov or .mil. Before
sharing sensitive information, make sure you’re on a federal
government site.

![Https](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-https.svg)

**The site is secure.**

The **https://** ensures that you are connecting to the
official website and that any information you provide is encrypted
and transmitted securely.

[![NIH NLM Logo](https://www.ncbi.nlm.nih.gov/coreutils/nwds/img/logos/AgencyLogo.svg)](https://www.ncbi.nlm.nih.gov/)

[Log in](https://account.ncbi.nlm.nih.gov)

Show account info

Close

#### Account

Logged in as:

* [Dashboard](/myncbi/)
* [Publications](/myncbi/collections/bibliography/)
* [Account settings](/account/settings/)
* [Log out](/account/signout/)

[Access keys](https://www.ncbi.nlm.nih.gov/guide/browsers/#ncbi_accesskeys)
[NCBI Homepage](https://www.ncbi.nlm.nih.gov)
[MyNCBI Homepage](/myncbi/)
[Main Content](#maincontent)
Main Navigation

[BLAST ®](../../blast/Blast.cgi)

* [Home](../../blast/Blast.cgi?CMD=Web&PAGE_TYPE=BlastHome "BLAST Home")
* [Recent Results](../../blast/Blast.cgi?CMD=GetSaved&RECENT_RESULTS=on "Unexpired BLAST jobs")
* [Saved Strategies](../../blast/Blast.cgi?CMD=GetSaved "Saved sets of BLAST search parameters")
* [Help](index.html "BLAST documentation")

[BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi)

>

[blast-help](index.html#index)

>

Frequently Asked Questions

Was this content helpful?

Yes

No

# Frequently Asked Questions[¶](#frequently-asked-questions "Link to this heading")

Q: What are the lower case, grey letters in the query sequence in BLAST results?

You are seeing the result of automatic filtering of your query for [low-complexity sequence](#faq-10). This filter prevents matches that are probably artifacts. The filter substitutes any low-complexity sequence with lowercase grey characters in the results, which allows you to see the sequence that was filtered.

You can turn off the filter before submitting your search; see the checkbox in the “Algorithm parameters” section. However, turning off the filter could lead to a failed search due to excessive CPU usage.

Q: Submitting primers or other short sequences?

Use the [Primer-BLAST tool](https://www.ncbi.nlm.nih.gov/tools/primer-blast/) to search with pair of primers.
You can enter the forward and reverse primers in the primer input boxes on the form. Select the appropriate database
and a taxonomic group (organism) in the ‘Primer Pair Specificity Checking Parameters’ section of the form
and click the ‘Get Primers’ button. The results will show you what sequences in the database match both primers
and the lengths of potential products. For other short sequences you can use [nucleotide BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch) in the usual way. Simply paste or type your sequences in the query box, select the appropriate database and click the BLAST button. The BLAST parameters will automatically adjust to find matches to short sequences.

Q: How to limit a search to an organism or taxonomic group?

To search only sequences for an organism or taxonomic group, use the “Organism” text box. Begin to enter a common name (*e.g.*, rat, bacteria), a genus or species name, or an NCBI taxonomy id (*e.g.*, 9606); then select a name from the list.

You can also exclude taxonomic groups with the “exclude” checkbox to the right of the “Organism” box.

Additional taxonomic groups can be included or excluded with the “Add organism” button.

You can search for taxa in the [Taxonomy Browser](https://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/).

Q: How to exclude models (XM/XP accessions) and uncultured environmental sequences?

Look at the “Choose Search Set” section of a search form, locate the Exclude line, check the checkboxes to the right to exclude those sequences from your search.

Q: How to limit a search to a subset of database sequences?

For protein databases, you can use the following options:

* limit to a group of organisms through the Organims option
* exclude Models (XM/XP), Non-redundant RefSeq proteins (WP), and Uncultured/environmental sample sequences through provided checkboxes

For non-WGS/TSA nucleotide database, you can use the following options:

* limit to a group of organisms through the Organims option
* exclude Models (XM/XP) and Uncultured/environmental sample sequences through provided checkboxes
* limit by Entrez Query through custom search terms. See this video (Wayne’s YT video) for full details.
  Get help with writing Entrez queries in the NCBI Handbook (Anything more specific to link?).

Q: Saving your search parameters?

Once you are satisfied with the parameters for a particular search, you can bookmark that page for future use.
The “Bookmark” button is near the top right of the search page. If logged into your NCBI account,
you can save that search settings using the “Save Search” link at the top left of a search result page.
To access your previously saved search strategies, click the “Saved Strategies” link in the upper right of any BLAST page.

Q: How can I search a batch of sequences with BLAST?

The NCBI cannot provide compute resources for large-scale batch BLAST searches from individual users on the web service.
For batch BLAST searches you can set up standalone BLAST to run against local databases or with th the remote option to run against databases at NCBI.

1. Standalone BLAST programs installed on a local computer or on a cloud service. The BLAST programs are command line programs
   that run BLAST searches against local, downloaded copies of the NCBI BLAST databases, or against custom databases formatted for BLAST. The programs can handle either a single large file with multiple FASTA query sequences, or you can create a script to send multiple files one at a time. The executables are available for a wide variety of platforms, including LINUX, Windows, and Mac OSX. You can install these locally or on a cloud provider. In a cloud setting you may want to use ElasticBLAST package ( that can automatically allocate cloud resources according to the scale of the BLAST search.

   You can download the standalone package from <https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/>.
   The user manual is available from <https://www.ncbi.nlm.nih.gov/books/NBK279690/>.
2. Network BLAST client. The stand-alone executables can send searches to the BLAST server using the -remote flag. See the BLAST manual for details. This client uses NCBI compute resources and is considered a batch search. Searches will be run at lower priority than interactive searches from the NCBI BLAST web pages. Searches run at off-peak hours may have better throughput. Projects involving many searches should be run with stand-alone BLAST against locally installed databases or through an instance at a cloud provider.

Q: How to use BLAST to align two or more sequences without a database search?

On the BLAST search pages at the bottom of the “Enter Query Sequence” section is a checkbox titled **Align two or more sequences**. When you check this box, the search form will change to include a new section, “Enter Subject Sequence”. By entering sequences in the Subject field, and then clicking the BLAST button, you will compare the Query sequence(s) to the sequences you enter.
The subject sequences essentially become a custom database.

Q: What is the Expect (E) Value?

The Expect value (E) is a parameter that describes the number of hits one can “expect” to see by chance when searching a database of a particular size. It decreases exponentially as the Score (S) of the match increases. Essentially, the E value describes the random background noise. For example, an E value of 1 assigned to an alignment means that in a database of the same size one expects to see 1 match with a similar score, or higher, simply by chance.

The lower the E-value the more “significant” the match is. However, keep in mind that virtually identical short alignments have relatively high E values. This is because the calculation of the E value takes into account the length of the query sequence. These high E values make sense because shorter sequences have a higher probability of occurring in the database purely by chance. For more details please see the calculations in the [BLAST Course](https://www.ncbi.nlm.nih.gov/BLAST/tutorial/Altschul-1.html).

The Expect value can also be used as a convenient way to create a [significance threshold](https://blast.ncbi.nlm.nih.gov/doc/blast-topics/blastsearchparams.html#expect) for reporting results. You can change the Expect value threshold on most BLAST search pages. When the Expect value is increased from the default value of 0.05, a larger list with more low-scoring hits can be reported.

Q: What is Low Complexity sequence?

Regions with low-complexity sequence have an unusual composition that can create problems in sequence similarity searching. For amino acid queries this compositional bias is determined by the SEG program (Wootton and Federhen, 1996). For nucleotide queries it is determined by the DustMasker program (Morgulis, et al., 2006).

Low-complexity sequence can often be recognized by visual inspection. For example, the protein sequence PPCDPPPPPKDKKKKDDGPP has low complexity and so does the nucleotide sequence AAATAAAAAAAATAAAAAAT. Filters are used to remove low-complexity sequence because it can cause artefactual hits.

In BLAST searches performed without a filter, high scoring hits may be reported only because of the presence of a low-complexity region. Most often, it is inappropriate to consider this type of match as the result of shared homology. Rather, it is as if the low-complexity region is “sticky” and is pulling out many sequences that are not truly related.

Q: How to filter out (organism-specific) interspersed repeats?

On the “blastn” (nucleotide-nucleotide) page there is an option to filter “Species-specific” repeats for a number of common organisms.
This may be especially important if your query matches to the same or a related organism many times. To enable this, go to the “Algorithm parameters”
section (at the bottom of the page), check “Species-specific repeats”, and choose the proper organism.

Q: What values of parameters do I need to replicate my results on the web in standalone BLAST+?

The following non-standard parameters will need to be changed to mimic webBLAST:

**For blastn**

-evalue 0.05 -max\_target\_seqs 100

**For blastp**

-evalue 0.05 -max\_target\_seqs 100 -seg yes

For a full list of the default parameters in a standalone BLAST+ search please visit our [BLAST+ manual](https://www.ncbi.nlm.nih.gov/books/NBK279684/).

Q: What is the ClusteredNR database and what are the advantages of searching it?

ClusteredNR is a database of clusters of similar proteins generated from the standard protein nr database with [MMseqs2](https://github.com/soedinglab/MMseqs2).
Searching against ClusteredNR is faster, provides greater taxonomic reach, and easier to interpret results than
the traditional nr database. Each cluster contains proteins that are more than 90% identical to each other and within
90% of the length of the longest member. We select a single well-annotated protein that indicates the function
of the proteins in the cluster as the lead or representative protein. The title of the representative protein is
the title that shows in the BLAST results. Each cluster may contain sequences for multiple organisms (species).
On the BLAST results, clusters are identified by the name of the organism for the title protein as well as the most
recent common ancestor taxon for all organisms in the cluster. This makes it clear when the cluster includes multiple
species. You can expand a cluster on your BLAST results to view and download a report or the sequences of all member
proteins, and you can also perform a BLAST alignment of all the members of the cluster.

Q: Why can I not find my sequence when I search "Core\_nt" or "nr" databases?

If you have submitted a sequence to GenBank and cannot find it in the “Core\_nt” databases nor find it’s protein translation in the “nr” database there are two reasons.

Make sure your sequence accessions where released by NCBI into the databases if they have been published. You can do this through the [submission portal](https://submit.ncbi.nlm.nih.gov/) or contact info@ncbi.nlm.nih.gov.

The most common reason specific accession numbers cannot be found in BLAST searches is because the databases are redundant and your sequences is identical to one or more sequences. The “Core\_nt” and “nr” databases are non-redundant meaning that identical sequences are combined into a single entry with a single representative as the title for the entry. In web BLAST if you go to the alignments between your query and the database match you will see a hyperlink under the title of the subject sequences indicting up to 5 additional identical sequences. To see all these sequences you can click the link “See all Identical Proteins(IPG)”.

Q: What databases can I use with the standalone BLAST+ "-remote" parameter?

Any database available on the webBLAST input form is available for use with the BLAST+ “-remote” option.
To get the correct path to each database, select the database you want from the drop-down list on webBLAST then
click the “Bookmark” button in the upper-right corner of the screen. On the next page, examine the URL and find
the section “DATABASE=<path>” where “<path>” is the name of the database you should use in your BLAST+ command.
For example, the Betacoronavirus Genbank database path is “DATABASE=genomic/Viruses/Betacoronavirus” so
the correct path to the same database with remote BLAST+ would be “-db genomic/Viruses/Betacoronavirus”.

# Troubleshooting[¶](#troubleshooting "Link to this heading")

MESSAGE: No significant similarity found. For reasons why, click here.

The “No significant similarly found” message means that your query did not match any sequences in the database with the
current search parameters. Using the default setting for most BLAST searches, this generally means that your query
is not closely related to sequences in the database. This does not mean there may not be small regions of similarity between
your query and the database. In order to match these regions you may try switching from MegabBLAST to blastn in the case of
nucleotides, or lower the word size and increase the expect value for blastp. However, keep in mind that the more you
change these parameters the more you decrease the specificity of your match.

WARNING: Could not calculate un-gapped Karlin-Altschul parameters due to an invalid query sequence or its t