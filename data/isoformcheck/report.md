# isoformcheck CWL Generation Report

## isoformcheck_IsoformCheck

### Tool Description
Protein isoform analysis from de novo genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Total Downloads**: 55
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/maickrau/IsoformCheck
- **Stars**: N/A
### Original Help Text
```text
usage: IsoformCheck [-h] [--version]
                    {initialize,liftover,addsample,addsamples,listsamples,addgroup,removegroup,listgroups,rename,stats,validate,contingencytable,chisquare,exportallelesets,exportisoforms,comparesamples}
                    ...

Protein isoform analysis from de novo genome assemblies.

positional arguments:
  {initialize,liftover,addsample,addsamples,listsamples,addgroup,removegroup,listgroups,rename,stats,validate,contingencytable,chisquare,exportallelesets,exportisoforms,comparesamples}

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```


## isoformcheck_liftoff

### Tool Description
Lift features from one genome assembly to another

### Metadata
- **Docker Image**: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/maickrau/IsoformCheck
- **Package**: https://anaconda.org/channels/bioconda/packages/isoformcheck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: liftoff [-h] (-g GFF | -db DB) [-o FILE] [-u FILE] [-exclude_partial]
               [-dir DIR] [-mm2_options =STR] [-a A] [-s S] [-d D] [-flank F]
               [-V] [-p P] [-m PATH] [-f TYPES] [-infer_genes]
               [-infer_transcripts] [-chroms TXT] [-unplaced TXT] [-copies]
               [-sc SC] [-overlap O] [-mismatch M] [-gap_open GO]
               [-gap_extend GE] [-polish] [-cds]
               target reference

Lift features from one genome assembly to another

Required input (sequences):
  target              target fasta genome to lift genes to
  reference           reference fasta genome to lift genes from

Required input (annotation):
  -g GFF              annotation file to lift over in GFF or GTF format
  -db DB              name of feature database; if not specified, the -g
                      argument must be provided and a database will be built
                      automatically

Output:
  -o FILE             write output to FILE in same format as input; by
                      default, output is written to terminal (stdout)
  -u FILE             write unmapped features to FILE; default is
                      "unmapped_features.txt"
  -exclude_partial    write partial mappings below -s and -a threshold to
                      unmapped_features.txt; if true partial/low sequence
                      identity mappings will be included in the gff file with
                      partial_mapping=True, low_identity=True in comments
  -dir DIR            name of directory to save intermediate fasta and SAM
                      files; default is "intermediate_files"

Alignments:
  -mm2_options =STR   space delimited minimap2 parameters. By default ="-a
                      --end-bonus 5 --eqx -N 50 -p 0.5"
  -a A                designate a feature mapped only if it aligns with
                      coverage ≥A; by default A=0.5
  -s S                designate a feature mapped only if its child features
                      (usually exons/CDS) align with sequence identity ≥S; by
                      default S=0.5
  -d D                distance scaling factor; alignment nodes separated by
                      more than a factor of D in the target genome will not be
                      connected in the graph; by default D=2.0
  -flank F            amount of flanking sequence to align as a fraction
                      [0.0-1.0] of gene length. This can improve gene
                      alignment where gene structure differs between target
                      and reference; by default F=0.0

Miscellaneous settings:
  -h, --help          show this help message and exit
  -V, --version       show program version
  -p P                use p parallel processes to accelerate alignment; by
                      default p=1
  -m PATH             Minimap2 path
  -f TYPES            list of feature types to lift over
  -infer_genes        use if annotation file only includes transcripts,
                      exon/CDS features
  -infer_transcripts  use if annotation file only includes exon/CDS features
                      and does not include transcripts/mRNA
  -chroms TXT         comma seperated file with corresponding chromosomes in
                      the reference,target sequences
  -unplaced TXT       text file with name(s) of unplaced sequences to map
                      genes from after genes from chromosomes in chroms.txt
                      are mapped; default is "unplaced_seq_names.txt"
  -copies             look for extra gene copies in the target genome
  -sc SC              with -copies, minimum sequence identity in exons/CDS for
                      which a gene is considered a copy; must be greater than
                      -s; default is 1.0
  -overlap O          maximum fraction [0.0-1.0] of overlap allowed by 2
                      features; by default O=0.1
  -mismatch M         mismatch penalty in exons when finding best mapping; by
                      default M=2
  -gap_open GO        gap open penalty in exons when finding best mapping; by
                      default GO=2
  -gap_extend GE      gap extend penalty in exons when finding best mapping;
                      by default GE=1
  -polish
  -cds                annotate status of each CDS (partial, missing start,
                      missing stop, inframe stop codon)
```


## Metadata
- **Skill**: generated
