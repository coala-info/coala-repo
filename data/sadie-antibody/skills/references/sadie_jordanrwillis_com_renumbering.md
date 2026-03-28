[ ]
[ ]

[Skip to content](#renumbering-antibody-sequences)

SADIE

Sequence Numbering

Initializing search

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

SADIE

[jwillis0720/sadie](https://github.com/jwillis0720/sadie "Go to repository")

* [SADIE](..)
* [Reference Database](../reference/)
* [ ]

  AIRR Sequence Annotation

  AIRR Sequence Annotation
  + [Annotating](../annotation/)
  + [Advanced Annotation Methods](../advanced_annotation/)
  + [Visualization](../visualization/)
* [ ]

  Sequence Numbering

  [Sequence Numbering](./)

  Table of contents
  + [Single Sequence Annotation](#single-sequence-annotation)
  + [Multiple Sequence Numbering](#multiple-sequence-numbering)
  + [Schemes](#schemes)
  + [Region definitions](#region-definitions)
* [BCR/TCR Objects](../models/)
* [Clustering](../clustering/)
* [Contributing to SADIE](../contribute/)

Table of contents

* [Single Sequence Annotation](#single-sequence-annotation)
* [Multiple Sequence Numbering](#multiple-sequence-numbering)
* [Schemes](#schemes)
* [Region definitions](#region-definitions)

# Renumbering Antibody Sequences[¶](#renumbering-antibody-sequences "Permanent link")

One of the most complex parts of working with antibody sequences is that they have different definitions of numbering. Depending on the scheme, there are different definitions of where the framework and CDR regions are. SADIE provides a simple interface to renumber antibody sequences to a common numbering scheme. We borrow heavily from the Antigen receptor Numbering and Receptor Classification ([ANARCI](https://opig.stats.ox.ac.uk/webapps/sabdab-sabpred/sabpred/anarci/))

---

## Single Sequence Annotation[¶](#single-sequence-annotation "Permanent link")

```
# Use Renumbering module
# import pandas for dataframe handling
import pandas as pd

from sadie.renumbering import Renumbering
from sadie.renumbering.result import NumberingResults

# define a single sequence
vrc26_seq = "QKQLVESGGGVVQPGRSLTLSCAASQFPFSHYGMHWVRQAPGKGLEWVASITNDGTKKYHGESVWDRFRISRDNSKNTLFLQMNSLRAEDTALYFCVRDQREDECEEWWSDYYDFGKELPCRKFRGLGLAGIFDIWGHGTMVIVS"

# wrap in a function so we can use multiprocessing
def run() -> NumberingResults:
    # setup API  object
    renumbering_api = Renumbering(scheme="chothia", region_assign="imgt", run_multiproc=True)

    # run sequence and return airr table with sequence_id and sequence
    numbering_table = renumbering_api.run_single("VRC26.27", vrc26_seq)

    # output object types
    print(numbering_table)

if __name__ == "__main__":
    run()
```

|  | Id | sequence | domain\_no | hmm\_species | chain\_type | e-value | score | seqstart\_index | seqend\_index | identity\_species | v\_gene | v\_identity | j\_gene | j\_identity | Chain | Numbering | Insertion | Numbered\_Sequence | scheme | region\_definition | allowed\_species | allowed\_chains | fwr1\_aa\_gaps | fwr1\_aa\_no\_gaps | cdr1\_aa\_gaps | cdr1\_aa\_no\_gaps | fwr2\_aa\_gaps | fwr2\_aa\_no\_gaps | cdr2\_aa\_gaps | cdr2\_aa\_no\_gaps | fwr3\_aa\_gaps | fwr3\_aa\_no\_gaps | cdr3\_aa\_gaps | cdr3\_aa\_no\_gaps | fwr4\_aa\_gaps | fwr4\_aa\_no\_gaps | leader | follow |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | VRC26.27 | QKQLVESGGGVVQPGRSLTLSCAASQFPFSHYGMHWVRQAPGKGLEWVASITNDGTKKYHGESVWDRFRISRDNSKNTLFLQMNSLRAEDTALYFCVRDQREDECEEWWSDYYDFGKELPCRKFRGLGLAGIFDIWGHGTMVIVS | 0 | human | H | 1.65353e-43 | 134.25 | 0 | 144 | human | IGHV3-30\*03 | 0.8 | IGHJ3\*02 | 0.64 | H | [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 82, 82, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112] | ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'A', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'A', 'B', 'C', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', '', '', '', '', '', '', '', '', '', '', '', ''] | ['Q', 'K', 'Q', 'L', 'V', 'E', 'S', 'G', 'G', 'G', 'V', 'V', 'Q', 'P', 'G', 'R', 'S', 'L', 'T', 'L', 'S', 'C', 'A', 'A', 'S', 'Q', 'F', 'P', 'F', 'S', 'H', 'Y', 'G', 'M', 'H', 'W', 'V', 'R', 'Q', 'A', 'P', 'G', 'K', 'G', 'L', 'E', 'W', 'V', 'A', 'S', 'I', 'T', 'N', 'D', 'G', 'T', 'K', 'K', 'Y', 'H', 'G', 'E', 'S', 'V', 'W', 'D', 'R', 'F', 'R', 'I', 'S', 'R', 'D', 'N', 'S', 'K', 'N', 'T', 'L', 'F', 'L', 'Q', 'M', 'N', 'S', 'L', 'R', 'A', 'E', 'D', 'T', 'A', 'L', 'Y', 'F', 'C', 'V', 'R', 'D', 'Q', 'R', 'E', 'D', 'E', 'C', 'E', 'E', 'W', 'W', 'S', 'D', 'Y', 'Y', 'D', 'F', 'G', 'K', 'E', 'L', 'P', 'C', 'R', 'K', 'F', 'R', 'G', 'L', 'G', 'L', 'A', 'G', 'I', 'F', 'D', 'I', 'W', 'G', 'H', 'G', 'T', 'M', 'V', 'I', 'V', 'S'] | chothia | imgt | human | H,K,L | QKQLVESGGGVVQPGRSLTLSCAAS | QKQLVESGGGVVQPGRSLTLSCAAS | QFPFSHYG | QFPFSHYG | MHWVRQAPGKGLEWVAS | MHWVRQAPGKGLEWVAS | ITNDGTKK | ITNDGTKK | YHGESVWDRFRISRDNSKNTLFLQMNSLRAEDTALYFC | YHGESVWDRFRISRDNSKNTLFLQMNSLRAEDTALYFC | VRDQREDECEEWWSDYYDFGKELPCRKFRGLGLAGIFDI | VRDQREDECEEWWSDYYDFGKELPCRKFRGLGLAGIFDI | WGHGTMVIVS | WGHGTMVIVS |  |  |

The output will contain `<sadie.renumbering.result.NumberingResults'>` object. This object contains the following fields:

| Field | Description |
| --- | --- |
| Id | The sequence ID |
| sequence | sequence |
| domain\_no | not used |
| hmm\_species | the top species found in the HMM |
| chain\_type | the chain type, e.g 'H' or 'L' |
| e-value | The e-value of the alignment |
| score | The score for the alignment |
| seqstart\_index | where in the sequence does the alignment start |
| seqend\_index | where in the sequence does the alignment end |
| identity\_species | what species does the sequence aligns to best |
| v\_gene | The top V gene |
| v\_identity | V gene identity |
| j\_gene | The top J gene in alignment |
| j\_identity | J gene identity |
| Chain | not used |
| Numbering | The numbering of the sequence stored as an array |
| Insertion | The insertions if any stored as an array |
| Numbered\_Sequence | The matched sequence stored as an array |
| scheme | scheme, e.g. "kabat" |
| region\_definition | CDR/FW definition |
| allowed\_species | allowed\_species |
| allowed\_chains | allowed\_chains |
| fwr1\_aa\_gaps | fwr1\_aa\_gaps |
| fwr1\_aa\_no\_gaps | fwr1\_aa\_no\_gaps |
| cdr1\_aa\_gaps | cdr1\_aa\_gaps |
| cdr1\_aa\_no\_gaps | cdr1\_aa\_no\_gaps |
| fwr2\_aa\_gaps | fwr2\_aa\_gaps |
| fwr2\_aa\_no\_gaps | fwr2\_aa\_no\_gaps |
| cdr2\_aa\_gaps | cdr2\_aa\_gaps |
| cdr2\_aa\_no\_gaps | cdr2\_aa\_no\_gaps |
| fwr3\_aa\_gaps | fwr3\_aa\_gaps |
| fwr3\_aa\_no\_gaps | fwr3\_aa\_no\_gaps |
| cdr3\_aa\_gaps | cdr3\_aa\_gaps |
| cdr3\_aa\_no\_gaps | cdr3\_aa\_no\_gaps |
| fwr4\_aa\_gaps | fwr4\_aa\_gaps |
| fwr4\_aa\_no\_gaps | fwr4\_aa\_no\_gaps |
| leader | what sequences come before the alignment |
| follow | what sequences come after the alignment |

The `NumberingResults` is a Pandas DataFrame instance that can be used like one. It also contains an alignment table that looks like the following.

```
# Use Renumbering module
import pandas as pd

from sadie.renumbering import Renumbering

# define a single sequence
vrc26_seq = "QKQLVESGGGVVQPGRSLTLSCAASQFPFSHYGMHWVRQAPGKGLEWVASITNDGTKKYHGESVWDRFRISRDNSKNTLFLQMNSLRAEDTALYFCVRDQREDECEEWWSDYYDFGKELPCRKFRGLGLAGIFDIWGHGTMVIVS"

# We wrap these in a function so we can use multiprocessing
def run() -> pd.DataFrame:
    # setup API  object
    renumbering_api = Renumbering(scheme="chothia", region_assign="imgt", run_multiproc=True)

    # run sequence and return airr table with sequence_id and sequence
    numbering_table = renumbering_api.run_single("VRC26.27", vrc26_seq)

    # get the handy dandy alignment table
    return numbering_table.get_alignment_table()

if __name__ == "__main__":
    print(run())
```

Warning

Multiprocessing must be wrapped in a function at the current time if you set run\_multi=True. It will also work inside a Jupyter notebook cell.

The `get_alignment_table()` method retrieves a handy alignment table of the sequence.

|  | Id | chain\_type | scheme | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 | 34 | 35 | 36 | 37 | 38 | 39 | 40 | 41 | 42 | 43 | 44 | 45 | 46 | 47 | 48 | 49 | 50 | 51 | 52 | 52A | 53 | 54 | 55 | 56 | 57 | 58 | 59 | 60 | 61 | 62 | 63 | 64 | 65 | 66 | 67 | 68 | 69 | 70 | 71 | 72 | 73 | 74 | 75 | 76 | 77 | 78 | 79 | 80 | 81 | 82 | 82A | 82B | 82C | 83 | 84 | 85 | 86 | 87 | 88 | 89 | 90 | 91 | 92 | 93 | 94 | 95 | 96 | 97 | 98 | 99 | 100 | 100A | 100B | 100C | 100D | 100E | 100F | 100G | 100H | 100I | 100J | 100K | 100L | 100M | 100N | 100O | 100P | 100Q | 100R | 100S | 100T | 100U | 100V | 100W | 100X | 100Y | 100Z | 100a | 100b | 100c | 101 | 102 | 103 | 104 | 105 | 106 | 107 | 108 | 109 | 110 | 111 | 112 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | VRC26.27 | H | chothia | Q | K | Q | L | V | E | S | G | G | G | V | V | Q | P | G | R | S | L | T | L | S | C | A | A | S | Q | F | P | F | S | H | Y | G | M | H | W | V | R | Q | A | P | G | K | G | L | E | W | V | A | S | I | T | N | D | G | T | K | K | Y | H | G | E | S | V | W | D | R | F | R | I | S | R | D | N | S | K | N | T | L | F | L | Q | M | N | S | L | R | A | E | D | T | A | L | Y | F | C | V | R | D | Q | R | E | D | E | C | E | E | W | W | S | D | Y | Y | D | F | G | K | E | L | P | C | R | K | F | R | G | L | G | L | A | G | I | F | D | I | W | G | H | G | T | M | V | I | V | S |

## Multiple Sequence Numbering[¶](#multiple-sequence-numbering "Permanent link")

You can also renumber a fasta file.

## Schemes[¶](#schemes "Permanent link")

These are the current numbering schemes we have implemented.

| Scheme | Description |
| --- | --- |
| chothia | [Chothia numbering scheme](https://www.chemogenomix.com/chothia-antibody-numbering) |
| kabat | [Kabat numbering scheme](https://www.chemogenomix.com/kabat-antibody-numbering) |
| imgt | [IMGT numbering scheme](https://www.imgt.org/IMGTScientificChart/Nomenclature/IMGT-FRCDRdefinition.html) |

## Region definitions[¶](#region-definitions "Permanent link")

Given a numbering scheme, we can define CDRS and frameworks with the following definitions.

['imgt', 'kabat', 'chothia', 'abm', 'contact', 'scdr']

| Region Definition | Description |
| --- | --- |
| imgt | IMGT |
| kabat | Kabat |
| chothia | Chothia |
| abm | ABM |
| contact | Contact |
| scdr | SCDR |

The following is a description of each definition taken from [the Martin group](http://www.bioinf.org.uk/abs/info.html)

* The Kabat definition is based on sequence variability and is the most commonly used
* The Chothia definition is based on the location of the structural loop regions - see more detail at the bottom of this section
* The AbM definition is a compromise between the two used by Oxford Molecular's AbM antibody modelling software
* The contact definition has been recently introduced by us and is based on an analysis of the available complex crystal structures. This definition is likely the most useful for people wishing to perform mutagenesis to modify the affinity of an antibody since these residues take part in interactions with antigens. Lists of CDR residues making contact in each antibody with summary data for each CDR
* SCDR is the longest CDR definition for each region. It is used in the industry

For an excellent review of the numbering schemes and region definitions, see this [paper](https://www.frontiersin.org/articles/10.3389/fimmu.2018.02278/full)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)