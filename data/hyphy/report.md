# hyphy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hyphy_absrel | PASS |  |
| hyphy_bgm | PASS |  |
| hyphy_busted | PASS |  |
| hyphy_contrast-fel | PASS |  |
| hyphy_fade | PASS |  |
| hyphy_fel | PASS |  |
| hyphy_fubar | PASS |  |
| hyphy_gard | PASS | needs ENV=TOLERATE_NUMERICAL_ERRORS=1; set through the env input, otherwise it stops with an internal numerical error |
| hyphy_mcc | PASS | synthetic data: real alignment with clade labels (Clade1, Clade2) added by hand to a real tree, as the tool requires |
| hyphy_mclk | PASS |  |
| hyphy_meme | PASS |  |
| hyphy_mgvsgy | PASS |  |
| hyphy_molerate | PASS |  |
| hyphy_mss | PASS | synthetic data: NEXUS alignment files assembled by hand from real galaxy test sequences and trees, because the tool needs the tree inside each alignment file |
| hyphy_mss-ga | PASS | synthetic data: NEXUS alignment files assembled by hand from real galaxy test sequences and trees, because the tool needs the tree inside each alignment file |
| hyphy_mss-ga-processor | PASS |  |
| hyphy_mt | Failed | tool bug: hyphy mt crashes with a glibc heap corruption error (exit 139) after the first model on every input tried |
| hyphy_prime | PASS |  |
| hyphy_relax | PASS | single-alignment mode only; the multiple-files mode was not tested |
| hyphy_slac | PASS |  |

## hyphy_meme

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Total Downloads**: 866.2K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/veg/hyphy
- **Stars**: N/A
### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

pvalue
	The p-value threshold to use when testing for selection
	default value: 0.1

resample
	[Advanced setting, will result in MUCH SLOWER run time] Perform parametric bootstrap resampling to derive site-level null LRT distributions up to this many replicates per site. Recommended use for small to medium (<30 sequences) datasets
	default value: 0

rates
	The number omega rate classes to include in the model [2-4]
	default value: meme.nrate_classes [computed at run time]

multiple-hits
	Include support for multiple nucleotide substitutions
	default value: None

site-multihit
	Estimate multiple hit rates for each site
	default value: Estimate

impute-states
	Use site-level model fits to impute likely character states for each sequence
	default value: No

