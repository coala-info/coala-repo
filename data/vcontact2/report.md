# vcontact2 CWL Generation Report

## vcontact2

### Tool Description
vConTACT2 (viral Contig Automatic Cluster Taxonomy) is tool to perform "Guilt-by-contig-association" automatic classification of viral contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcontact2:0.11.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/MAVERICLab/vcontact2
- **Package**: https://anaconda.org/channels/bioconda/packages/vcontact2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcontact2/overview
- **Total Downloads**: 136.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: vcontact2 [-h] [-r RAW_PROTEINS] [--rel-mode {BLASTP,Diamond,MMSeqs2}]
                 [-b BLAST_FP] [-p PROTEINS_FP]
                 [--db {None,ProkaryoticViralRefSeq85-ICTV,ProkaryoticViralRefSeq85-Merged,ProkaryoticViralRefSeq88-Merged,ProkaryoticViralRefSeq94-Merged,ProkaryoticViralRefSeq97-Merged,ProkaryoticViralRefSeq99-Merged,ProkaryoticViralRefSeq201-Merged,ProkaryoticViralRefSeq207-Merged,ProkaryoticViralRefSeq211-Merged,ArchaeaViralRefSeq85-Merged,ArchaeaViralRefSeq94-Merged,ArchaeaViralRefSeq97-Merged,ArchaeaViralRefSeq99-Merged,ArchaeaViralRefSeq201-Merged,ArchaeaViralRefSeq207-Merged,ArchaeaViralRefSeq211-Merged}]
                 [--pcs-mode {ClusterONE,MCL}] [--vcs-mode {ClusterONE,MCL}]
                 [--c1-bin CLUSTER_ONE] [--blastp-bin BLASTP_FP]
                 [--diamond-bin DIAMOND_FP] [-o OUTPUT_DIR] [-t THREADS]
                 [--pc-evalue EVALUE] [--reported-alignments PC_ALIGNMENTS]
                 [--max-overlap PC_OVERLAP] [--penalty PC_PENALTY]
                 [--haircut PC_HAIRCUT] [--pc-inflation PC_INFLATION]
                 [--vc-inflation VC_INFLATION] [--min-density VC_DENSITY]
                 [--min-size VC_SIZE] [--vc-overlap VC_OVERLAP]
                 [--vc-penalty VC_PENALTY] [--vc-haircut VC_HAIRCUT]
                 [--merge-method {single,multi}]
                 [--similarity {match,simpson,jaccard,dice}]
                 [--seed-method {unused_nodes,nodes,edges,cliques}]
                 [--optimize] [--sig SIG] [--max-sig MAX_SIG] [--permissive]
                 [--mod-inflation MOD_INFLATION] [--mod-sig MOD_SIG]
                 [--mod-shared-min MOD_SHARED_MIN] [--link-sig LINK_SIG]
                 [--link-prop LINK_PROP] [-e [EXPORTS ...]]
                 [--cluster-filter [CLUSTER_FILTER ...]]
                 [--criterion CRITERION] [--contigs CONTIGS] [--pcs PCS]
                 [--pc-profiles PCPROFILES] [-v] [-f]

vConTACT 2 - Copyright 2018 Benjamin Bolduc, Guilhem Doulcier.

vConTACT2 (viral Contig Automatic Cluster Taxonomy) is tool to perform
"Guilt-by-contig-association" automatic classification of viral
contigs.

This program is distributed under the term of the GNU General Public
Licence v3 (or later) with ABSOLUTELY NO WARRANTY. This is free
software, and you are welcome to redistribute it.

options:
  -h, --help            show this help message and exit

