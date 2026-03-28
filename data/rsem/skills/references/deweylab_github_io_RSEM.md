## RSEM (RNA-Seq by Expectation-Maximization)

---

**Updates**

Feb 14, 2020   RSEM v1.3.3 is online now. Added HISAT2 option (--hisat2-hca) using Human Cell Atlas SMART-Seq2 pipeline parameters. Fixed a bug in RSEM simulator.

Apr 6, 2019   RSEM v1.3.2 is online now. Prevented RSEM from crashing when there is 0 aligned reads. Outputted theta and model files even there is no aligned reads.

Jun 27, 2018   RSEM v1.3.1 is online now. Added `--gff3-genes-as-transcripts` option for `rsem-prepare-reference`. This option will allow RSEM to treat genes as transcripts.

Click [here](updates.html) for full update information.

**Source Code**

* [Latest version](https://github.com/deweylab/RSEM/archive/v1.3.3.tar.gz)* [Version used by RSEM Galaxy Wrapper (RSEM v1.1.17)](https://github.com/deweylab/RSEM/archive/v1.1.17.tar.gz)* [Archive of older versions](https://github.com/deweylab/RSEM/releases)* [RSEM GitHub
        repository](https://github.com/deweylab/RSEM)

**Documentation**

* [README](README.html)* [Tutorial](https://github.com/bli25broad/RSEM_tutorial)

**Authors**

[Bo Li](https://lilab-bcb.github.io/) and [Colin Dewey](https://www.biostat.wisc.edu/~cdewey/) designed the RSEM algorithm. [Bo Li](https://lilab-bcb.github.io/) implemented the RSEM software. [Peng Liu](https://biostat.wiscweb.wisc.edu/staff/liu-peng/) contributed the STAR aligner options and pRSEM.

**License**

RSEM is under the [GNU General Public License](http://www.gnu.org/copyleft/gpl.html)

**Prebuilt RSEM Indices (RSEM v1.1.17) for Galaxy Wrapper**

These indices are based on RefSeq containing NM accession numbers only.
That means only curated genes (no experimental, no miRNA, no noncoding).
Only mature RNAs. In addition, 125bp Poly(A) tails are added at the end of each transcript.

[Mouse Indices](http://deweylab.biostat.wisc.edu/rsem/mouse_refseq_NMonly_125bpPolyATail_extractedFromMouseGenome_mm9.tar.gz), extracted from mouse genome mm9

[Human Indices](http://deweylab.biostat.wisc.edu/rsem/human_refseq_NMonly_125bpPolyATail_extractedFromHumanGenome_hg18.tar.gz), extracted from human genome hg18

**Reference annotations and Simulation Data used in the paper**

[RefSeq and Ensembl annotation GTF files used in the paper](http://deweylab.biostat.wisc.edu/rsem/reference_gtfs.tar.gz)

[Simulation Data using Refseq set as reference](http://deweylab.biostat.wisc.edu/rsem/simulation_data.tar.gz)

[Simulation Data using Ensembl set as reference](http://deweylab.biostat.wisc.edu/rsem/simulation_data_ensembl.tar.gz)

**Google Users and Announce Groups**

|  |
| --- |
| ![Google Groups](groups_logo_sm.gif) |
| **Subscribe to RSEM Announce** |
|  |
| --- |
| Email: |
| [Visit this group](http://groups.google.com/group/rsem-announce) |

|  |
| --- |
| ![Google Groups](groups_logo_sm.gif) |
| **Subscribe to RSEM Users** |
|  |
| --- |
| Email: |
| [Visit this group](http://groups.google.com/group/rsem-users) |

---

(last modified on Feb 14, 2020)