precision
	Optimization precision settings for preliminary fits
	default value: standard

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'MEME.json')
	default value: meme.codon_data_info[terms.json.json] [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes

full-model
	Perform branch length re-optimization under the full codon model
	default value: Yes

limit-to-sites
	Only analyze sites whose 1-based indices match the following list (null to skip)
	default value: null

save-lf-for-sites
	For sites whose 1-based indices match the following list, write out likelihood function snapshots (null to skip)
	default value: null
```

## hyphy_mss

### Tool Description
Performs a joint MSS model fit to several genes jointly.

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Analysis Description
--------------------
mss_joint_fitter : Performs a joint MSS model fit to several genes
jointly.

- __Requirements__: A collection of coding alignments with trees in the corresponding
alignment files 

- __Citation__: TBD

- __Written by__: Sergei L Kosakovsky Pond

- __Contact Information__: spond@temple.edu

- __Analysis Version__: 0.0.1

List of files to include in this analysis (`/`) 
Enter paths to files (blank line to end entry)
----------------------------------------------
* File 1 [relative path /usr/local/share/hyphy/TemplateBatchFiles/]:Error:
Could not read all the parameters requested. in call to fscanf(stdin,"String",io.get_a_list_of_files.current_path);

Function call stack
1 :  fscanf(stdin,"String",io.get_a_list_of_files.current_path);
-------
2 :  mss_selector.file_list=io.get_a_list_of_files(io.PromptUserForFilePathRead("List of files to include in this analysis"));
-------
```

## hyphy_mss-ga

### Tool Description
Genetic Algorithms for Recombination Detection. Implements a heuristic approach to screening alignments of sequences for recombination, by using the CHC genetic algorithm to search for phylogenetic incongruence among different partitions of the data. The number of partitions is determined using a step-down procedure, while the placement of breakpoints is searched for with the GA. The best fitting model (based on c-AIC) is returned; and additional post-hoc tests run to distinguish topological incongruence from rate-variation. v0.2 adds and spooling results to JSON after each breakpoint search conclusion

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Analysis Description
--------------------
mss_selector : Genetic Algorithms for Recombination Detection.
Implements a heuristic approach to screening alignments of sequences for
recombination, by using the CHC genetic algorithm to search for
phylogenetic incongruence among different partitions of the data. The
number of partitions is determined using a step-up procedure, while the
placement of breakpoints is searched for with the GA. The best fitting
model (based on c-AIC) is returned; and additional post-hoc tests run to
distinguish topological incongruence from rate-variation. v0.2 adds and
spooling results to JSON after each breakpoint search conclusion

- __Requirements__: A collection of coding alignments with trees in the corresponding
alignment files 

- __Citation__: **Perform a Genetic Algorithm search model selection for an MSS model on
a collection of alignments

- __Written by__: Sergei L Kosakovsky Pond

- __Contact Information__: spond@temple.edu

- __Analysis Version__: 0.0.1

List of files to include in this analysis (`/`) 
Enter paths to files (blank line to end entry)
----------------------------------------------
* File 1 [relative path /usr/local/share/hyphy/TemplateBatchFiles/GA/]:Error:
Could not read all the parameters requested. in call to fscanf(stdin,"String",io.get_a_list_of_files.current_path);

Function call stack
1 :  fscanf(stdin,"String",io.get_a_list_of_files.current_path);
-------
2 :  mss_selector.file_list=io.get_a_list_of_files(io.PromptUserForFilePathRead("List of files to include in this analysis"));
-------
```

## hyphy_mss-ga-processor

### Tool Description
Read an alignment (and, optionally, a tree) remove duplicate sequences, and prune the tree accordingly.

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Analysis Description
--------------------
 Read an alignment (and, optionally, a tree) remove duplicate sequences,
and prune the tree accordingly. 

- __Additional information__: https://github.com/veg/hyphy/blob/develop/res/TemplateBatchFiles/GA/README.md

- __Requirements__: A codon genetic algorithm output .JSON file

- __Citation__: TBD

- __Written by__: Sergei L Kosakovsky Pond

- __Contact Information__: spond@temple.edu

- __Analysis Version__: 0.1

Codon GA output .JSON file (`/`) Error:
'file_path' did not evaluate to a String in call to fscanf(file_path,"RawREWIND, ",test, );

Function call stack
1 :  [namespace = iWgezqgs] fscanf(file_path,"RawREWIND, ",test, );
-------
2 :  mss.json=io.ParseJSON(io.PromptUserForFilePathRead("Codon GA output .JSON file"));
-------
```

## hyphy_mcc

### Tool Description
Test for

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
+--------+
			|Test for|
			+--------+

	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):
	(1):[Mean branch length] Compare mean branch lengths between two or more non-nested clades.
	(2):[Mean pairwise divergence] Compare mean within-clade pairwise divergence between two or more non-nested clades.

Please choose an option (or press q to cancel selection):Error:
Too many invalid inputs (last one was '') in call to ChoiceList(testType, "Test for", 1, SKIP_NONE, {{Mean branch length, Compare mean branch lengths between two or more non-nested clades.}, {Mean pairwise divergence, Compare mean within-clade pairwise divergence between two or more non-nested clades.}});

Function call stack
1 :  ChoiceList(testType, "Test for", 1, SKIP_NONE, {{Mean branch length, Compare mean branch lengths between two or more non-nested clades.}, {Mean pairwise divergence, Compare mean within-clade pairwise divergence between two or more non-nested clades.}});
-------
```

## hyphy_mclk

### Tool Description
RUNNING MOLECULAR CLOCK ANALYSIS

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
---- RUNNING MOLECULAR CLOCK ANALYSIS ---- 

			+---------+
			|Data type|
			+---------+

	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):
	(1):[Nucleotide/Protein] Nucleotide or amino-acid (protein).
	(2):[Codon] Codon (several available genetic codes).

Please choose an option (or press q to cancel selection):Error:
Too many invalid inputs (last one was '') in call to ChoiceList(dataType, "Data type", 1, SKIP_NONE, {{Nucleotide/Protein, Nucleotide or amino-acid (protein).}, {Codon, Codon (several available genetic codes).}});

Function call stack
1 :  ChoiceList(dataType, "Data type", 1, SKIP_NONE, {{Nucleotide/Protein, Nucleotide or amino-acid (protein).}, {Codon, Codon (several available genetic codes).}});
-------
```

