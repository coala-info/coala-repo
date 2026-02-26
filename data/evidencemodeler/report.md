# evidencemodeler CWL Generation Report

## evidencemodeler_EVidenceModeler

### Tool Description
EvidenceModeler (EVM) automates the process of combining gene predictions and protein/transcript alignments into a single set of high-quality gene models.

### Metadata
- **Docker Image**: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
- **Homepage**: https://github.com/EVidenceModeler/EVidenceModeler
- **Package**: https://anaconda.org/channels/bioconda/packages/evidencemodeler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/evidencemodeler/overview
- **Total Downloads**: 30.2K
- **Last updated**: 2025-05-29
- **GitHub**: https://github.com/EVidenceModeler/EVidenceModeler
- **Stars**: N/A
### Original Help Text
```text
################# Evidence Modeler ##############################
#
#  parameters:
#
#  Required:
# 
#  --sample_id <str>           sample_id (for naming outputs)
#  --genome <str>              genome sequence in fasta format
#  --weights <str>             weights for evidence types file. See documentation for formatting.
#  --gene_predictions <str>    gene predictions gff3 file
#
#  # partitioning info (required too) 
#  --segmentSize <str>          * :length of a single sequence for running EVM
#  --overlapSize  <str>         * :length of sequence overlap between segmented sequences
#
#
#  Optional but recommended:
#  --protein_alignments <str>         protein alignments gff3 file
#  --transcript_alignments <str>      transcript alignments gff3 file
#
#  Optional and miscellaneous
#
#  --repeats <str>              gff3 file with repeats masked from genome file
#
#  
#  --terminalExons <str>        supplementary file of additional terminal exons to consider (from PASA long-orfs)
#
#  --stop_codons <str>            list of stop codons (default: TAA,TGA,TAG)
#                                 *for Tetrahymena, set --stop_codons TGA
#
#  --min_intron_length <int>      minimum length for an intron (default 20 bp)
#  --exec_dir <str>               directory that EVM cd's to before running.
#
#  --CPU <int>                   number of parallel computes (default: 4)
#
#  --search_long_introns  <int>  when set, reexamines long introns (can find nested genes, but also can result in FPs) (default: 0 (off))
#
#
#  --re_search_intergenic <int>  when set, reexamines intergenic regions of minimum length (can add FPs) (default: 0  (off))
#  --terminal_intergenic_re_search <int>   reexamines genomic regions outside of the span of all predicted genes (default: 10000)
#
# flags:
#
#  --forwardStrandOnly   runs only on the forward strand
#  --reverseStrandOnly   runs only on the reverse strand
#
#  -S                    verbose flag
#  --debug               debug mode, writes lots of extra files.
#  --report_ELM          report the eliminated EVM preds too.
#
#  --version             report version (EVidenceModeler-v2.1.0) and exit.
#
#################################################################################################################################
```

