### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](history.html "History") |
* [previous](modules.html "riboraptor") |
* [riboraptor 0.2.2 documentation](index.html) »
* [riboraptor](modules.html) »

## Contents

* [Installation](installation.html)
* [Example Workflow](example_workflow.html)
* [Manual](cmd-manual.html)
* [API Usage](api-usage.html)
* [Scores](scores.html)
* [riboraptor](modules.html)
  + riboraptor package
    - [Submodules](#submodules)
    - [riboraptor.cli module](#module-riboraptor.cli)
    - [riboraptor.coherence module](#module-riboraptor.coherence)
    - [riboraptor.count module](#module-riboraptor.count)
    - [riboraptor.download module](#module-riboraptor.download)
    - [riboraptor.dtw module](#module-riboraptor.dtw)
    - [riboraptor.fasta module](#module-riboraptor.fasta)
    - [riboraptor.genome module](#module-riboraptor.genome)
    - [riboraptor.helpers module](#module-riboraptor.helpers)
    - [riboraptor.normalization module](#module-riboraptor.normalization)
    - [riboraptor.plotting module](#module-riboraptor.plotting)
    - [riboraptor.statistics module](#module-riboraptor.statistics)
    - [riboraptor.utils module](#module-riboraptor.utils)
    - [riboraptor.wig module](#module-riboraptor.wig)
    - [Module contents](#module-riboraptor)
* [History](history.html)
* [Contributing](contributing.html)
* [Credits](authors.html)

#### Previous topic

[riboraptor](modules.html "previous chapter")

#### Next topic

[History](history.html "next chapter")

### This Page

* [Show Source](_sources/riboraptor.rst.txt)

1. [Docs](index.html)
2. [riboraptor](modules.html)
3. riboraptor package

# riboraptor package[¶](#riboraptor-package "Permalink to this headline")

## Submodules[¶](#submodules "Permalink to this headline")

## riboraptor.cli module[¶](#module-riboraptor.cli "Permalink to this headline")

## riboraptor.coherence module[¶](#module-riboraptor.coherence "Permalink to this headline")

`riboraptor.coherence.``get_periodicity`(*values*, *input\_is\_stream=False*)[[source]](_modules/riboraptor/coherence.html#get_periodicity)[¶](#riboraptor.coherence.get_periodicity "Permalink to this definition")
:   Calculate periodicty wrt 1-0-0 signal.

    |  |  |
    | --- | --- |
    | Parameters: | **values** : array like  List of values |
    | Returns: | **periodicity** : float  Periodicity calculated as cross correlation between input and idea 1-0-0 signal |

`riboraptor.coherence.``naive_periodicity`(*values*, *identify\_peak=False*)[[source]](_modules/riboraptor/coherence.html#naive_periodicity)[¶](#riboraptor.coherence.naive_periodicity "Permalink to this definition")
:   Calculate periodicity in a naive manner

    Take ratio of frame1 over avg(frame2+frame3) counts. By default
    the first value is treated as the first frame as well

    |  |  |
    | --- | --- |
    | Parameters: | **values** : Series  Metagene profile |
    | Returns: | **periodicity** : float  Periodicity |

## riboraptor.count module[¶](#module-riboraptor.count "Permalink to this headline")

Utilities for read counting operations.

`riboraptor.count.``bam_to_bedgraph`(*bam*, *strand=u'both'*, *end\_type=u'5prime'*, *saveto=None*)[[source]](_modules/riboraptor/count.html#bam_to_bedgraph)[¶](#riboraptor.count.bam_to_bedgraph "Permalink to this definition")
:   Create bigwig from bam.

    |  |  |
    | --- | --- |
    | Parameters: | **bam** : str  Path to bam file  **strand** : str, optional  Use reads mapping to ‘+/-/both’ strands  **end\_type** : str  Use only end\_type=5prime(5’) or “3prime(3’)”  **saveto** : str, optional  Path to write bedgraph |
    | Returns: | **genome\_cov** : str  Bedgraph output |

`riboraptor.count.``bedgraph_to_bigwig`(*bedgraph*, *sizes*, *saveto*, *input\_is\_stream=False*)[[source]](_modules/riboraptor/count.html#bedgraph_to_bigwig)[¶](#riboraptor.count.bedgraph_to_bigwig "Permalink to this definition")
:   Convert bedgraph to bigwig.

    |  |  |
    | --- | --- |
    | Parameters: | **bedgraph** : str  Path to bedgraph file  **sizes** : str  Path to genome chromosome sizes file or genome name  **saveto** : str  Path to write bigwig file  **input\_is\_stream** : bool  True if input is sent through stdin |

`riboraptor.count.``collapse_gene_coverage_to_metagene`(*gene\_coverages*, *target\_length*, *outfile=None*)[[source]](_modules/riboraptor/count.html#collapse_gene_coverage_to_metagene)[¶](#riboraptor.count.collapse_gene_coverage_to_metagene "Permalink to this definition")
:   Collapse gene coverages to specific target length.

    |  |  |
    | --- | --- |
    | Parameters: | **gene\_coverages** : string  Path to gene coverages.tsv  **target\_lenght** : int  Collapse to target length |
    | Returns: | **collapsed\_gene\_coverage** : Series like  Collapsed version |

`riboraptor.count.``count_feature_genewise`(*feature\_bed*, *bam*, *force\_strandedness=False*, *use\_multiprocessing=False*)[[source]](_modules/riboraptor/count.html#count_feature_genewise)[¶](#riboraptor.count.count_feature_genewise "Permalink to this definition")
:   Count features genewise.

    |  |  |
    | --- | --- |
    | Parameters: | **bam** : str  Path to bam file  **feature\_bed** : str  Path to features bed file |
    | Returns: | **counts** : dict  Genewise feature counts |

`riboraptor.count.``count_reads_bed`(*bam*, *region\_bed\_f*, *saveto*)[[source]](_modules/riboraptor/count.html#count_reads_bed)[¶](#riboraptor.count.count_reads_bed "Permalink to this definition")
:   Count number of reads following in each region.

    |  |  |
    | --- | --- |
    | Parameters: | **bam** : str  Path to bam file (unique mapping only)  **region\_bed\_f** : pybedtools.BedTool or str  Genomic regions to get distance from  **prefix** : str  Prefix to output pickle files |
    | Returns: | **counts\_by\_region** : Series  Series with counts indexed by gene id  **region\_lengths** : Series  Series with gene lengths  **counts\_normalized\_by\_length** : Series  Series with normalized counts |

`riboraptor.count.``count_reads_in_features`(*feature\_bed*, *bam*, *force\_strandedness=False*, *use\_multiprocessing=False*)[[source]](_modules/riboraptor/count.html#count_reads_in_features)[¶](#riboraptor.count.count_reads_in_features "Permalink to this definition")
:   Count reads overlapping features.

    |  |  |
    | --- | --- |
    | Parameters: | **feature\_bed** : str  Path to features bed file  **bam** : str  Path to bam file  **force\_strandedness** : bool  Should count feature only if on the same strand  **use\_multiprocessing** : bool  True if multiprocessing mode  **Returns**    **——-**    **counts** : int  Number of intersection between bam and bed |

`riboraptor.count.``count_reads_per_gene`(*bw*, *bed*, *prefix=None*, *n\_cores=16*, *collapse\_intervals=True*)[[source]](_modules/riboraptor/count.html#count_reads_per_gene)[¶](#riboraptor.count.count_reads_per_gene "Permalink to this definition")
:   Count number of reads following in each region.

    |  |  |
    | --- | --- |
    | Parameters: | **bw** : str  Path to bigWig file  **bed** : pybedtools.BedTool or str  Genomic regions to get distance from  **prefix** : str  Prefix to output pickle files  **n\_cores** : int  Use multiple cores (Default: 16). Set to 1 to disable multiprocessing  **collapse\_intervals** : bool  Should the intervals be collapsed based on the ‘name’ column in gene This should be set to False for things like tRNA where the tRNA can span multiple chromosomes |
    | Returns: | **counts\_by\_region** : Series  Series with counts indexed by gene id  **region\_lengths** : Series  Series with gene lengths  **counts\_normalized\_by\_length** : Series  Series with normalized counts |

`riboraptor.count.``count_utr5_utr3_cds`(*bam*, *utr5\_bed=None*, *cds\_bed=None*, *utr3\_bed=None*, *genome=None*, *force\_strandedness=False*, *genewise=False*, *saveto=None*, *use\_multiprocessing=False*)[[source]](_modules/riboraptor/count.html#count_utr5_utr3_cds)[¶](#riboraptor.count.count_utr5_utr3_cds "Permalink to this definition")
:   One shot counts over UTR5/UTR3/CDS.

    |  |  |
    | --- | --- |
    | Parameters: | **bam** : str  Path to bam file  **utr5\_bed** : str  Path to 5’UTR feature bed file  **utr3\_bed** : str  Path to 3’UTR feature bed file  **cds\_bed** : str  Path to CDS feature bed file  **saveto** : str, optional  Path to output file  **use\_multiprocessing** : bool  SHould use multiprocessing? Not been well tested if it really helps |
    | Returns: | **counts** : dict  Dict with keys as feature type and counts as values |

`riboraptor.count.``diff_region_enrichment`(*numerator*, *denominator*, *prefix*)[[source]](_modules/riboraptor/count.html#diff_region_enrichment)[¶](#riboraptor.count.diff_region_enrichment "Permalink to this definition")
:   Calculate enrichment of counts of one region over another.

    |  |  |
    | --- | --- |
    | Parameters: | **numerator** : str  Path to pickle file  **denominator** : str  Path to pickle file  **prefix** : str  Prefix to save pickles to |
    | Returns: | **enrichment** : series |

`riboraptor.count.``export_gene_coverages`(*bigwig*, *region\_bed\_f*, *saveto*, *offset\_5p=60*, *offset\_3p=0*, *ignore\_tx\_version=True*)[[source]](_modules/riboraptor/count.html#export_gene_coverages)[¶](#riboraptor.count.export_gene_coverages "Permalink to this definition")
:   Export all gene coverages.

    |  |  |
    | --- | --- |
    | Parameters: | **bigwig** : str  Path to bigwig file  **region\_bed\_f** : str  Path to region bed file (CDS/3’UTR/5’UTR) with bed name column as gene or a genome name (hg38\_utr5, hg38\_cds, hg38\_utr3)  **saveto** : str  Path to write output tsv file  **offset\_5p** : int  number of bases to count upstream (5’)  **offset\_30** : int  number of bases to count downstream (3’)  **ignore\_tx\_version** : bool  Should versions be ignored for gene names |
    | Returns: | **gene\_profiles: file**  with the following format: gene1 5poffset1 3poffset1 length1 mean1 median1 stdev1 cnt1\_1 cnt1\_2 cnt1\_3 …  gene2 5poffset2 3poffset2 length2 mean2 median2 stdev2 cnt2\_1 cnt2\_2 cnt2\_3 cnt2\_4 … |

`riboraptor.count.``export_metagene_coverage`(*bigwig*, *region\_bed\_f*, *max\_positions=None*, *saveto=None*, *offset\_5p=60*, *offset\_3p=0*, *ignore\_tx\_version=True*)[[source]](_modules/riboraptor/count.html#export_metagene_coverage)[¶](#riboraptor.count.export_metagene_coverage "Permalink to this definition")
:   Calculate metagene coverage.

    |  |  |
    | --- | --- |
    | Parameters: | **bigwig** : str  Path to bigwig file  **region\_bed\_f** : str  Path to region bed file (CDS/3’UTR/5’UTR) or a genome name (hg38\_utr5, hg38\_cds, hg38\_utr3)  **max\_positions: int**  Number of positions to consider while calculating the normalized coverage Higher values lead to slower implementation  **saveto** : str  Path to write output tsv file  **offset\_5p** : int  Number of bases to offset upstream(5’)  **offset\_3p** : int  Number of bases to offset downstream(3’)  **ignore\_tx\_version** : bool  Should versions be ignored for gene names |
    | Returns: | **metagene\_profile** : series  Metagene profile |

`riboraptor.count.``extract_uniq_mapping_reads`(*inbam*, *outbam*)[[source]](_modules/riboraptor/count.html#extract_uniq_mapping_reads)[¶](#riboraptor.count.extract_uniq_mapping_reads "Permalink to this definition")
:   Extract only uniquely mapping reads from a bam.

    |  |  |
    | --- | --- |
    | Parameters: | **inbam** : string  Path to input bam file  **outbam** : string  Path to write unique reads bam to |

`riboraptor.count.``gene_coverage`(*gene\_name*, *bed*, *bw*, *gene\_group=None*, *offset\_5p=0*, *offset\_3p=0*, *collapse\_intervals=True*)[[source]](_modules/riboraptor/count.html#gene_coverage)[¶](#riboraptor.count.gene_coverage "Permalink to this definition")
:   Get gene coverage.

    |  |  |
    | --- | --- |
    | Parameters: | **gene\_name** : str  Gene name  **bed** : str  Path to CDS or 5’UTR or 3’UTR bed  **bw** : str  Path to bigwig to fetch the scores from  **offset\_5p** : int (positive)  Number of bases to count upstream (5’)  **offset\_3p** : int (positive)  Number of bases to count downstream (3’)  **collapse\_intervals** : bool  Should bed be collapsed based on gene name |
    | Returns: | **coverage\_combined** : series  Series with index as position and value as coverage  **intervals\_for\_fasta\_read** : list  List of tuples  **index\_to\_genomic\_pos\_map** : series    **gene\_offset** : int  Gene wise offsets |

`riboraptor.count.``gene_coverage_sum`(*gene\_name*, *bed*, *bw*, *collapse\_intervals=True*)[[source]](_modules/riboraptor/count.html#gene_coverage_sum)[¶](#riboraptor.count.gene_coverage_sum "Permalink to this definition")
:   Keep track of only the sum

    |  |  |
    | --- | --- |
    | Parameters: | **gene\_name** : str  Name of gene  **bed** : str  Path to bed file  **bw** : str  Path to bigwig file  **collapse\_intervals** : bool  Should the intervals be collapsed based on the ‘name’ column in gene This should be set to False for things like tRNA where the tRNA can span multiple chromosomes |

`riboraptor.count.``get_fasta_sequence`(*fasta*, *intervals*)[[source]](_modules/riboraptor/count.html#get_fasta_sequence)[¶](#riboraptor.count.get_fasta_sequence "Permalink to this definition")
:   Extract fasta sequence given a list of intervals.

    |  |  |
    | --- | --- |
    | Parameters: | **fasta** : str  Path to fasta file  **intervals** : list(tuple)  A list of tuple in the form [(chrom, start, stop, strand)] |
    | Returns: | **seq** : list  List of sequences at intervals |

`riboraptor.count.``get_region_sizes`(*bed*)[[source]](_modules/riboraptor/count.html#get_region_sizes)[¶](#riboraptor.count.get_region_sizes "Permalink to this definition")
:   Get collapsed lengths of gene in bed.

    |  |  |
    | --- | --- |
    | Parameters: | **bed** : str  Path to bed file |
    | Returns: | **region\_sizes** : dict  Region sies with gene names as key and value as size of this named region |

`riboraptor.count.``htseq_to_cpm`(*htseq\_f*, *saveto=None*)[[source]](_modules/riboraptor/count.html#htseq_to_cpm)[¶](#riboraptor.count.htseq_to_cpm "Permalink to this definition")
:   Convert HTSeq counts to CPM.

    |  |  |
    | --- | --- |
    | Parameters: | **htseq\_f** : str  Path to HTseq counts file  **saveto** : str, optional  Path to output file |
    | Returns: | **cpm** : dataframe  CPM |

`riboraptor.count.``htseq_to_tpm`(*htseq\_f*, *cds\_bed\_f*, *saveto=None*)[[source]](_modules/riboraptor/count.html#htseq_to_tpm)[¶](#riboraptor.count.htseq_to_tpm "Permalink to this definition")
:   Convert HTSeq counts to TPM.

    |  |  |
    | --- | --- |
    | Parameters: | **htseq\_f** : str  Path to HTseq counts file  **region\_sizes** : dict  Dict with keys as gene and values as length (CDS/Exon) of that gene  **saveto** : str, optional  Path to outpu