## hyphy_mgvsgy

### Tool Description
Choose Genetic Code

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
+-------------------+
			|Choose Genetic Code|
			+-------------------+

	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):
	(1):[Universal] Universal code. (Genebank transl_table=1).
	(2):[Vertebrate-mtDNA] Vertebrate mitochondrial DNA code. (Genebank transl_table=2).
	(3):[Yeast-mtDNA] Yeast mitochondrial DNA code. (Genebank transl_table=3).
	(4):[Mold-Protozoan-mtDNA] Mold, Protozoan and Coelenterate mitochondrial DNA and the Mycloplasma/Spiroplasma code. (Genebank transl_table=4).
	(5):[Invertebrate-mtDNA] Invertebrate mitochondrial DNA code. (Genebank transl_table=5).
	(6):[Ciliate-Nuclear] Ciliate, Dasycladacean and Hexamita Nuclear code. (Genebank transl_table=6).
	(7):[Echinoderm-mtDNA] Echinoderm mitochondrial DNA code. (Genebank transl_table=9).
	(8):[Euplotid-Nuclear] Euplotid Nuclear code. (Genebank transl_table=10).
	(9):[Alt-Yeast-Nuclear] Alternative Yeast Nuclear code. (Genebank transl_table=12).
	(10):[Ascidian-mtDNA] Ascidian mitochondrial DNA code. (Genebank transl_table=13).
	(11):[Flatworm-mtDNA] Flatworm mitochondrial DNA code. (Genebank transl_table=14).
	(12):[Blepharisma-Nuclear] Blepharisma Nuclear code. (Genebank transl_table=15).
	(13):[Chlorophycean-mtDNA] Chlorophycean Mitochondrial Code (transl_table=16).
	(14):[Trematode-mtDNA] Trematode Mitochondrial Code (transl_table=21).
	(15):[Scenedesmus-obliquus-mtDNA] Scenedesmus obliquus mitochondrial Code (transl_table=22).
	(16):[Thraustochytrium-mtDNA] Thraustochytrium Mitochondrial Code (transl_table=23).
	(17):[Pterobranchia-mtDNA] Pterobranchia Mitochondrial Code (transl_table=24).
	(18):[SR1-and-Gracilibacteria] Candidate Division SR1 and Gracilibacteria Code (transl_table=25).
	(19):[Pachysolen-Nuclear] Pachysolen tannophilus Nuclear Code (transl_table=26).
	(20):[Mesodinium-Nuclear] Mesodinium Nuclear Code (transl_table=29)
	(21):[Peritrich-Nuclear] Peritrich Nuclear Code (transl_table=30)
	(22):[Cephalodiscidae-mtDNA] Cephalodiscidae Mitochondrial UAA-Tyr Code (transl_table=33)

Please choose an option (or press q to cancel selection):Error:
Too many invalid inputs (last one was '') in call to ChoiceList(modelType, "Choose Genetic Code", 1, SKIP_NONE, _geneticCodeOptionMatrix);

Function call stack
1 :  ChoiceList(modelType, "Choose Genetic Code", 1, SKIP_NONE, _geneticCodeOptionMatrix);
-------
```

## hyphy_mt

### Tool Description
RUNNING MODEL TESTING ANALYSIS Based on the program ModelTest

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
+--------------------------------+
| RUNNING MODEL TESTING ANALYSIS |
| Based on the program ModelTest |
|              by                |
|        David  Posada           |
|             and                |
|        Keith Crandall          |
|                                |
|    If you use this analysis,   |
| be sure to cite the original   |
| reference, which can be found  |
| in Bioinformatics (1998)       |
| Vol 14, ppg. 817-818           |
+--------------------------------+

Testing space includes 56 models

Please specify a nucleotide data file: (`/`)
```

