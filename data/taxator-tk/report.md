# taxator-tk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| taxator-tk_alignments-filter | PASS |  |
| taxator-tk_binner | Not completed | runs on real reads and taxator output, but with the small reference almost all reads are placed at the root (taxon 1), so the binning could not be shown. |
| taxator-tk_fasta-strip-identifier | PASS |  |
| taxator-tk_taxator | PASS |  |
| taxator-tk_taxknife | PASS |  |

## taxator-tk_fasta-strip-identifier

### Tool Description
Strips the identifier from FASTA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fungs/taxator-tk
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fasta-strip-identifier", line 21, in <module>
    while line_outer:
NameError: name 'line_outer' is not defined
```


## taxator-tk_taxator

### Tool Description
Specify a taxonomy mapping file for the reference sequence identifiers

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

### Original Help Text
```text
Specify a taxonomy mapping file for the reference sequence identifiers
Allowed options:
  -h [ --help ]                      show help message
  --citation                         show citation info
  --advanced-options                 show advanced program options
  -a [ --algorithm ] arg (=rpa)      set the algorithm that is used to predict 
                                     taxonomic ids from alignments
  -g [ --seqid-taxid-mapping ] arg   filename of seqid->taxid mapping for 
                                     reference
  -q [ --query-sequences ] arg       query sequences FASTA
  -v [ --query-sequences-index ] arg query sequences FASTA index, for 
                                     out-of-memory operation; is created if not
                                     existing
  -f [ --ref-sequences ] arg         reference sequences FASTA
  -i [ --ref-sequences-index ] arg   FASTA file index, for out-of-memory 
                                     operation; is created if not existing
  -p [ --processors ] arg (=1)       sets number of threads, number > 2 will 
                                     heavily profit from multi-core 
                                     architectures, set to 0 for max. 
                                     performance
  -l [ --logfile ] arg (=/dev/null)  specify name of file for logging 
                                     (appending lines)
```


## taxator-tk_alignments-filter

### Tool Description
Filter taxator-tk alignments by score, identity, e-value and rank.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

### Original Help Text
```text
Allowed options:
  -h [ --help ]                         show help message
  -m [ --min-score ] arg (=0)           set min-score filter value
  -p [ --min-pid ] arg (=0)             set minimal PID to consider
  -t [ --top-percent ] arg (=1)         set top-percent filter value
  -e [ --max-evalue ] arg (=-1)         set maximum evalue for filtering
  -b [ --best-alignments ] arg (=0)     set number of top score alignments to 
                                        consider (after toppercent filter)
  -s [ --sort-score ]                   sort alignments by decreasing score
  -k [ --keep-best-per-ref ]            for each combination of query and 
                                        reference sequence id all but the best 
                                        scoring alignment are removed
  -c [ --min-support ] arg (=1)         set minimum number of hits an alignment
                                        needs to have (after filtering)
  -r [ --remove-ref-from-query-taxon ]  remove alignments for labeled data to 
                                        test different degrees of taxonomic 
                                        distance
  -x [ --taxon-mapping-sample ] arg     map sample identifier to taxon
  -y [ --taxon-mapping-reference ] arg  map reference identifier to taxon
  -z [ --mask-by-star ]                 instead of suppressing filtered 
                                        alignments mask them by prefixing a 
                                        star at the line start
```

## taxator-tk_binner

### Tool Description
Combine taxator segment predictions into one taxonomic assignment per query sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

### Original Help Text
```text
Allowed options:
  -h [ --help ]                         show help message
  --citation                            show citation info
  --advanced-options                    show advanced program options
  -n [ --sample-identifier ] arg        unique sample identifier
  -s [ --sequence-min-support ] arg (=50)
                                        minimum number of positions supporting 
                                        a taxonomic signal for any single 
                                        sequence. If not reached, a fall-back 
                                        on a more robust algorthm will be used
  -j [ --signal-majority ] arg (=0.699999988)
                                        minimum combined fraction of support 
                                        for any single sequence (> 0.5 to be 
                                        stable)
  -i [ --identity-constrain ] arg       minimum required identity for this rank
                                        (e.g. -i species:0.8 -i genus:0.7)
  -f [ --files ] arg                    arbitrary number of prediction files 
                                        (replaces standard input, use "-" to 
                                        specify a combination of both)
  -l [ --logfile ] arg (=binning.log)   specify name of file for logging 
                                        (appending lines)
```

## taxator-tk_taxknife

### Tool Description
Look up, traverse or write the NCBI taxonomy for taxonomic ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

### Original Help Text
```text
Allowed options:
  -h [ --help ]                       show help message
  -m [ --mode ] arg (=annotate)       choose mode:
                                      "traverse": follow nodes upwards in 
                                      taxonomy
                                      
                                      "annotate": looks up metainformation 
                                      attached to nodes (e.g. names)
                                      
                                      "tree": writes a (sub)tree
                                      
                                      
  -f [ --field ] arg (=1)             input column
                                      

traverse mode:
  -k [ --keep-not-rank ]            unmappable taxids remain (otherwise mapped 
                                    to root)
  -t [ --keep-not-taxid ]           unknown taxonomic IDs are kept (otherwise 
                                    skipped)
  -b [ --set-invalid-traverse ] arg replace unknown taxids by this given value
  -r [ --traverse-ranks ] arg       traverse taxonomy up to one of these ranks 
                                    (space separated list)

annotate mode:
  -a [ --allnodes ]                 if set, all nodes will be used, not only at
                                    selected ranks
  -c [ --set-invalid-annotate ] arg replace all taxids that are invalid by this
                                    given value
  -s [ --show ] arg (=name)         either 'name', 'rank', 'path' or 
                                    'taxid-path'
  -n [ --name-ranks ] arg           select ranks to be considered; if not set, 
                                    default ranks will be used

tree mode:
  -q [ --tree-ranks ] arg             consider these taxonomic ranks (ordered 
                                      space separated list from low to high, 
                                      e.g. species family phylum)
  -o [ --outfile ] arg (=tree.newick) name of newick file to be written
  -i [ --fill-intermediate ]          fill in dummy intermediate nodes if ranks
                                      are missing
  -v [ --names ]                      show scientific names in tree (no 
                                      character restrictions)
```

## Metadata
- **Skill**: generated