Main Arguments:
  -r RAW_PROTEINS, --raw-proteins RAW_PROTEINS
                        FASTA-formatted proteins file. If provided alongside
                        --proteins-fn, vConTACT will start prior to PC
                        generation. (default: None)
  --rel-mode {BLASTP,Diamond,MMSeqs2}
                        Method to use to create the protein-protein similarity
                        edge file. This is what the PC clustering is applied
                        against. (default: Diamond)
  -b BLAST_FP, --blast-fp BLAST_FP
                        Blast results file in CSV or TSV format. Used for
                        generating the protein clusters. If provided alongside
                        --proteins-fn, vConTACT will start from the PC-
                        generation step. If raw proteins are provided, THIS
                        WILL BE SKIPPED. Reference DBs CANNOT BE USED IF THIS
                        OPTION IS ENABLED!! (default: None)
  -p PROTEINS_FP, --proteins-fp PROTEINS_FP
                        A file linking the protein name (as in the blast file)
                        and the genome names (csv or tsv). If provided
                        alongside --blast-fp, vConTACT will start from the PC-
                        generation step. If provided alongside --raw-proteins,
                        vConTACT will start from creating the all-verses-all
                        protein comparison and then generate protein clusters.
                        (default: None)
  --db {None,ProkaryoticViralRefSeq85-ICTV,ProkaryoticViralRefSeq85-Merged,ProkaryoticViralRefSeq88-Merged,ProkaryoticViralRefSeq94-Merged,ProkaryoticViralRefSeq97-Merged,ProkaryoticViralRefSeq99-Merged,ProkaryoticViralRefSeq201-Merged,ProkaryoticViralRefSeq207-Merged,ProkaryoticViralRefSeq211-Merged,ArchaeaViralRefSeq85-Merged,ArchaeaViralRefSeq94-Merged,ArchaeaViralRefSeq97-Merged,ArchaeaViralRefSeq99-Merged,ArchaeaViralRefSeq201-Merged,ArchaeaViralRefSeq207-Merged,ArchaeaViralRefSeq211-Merged}
                        Select a reference database to de novo cluster
                        proteins against. If 'None' selected, be aware that
                        there will be no references included in the analysis.
                        (default: ProkaryoticViralRefSeq85-ICTV)
  --pcs-mode {ClusterONE,MCL}
                        Whether to use ClusterONE or MCL for Protein Cluster
                        (PC) generation. (default: MCL)
  --vcs-mode {ClusterONE,MCL}
                        Whether to use ClusterONE or MCL for Viral Cluster
                        (VC) generation. (default: ClusterONE)
  --c1-bin CLUSTER_ONE  Location for clusterONE file. Path only used if
                        vConTACT cant find in $PATH. (default: None)
  --blastp-bin BLASTP_FP
                        Location for BLASTP executable. Path only used if
                        vConTACT cant find in $PATH. (default: None)
  --diamond-bin DIAMOND_FP
                        Location for DIAMOND executable. Path only used if
                        vConTACT cant find in $PATH. (default: None)
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory (default: vContact_Output)
  -t THREADS, --threads THREADS
                        Number of CPUs to use. If nothing is provided,
                        vConTACT will attempt to identify the number of
                        available CPUs. (default: 14)

Protein Cluster (PC) Arguments:
  --pc-evalue EVALUE    E-value used by BLASTP or Diamond when creating the
                        protein-protein similarity network. (default: 0.0001)
  --reported-alignments PC_ALIGNMENTS
                        Maximum number of target sequences per query to report
                        alignments for in Diamond. (default: 25)
  --max-overlap PC_OVERLAP
                        Specifies the maximum allowed overlap between two
                        clusters. (ClusterONE only) (default: 0.8)
  --penalty PC_PENALTY  Sets a penalty value for the inclusion of each node.
                        It can be used to model the possibility of uncharted
                        connections for each node, so nodes with only a single
                        weak connection to a cluster will not be added to the
                        cluster as the penalty value will outweigh the
                        benefits of adding the node. (ClusterONE only)
                        (default: 2.0)
  --haircut PC_HAIRCUT  Apply a haircut transformation as a post-processing
                        step on the detected clusters. A haircut
                        transformation removes dangling nodes from a cluster.
                        (ClusterONE only) (default: 0.1)
  --pc-inflation PC_INFLATION
                        Inflation value to define proteins clusters with MCL.
                        (default: 2.0) (MCL only) (default: 2.0)