## hyphy_molerate

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

type
	The type of data to perform screening on
	default value: protein

alignment [required]
	A protein multiple sequence alignment in one of the formats supported by HyPhy (single partition)

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'MG94.json')
	default value: rer.alignment[terms.data.file]+"molerate.json" [computed at run time]

tree [required]
	A phylogenetic tree with branch lengths

branches [required]
	Designated lineages to test

labeling-strategy
	Labeling strategy for internal nodes
	default value: all-descendants

model
	The substitution model to use
	default value: WAG

rv
	Site to site rate variation
	default value: None

rate-classes
	How many site rate classes to use
	default value: 4

full-model
	Fit the full unconstrained model
	default value: Yes

branch-level-analysis
	Perform test clade branch-level testing
	default value: No
```

## hyphy_fel

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test. Options: 'All' (default), 'Internal', 'Leaves', 'Unlabeled', 'fg' (labeled branches), comma-separated branch names (e.g. 'Node1,Node2'), or regex patterns (e.g. '/^human/i')
	default value: All

srv
	Include synonymous rate variation in the model
	default value: Yes

multiple-hits
	Include support for multiple nucleotide substitutions
	default value: None

pvalue
	The p-value threshold to use when testing for selection
	default value: 0.1

ci
	Compute profile likelihood confidence intervals for each variable site
	default value: No

limit-to-sites
	Only analyze sites whose 1-based indices match the following list (null to skip)
	default value: null

save-lf-for-sites
	For sites whose 1-based indices match the following list, write out likelihood function snapshots (null to skip)
	default value: null

resample
	[Advanced setting, will result in MUCH SLOWER run time] Perform parametric bootstrap resampling to derive site-level null LRT distributions up to this many replicates per site. Recommended use for small to medium (<30 sequences) datasets
	default value: 0

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'FEL.json')
	default value: fel.codon_data_info[terms.json.json] [computed at run time]

site-multihit
	Estimate multiple hit rates for each site
	default value: Estimate

precision
	Optimization precision settings for preliminary fits
	default value: standard

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes

full-model
	Perform branch length re-optimization under the full codon model
	default value: Yes
```

## hyphy_slac

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

samples
	number of samples to assess ancestral reconstruction uncertainty
	default value: 100

