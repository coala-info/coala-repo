alternativeSplicingEvents.hg19

February 11, 2026

alternativeSplicingEvents.hg19_V2.rda

Alternative splicing event annotation for Human (hg19)

Description

Data frame containing alternative splicing events per event type. Each splicing event is characterised
by its chromosome, strand, splice junction coordinates, associated gene and original event identifier
from their source.

The following event types are available:

• Skipped Exon (SE)

• Mutually Exclusive Exon (MXE)

• Alternative First Exon (AFE)

• Alternative Last Exon (ALE)

• Alternative 3’ Splice Site (A3SS)

• Alternative 5’ Splice Site (A5SS)

• Retained Intron (RI)

• Tandem UTR

Alternative splicing events were compiled from the input annotation files used by the splicing quan-
tification tools MISO, VAST-TOOLS, SUPPA and rMATS (see details).

Details

The compiled annotation of human alternative splicing events was based on annotation files used as
input to MISO, VAST-TOOLS, rMATS, and SUPPA.

Annotation files from MISO and VAST-TOOLS are provided in their respective websites (see
"Sources"), whereas SUPPA and rMATS identify alternative splicing events and generate such an-
notation files based on a given isoform-centred transcript annotation in the GTF format.

As such, the transcript annotation file was retrieved from UCSC Table Browser by selecting the
GRCh37/hg19 assembly, "Genes and Gene Predictions" group, "UCSC Genes" track and "known-
Gene"" table for all genome in GTF and TXT formats, so gene identifiers in the GTF file (mislead-
ingly identical to transcript identifiers) could be replaced with proper ones from the TXT version.

1

2

alternativeSplicingEvents.hg19_V2.rda

After obtaining the resulting annotation files, all files were parsed to obtain the identifier, chromo-
some, strand and coordinates of each splicing event per event type. Then, a full outer join was
performed on the annotation of the different programs per event type using dplyr::full_join.

Note that before the outer join, some rMATS coordinates must be incremented by one to be compa-
rable to other annotation files and the "chr" prefix in the chromosome field of some annotation files
also must be removed.

Finally, Ensembl gene symbols (retrieved from UCSC Table Browser) are assigned to alternative
splicing events based on overlapping exon and gene coordinates. Splicing events not assigned to
any genes are marked as "Hypothetical".

For more details, check the make-data.R file.

Source

• MISO: https://miso.readthedocs.io/en/fastmiso/annotation.html

• rMATS: http://rnaseq-mats.sourceforge.net/user_guide.htm

• SUPPA: https://bitbucket.org/regulatorygenomicsupf/suppa

• VAST-TOOLS: http://vastdb.crg.eu/libs/

Transcript annotation files used to generate events from SUPPA and rMATS and annotation with
gene symbols were retrieved from UCSC Table Browser (https://genome.ucsc.edu/cgi-bin/
hgTables).

References

• MISO: Katz Y, Wang ET, Airoldi EM, Burge CB. Analysis and design of RNA sequenc-
ing experiments for identifying isoform regulation. Nature methods. 2010;7(12):1009-1015.
doi:10.1038/nmeth.1528.

• rMATS: Shen S, Park JW, Lu Z, et al. rMATS: Robust and flexible detection of differential al-
ternative splicing from replicate RNA-Seq data. Proceedings of the National Academy of Sci-
ences of the United States of America. 2014;111(51):E5593-E5601. doi:10.1073/pnas.1419161111.

• SUPPA: Alamancos GP, Pagès A, Trincado JL, Bellora N, Eyras E. Leveraging transcript
quantification for fast computation of alternative splicing profiles. RNA. 2015;21(9):1521-
1531. doi:10.1261/rna.051557.115.

• VAST-TOOLS: Irimia M, Weatheritt RJ, Ellis J, et al. A highly conserved program of neu-

ronal microexons is misregulated in autistic brains. Cell. 2014;159(7):1511-1523. doi:10.1016/j.cell.2014.11.035.

Examples

library(AnnotationHub)
hub <- AnnotationHub()

## Load the alternative splicing events for Human (hg19)
events <- query(hub, "alternativeSplicingEvents.hg19_V2")[[1]]

Index

∗ datasets

alternativeSplicingEvents.hg19_V2.rda,

1

alternativeSplicingEvents.hg19_V2.rda,

1

3