Viral Cluster (VC) Arguments:
  --vc-inflation VC_INFLATION
                        Inflation parameter to define contig clusters with
                        MCL. (MCL only) (default: 2.0)
  --min-density VC_DENSITY
                        Sets the minimum density of predicted complexes.
                        (ClusterONE only) (default: 0.3)
  --min-size VC_SIZE    Minimum size for the Viral Cluster. (default: 2)
  --vc-overlap VC_OVERLAP
                        Specifies the maximum allowed overlap between two
                        clusters. (ClusterONE only) (default: 0.9)
  --vc-penalty VC_PENALTY
                        Sets a penalty value for the inclusion of each node.
                        It can be used to model the possibility of uncharted
                        connections for each node, so nodes with only a single
                        weak connection to a cluster will not be added to the
                        cluster as the penalty value will outweigh the
                        benefits of adding the node. (ClusterONE only)
                        (default: 2.0)
  --vc-haircut VC_HAIRCUT
                        Apply a haircut transformation as a post-processing
                        step on the detected clusters. A haircut
                        transformation removes dangling nodes from a cluster.
                        (ClusterONE only) (default: 0.55)
  --merge-method {single,multi}
                        Specifies the method to be used to merge highly
                        overlapping complexes. (ClusterONE only) (default:
                        single)
  --similarity {match,simpson,jaccard,dice}
                        Specifies the similarity function to be used in the
                        merging step. (ClusterONE only) (default: match)
  --seed-method {unused_nodes,nodes,edges,cliques}
                        Specifies the seed generation method to use.
                        (ClusterONE only) (default: nodes)
  --optimize            Optimize hierarchical distances during second-pass of
                        the viral clusters (default: False)

Similarity Network and Module Options:
  --sig SIG             Significance threshold in the contig similarity
                        network. (default: 1.0)
  --max-sig MAX_SIG     Significance threshold in the contig similarity
                        network. (default: 300)
  --permissive          Use permissive affiliation for associating VCs with
                        reference sequences. (default: False)
  --mod-inflation MOD_INFLATION
                        Inflation parameter to define protein modules with
                        MCL. (default: 5.0)
  --mod-sig MOD_SIG     Significance threshold in the protein cluster
                        similarity network. (default: 1.0)
  --mod-shared-min MOD_SHARED_MIN
                        Minimal number (inclusive) of contigs a PC must appear
                        into to be taken into account in the modules
                        computing. (default: 3)
  --link-sig LINK_SIG   Significitaivity threshold to link a cluster and a
                        module (default: 1.0)
  --link-prop LINK_PROP
                        Proportion of a module's PC a contig must have to be
                        considered as displaying this module. (default: 0.5)

Output Options:
  -e [EXPORTS ...], --exports [EXPORTS ...]
                        Export backend. Suported values are "csv", "krona" and
                        "cytoscape" (default: ['csv'])
  --cluster-filter [CLUSTER_FILTER ...]
                        Id of the clusters to export (Cytoscape export only).
                        (default: [0])
  --criterion CRITERION
                        Pooling criterion for cluster export (Cytoscape export
                        only). (default: predicted_family)

Legacy Options:
  --contigs CONTIGS     Contig info file (tsv or csv) (default: None)
  --pcs PCS             Protein clusters info file (tsv or csv) (default:
                        None)
  --pc-profiles PCPROFILES
                        Protein cluster profiles of the contigs (tsv or csv)
                        (default: None)

Misc. Options:
  -v, --verbose         Verbosity level : -v warning, -vv info, -vvv debug,
                        (default info) (default: -2)
  -f, --force-overwrite
                        Overwrite existing files (default: False)
```