pvalue
	The p-value threshold to use when testing for selection
	default value: 0.1

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'SLAC.json')
	default value: slac.codon_data_info[terms.json.json] [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes
```

## hyphy_fubar

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

cache
	Save FUBAR cache to [default is alignment+.FUBAR.cache]
	default value: fubar.path.base+".FUBAR.cache" [computed at run time]

output
	Save FUBAR results (JSON) to [default is alignment+.FUBAR.json]
	default value: fubar.codon_data_info[terms.data.file]+".FUBAR.json" [computed at run time]

grid
	The number of grid points
	default value: 20

method
	Inference method to use
	default value: `terms.fubar.methods.VB0`

chains
	How many MCMC chains to run
	default value: fubar.run_settings["chains"] [computed at run time]

chain-length
	MCMC chain length
	default value: fubar.run_settings["chain-length"] [computed at run time]

burn-in
	MCMC chain burn in
	default value: fubar.run_settings["chain-length"]$2 [computed at run time]

samples
	MCMC samples to draw
	default value: fubar.run_settings["samples"] [computed at run time]

concentration_parameter
	The concentration parameter of the Dirichlet prior
	default value: fubar.run_settings["concentration"] [computed at run time]

non-zero
	Enforce non-zero synonymous rates on the grid to enable dN/dS calculations
	default value: No

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes
```

## hyphy_busted

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

srv
	Include synonymous rate variation in the model
	default value: Yes

rates
	The number omega rate classes to include in the model [1-10, default 3]
	default value: busted.rate_classes [computed at run time]

multiple-hits
	Include support for multiple nucleotide substitutions
	default value: None

mss
	Include support for multiple synonymous rate class substitutions
	default value: No

mss-type
	How to partition synonymous codons into classes
	default value: File

mss-reference-rate
	Normalize relative to these rates
	default value: synonymous

mss-classes [required]
	How many codon rate classes

mss-file [required]
	File defining the model partition

mss-neutral [required]
	Designation for the neutral substitution rate

mss-file [required]
	File defining the model partition

mss-neutral [required]
	Designation for the neutral substitution rate

mss-file [required]
	File defining empirical rates for each pair of codons

syn-rates
	The number alpha rate classes to include in the model [1-10, default 3]
	default value: busted.synonymous_rate_classes [computed at run time]

error-sink
	Include a rate class to capture misalignment artifacts
	default value: No

error-sink-bound
	[Advanced setting] Set the lower bound for error-class dN/dS
	default value: 100

error-sink-weight
	[Advanced setting] Set the maximum weight for error-class dN/dS
	default value: 0.01

grid-size
	The number of points in the initial distributional guess for likelihood fitting
	default value: 250 [computed at run time]

starting-points
	The number of initial random guesses to seed rate values optimization
	default value: 1 [computed at run time]

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'BUSTED.json')
	default value: busted.codon_data_info[terms.json.json] [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes

save-fit
	Save BUSTED model fit to this file (default is not to save)
	default value: /dev/null
```

## hyphy_absrel

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

blb
	[Advanced option] Bag of little bootstrap alignment resampling rate
	default value: 1.0 [computed at run time]

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

multiple-hits
	Include support for multiple nucleotide substitutions
	default value: None

srv
	Include synonymous rate variation
	default value: No

syn-rates
	The number alpha rate classes to include in the model [1-10, default 3]
	default value: absrel.synonymous_rate_classes [computed at run time]

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'ABSREL.json')
	default value: absrel.codon_data_info[terms.json.json] [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes

save-fit
	Save full adaptive aBSREL model fit to this file (default is not to save)
	default value: /dev/null
```

## hyphy_relax

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

multiple-files
	Use multiple files as input
	default value: No

filelist [required]
	A line list of file paths for the alignments to include in this analysis

code
	Which genetic code should be used
	default value: Universal

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

mode
	Run mode
	default value: Classic mode
	applies to: Group test mode

test [conditionally required]
	Branches to use as the test set
	applies to: Choose the set of branches to use as the _test_ set

reference [conditionally required]
	Branches to use as the reference set
	applies to: Choose the set of branches to use as the _reference_ set

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'RELAX.json')
	default value: relax.default_output [computed at run time]

grid-size
	The number of points in the initial distributional guess for likelihood fitting
	default value: 250 [computed at run time]

starting-points
	The number of initial random guesses to seed rate values optimization
	default value: 1 [computed at run time]

multiple-hits
	Include support for multiple nucleotide substitutions
	default value: None

reference-group [required]
	Branches to use as the reference group

rates
	The number omega rate classes to include in the model [2-10, default 3]
	default value: relax.rate_classes [computed at run time]

models
	Which version of the test to run (All or Minimal)
	default value: All

srv
	Include synonymous rate variation
	default value: No

syn-rates
	The number alpha rate classes to include in the model [1-10, default 3]
	default value: relax.synonymous_rate_classes [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes

save-fit
	Save RELAX alternative model fit to this file (default is not to save)
	default value: /dev/null
```

## hyphy_gard

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

type
	The type of data to perform screening on
	default value: nucleotide

code
	Genetic code to use (for codon alignments)
	default value: Universal
	applies to: Choose Genetic Code

alignment [required]
	Sequence alignment to screen for recombination

model
	The substitution model to use
	default value: JTT

rv
	Site to site rate variation
	default value: None

max-breakpoints
	Maximum number of breakpoints to consider
	default value: 10000

rate-classes
	How many site rate classes to use
	default value: 4

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'GARD.json')
	default value: gard.defaultJsonFilePath [computed at run time]

mode
	Run mode (Normal or Faster)
	default value: Normal

output-lf
	Write the best fitting HyPhy analysis snapshot to (default is to save to the same path as the alignment file + 'best-gard')
	default value: gard.defaultFitFilePath [computed at run time]
```

## hyphy_bgm

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

type
	nucleotide, amino-acid or codon
	default value: codon

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

baseline_model
	Which amino acid substitution model should be used
	default value: LG

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'FEL.json')
	default value: bgm.alignment_info[terms.json.json] [computed at run time]

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

