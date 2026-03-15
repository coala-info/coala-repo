[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

[close ]

Download contents of the "Potential Regulatory Links" table as a
tab-separated values (TSV) file suitable for use with programs
such as Excel or for uploading to programs for gene enrichment
analysis (e.g., [GOrilla](http://cbl-gorilla.cs.technion.ac.il))
First choose the columns of information you wish to download, then
choose how you want the links to be filtered and sorted, using the
check boxes and sorting menu on the right. Then click on this
button and the links will be downloaded in a file named "tgene\_links.tsv"
on your computer.

[close ]

List only potential regulatory links that meet the selected filter criteria below.
Select the desired filters below, then click the **Update Filter & Sort** button located
below.

The first two filters ("Links/Genes/TSSes/RE Loci" and "Top" are applied **after**
sorting the links. All other filters are applied **before** sorting.

The first filter affects the overall content of the report as follows:

| Value | Resulting Report |
| --- | --- |
| Links | Show all links (subject to the other Filters and the Sort). |
| Genes | Show the top TSS for each Gene (subject to the other Filters and the Sort). |
| TSSes | Show the top RE Locus for each TSS (subject to the other Filters and the Sort). |
| RE Loci | Show the top TSS for each RE Locus (subject to the other Filters and the Sort). |

The second filter ("Top") limits the output to at most 2000 top links.

To filter on "Gene\_ID", "Gene\_Name", "TSS\_ID", "TSS\_Locus" or "RE\_Locus",
you can enter any Javascript regular
expression pattern. See [here](http://www.w3schools.com/jsref/jsref_obj_regexp.asp)
for documentation on Javascript regular expression patterns.

[close ]

Sort the potential regulatory links according to the criterion
selected in the drop-down menu below.

Sorting is applied after filtering except for the first two filters.

If a tissue panel was provided, ties in the sorting field are resolved
by sorting on the following fields, in order: CnD\_P\_Value, Correlation\_P\_Value,
TSS\_ID, RE\_Locus, Histone.

If no tissue panel was provided, ties in the sorting field are resolved
by sorting on the following fields, in order: Distance\_P\_Value,
TSS\_ID, RE\_Locus, Histone.

[close ]

![T-Gene Logo](data:image/png;base64...)

# T-Gene

### Prediction of Target Genes

For further information on how to interpret these results please access
<https://meme-suite.org/meme/doc/tgene-output-format.html>.
To get a copy of the MEME software please access
<https://meme-suite.org>.

|  |  |  |  |
| --- | --- | --- | --- |
| [Potential Regulatory Links](#regulatory_links_sec) | [Program information](#info_sec) | [Links in TSV Format](links.tsv) | |

# Javascript is required to view these results!

# Your browser does not support canvas!

## Results

#### Potential Regulatory Links ( *p*-value ≤ )

| Gene ID | Gene Name | TSS ID | TSS Locus | Strand | Maximum Expression | RE Locus | Maximum Histone Level | Distance | CL | CT | Histone | Correlation | Corr. Sign | Corr. *p*-value (unadjusted) | Distance p-value (unadjusted) | CnD *p*-value (unadjusted) | q-value |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

#### Filter & Sort

##### Sort

##### Filters

Links

Genes

TSSes

RE Loci

[x]
Top

[ ]
Gene ID matches

[ ]
Gene Name matches

[ ]
TSS ID matches

[ ]
TSS Locus matches

[ ]
RE Locus matches

[ ]
Maximum Expression ≥

[ ]
Maximum Histone Level ≥

[ ]

≤|Distance|≤

[ ]

≤ Distance ≤

[ ]
CL (Closest Locus) matches

[ ]
CT (Closest TSS) matches

[ ]
Histone matches

[ ]
Correlation Sign

[ ]
Correlation *p*-value ≤

[ ]
Distance *p*-value ≤

[ ]
CnD *p*-value ≤

[ ]
q-value ≤

#### Columns to display

[x]
Show Gene ID

[x]
Show Gene Name

[x]
Show TSS ID

[x]
Show TSS Locus

[x]
Show Strand

[x]
Show Maximum Expression

[x]
Show Maximum Histone Level

[x]
Show RE Locus

[x]
Show Distance

[x]
Show CL (Closest Locus)

[x]
Show CT (Closest TSS)

[x]
Show Histone

[x]
Show Correlation

[x]
Show Correlation Sign

[x]
Show Correlation *p*-value

[x]
Show Distance *p*-value

[x]
Show CnD *p*-value

[x]
Show q-value

## Input Files

#### Locus File

#### Annotation File

#### Other Settings

|  |  |
| --- | --- |
| Transcript Types |  |
| Maximum Link Distances |  |
| Maximum *p*-value |  |
| Tissues |  |
| Histone Root |  |
| Histone |  |
| RNA Source |  |
| Expression Root |  |
| Use Gene IDs |  |
| Low Expression Correlation Adjustment Threshold |  |
| Include CL (Closest Locus) |  |
| Include CT (Closest TSS) |  |
| Add noise to zero expression and histone values |  |
| Random number seed |  |
| Maximum Number of Permutations |  |
| Noise Fraction |  |

##### T-Gene version

(Release date: )

##### Command line summary