steps
	The number of MCMC steps to sample
	default value: 100000 [computed at run time]

burn-in
	The number of MCMC steps to discard as burn-in
	default value: 10000 [computed at run time]

samples
	The number of steps to extract from the chain sample
	default value: 100 [computed at run time]

max-parents
	The maximum number of parents allowed per node
	default value: 1 [computed at run time]

min-subs
	The minimum number of substitutions per site to include it in the analysis
	default value: 1 [computed at run time]
```

## hyphy_fade

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

alignment [required]
	Protein alignment to screen for directional selection

output
	Save FADE results (JSON) to [default is alignment+.FADE.json]
	default value: fade.alignment_info[terms.data.file]+".FADE.json" [computed at run time]

cache
	Save FADE cache to [default is alignment+.FADE.cache]
	default value: fade.path.base+".FADE.cache" [computed at run time]

tree [conditionally required]
	A rooted phylogenetic tree
	applies to: Please select a tree file for the data:

branches
	The branches to test
	default value: All

grid
	The number of grid points
	default value: 20

model
	The substitution model to use
	default value: GTR

method
	Inference method to use
	default value: `terms.fade.methods.VB0`

chains
	How many MCMC chains to run
	default value: fade.run_settings["chains"] [computed at run time]

chain-length
	MCMC chain length
	default value: fade.run_settings["chain-length"] [computed at run time]

burn-in
	MCMC chain burn in
	default value: fade.run_settings["chain-length"]$2 [computed at run time]

samples
	MCMC samples to draw
	default value: fade.run_settings["samples"] [computed at run time]

concentration_parameter
	The concentration parameter of the Dirichlet prior
	default value: fade.run_settings["concentration"] [computed at run time]
```

## hyphy_contrast-fel

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branch-set [required]
	The set of branches to use for testing

srv
	Include synonymous rate variation in the model
	default value: Yes

permutations
	Perform permutation significance tests
	default value: Yes

p-value
	Significance value for site-tests
	default value: 0.05

q-value
	Significance value for FDR reporting
	default value: 0.20

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'FEL.json')
	default value: fel.codon_data_info[terms.json.json] [computed at run time]

limit-to-sites
	Only analyze sites whose 1-based indices match the following list (null to skip)
	default value: null

save-lf-for-sites
	For sites whose 1-based indices match the following list, write out likelihood function snapshots (null to skip)
	default value: null

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes
```

## hyphy_prime

### Tool Description
Available analysis command line options

### Metadata
- **Docker Image**: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
- **Homepage**: http://hyphy.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/hyphy/overview
- **Validation**: PASS

### Original Help Text
```text
Available analysis command line options
---------------------------------------
Use --option VALUE syntax to invoke
If a [reqired] option is not provided on the command line, the analysis will prompt for its value
[conditionally required] options may or not be required based on the values of other options

code
	Which genetic code should be used
	default value: Universal

alignment [required]
	An in-frame codon alignment in one of the formats supported by HyPhy

tree [conditionally required]
	A phylogenetic tree (optionally annotated with {})
	applies to: Please select a tree file for the data:

branches
	Branches to test
	default value: All

pvalue
	The p-value threshold to use when testing for selection
	default value: 0.1

impute-states
	Use site-level model fits to impute likely character states for each sequence
	default value: No

property-set
	How to partition synonymous codons into classes
	default value: 3PROP

property-file [required]
	JSON file which defines amino-acid properties

output
	Write the resulting JSON to this file (default is to save to the same path as the alignment file + 'prime.json')
	default value: prime.codon_data_info[terms.json.json] [computed at run time]

intermediate-fits
	Use/save parameter estimates from 'initial-guess' model fits to a JSON file (default is not to save)
	default value: /dev/null

kill-zero-lengths
	Automatically delete internal zero-length branches for computational efficiency (will not affect results otherwise)
	default value: Yes
```

## Metadata
- **Skill**: generated
