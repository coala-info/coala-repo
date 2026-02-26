# genomad CWL Generation Report

## genomad_download-database

### Tool Description
Download the latest version of geNomad's database and save it in the DESTINATION directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
- **Homepage**: https://portal.nersc.gov/genomad/
- **Package**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Total Downloads**: 155.0K
- **Last updated**: 2025-11-11
- **GitHub**: https://github.com/apcamargo/genomad
- **Stars**: N/A
### Original Help Text
```text
Usage: genomad download-database [OPTIONS] DESTINATION                         
                                                                                
 Download the latest version of geNomad's database and save it in the           
 DESTINATION directory.                                                         
                                                                                
╭─ Basic options ──────────────────────────────────────────────────────────────╮
│                                                                              │
│  --keep                      Do not delete the compressed database file.     │
│  --verbose/--quiet   -v/-q   Display the execution log. [default: verbose]   │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Other ──────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  --help      -h   Show this message and exit.                                │
│  --version        Show the version and exit.                                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  *   DESTINATION   [required] (PATH)                                         │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## genomad_end-to-end

### Tool Description
Takes an INPUT file (FASTA format) and executes all modules of the geNomad pipeline for plasmid and virus identification. Output files are written in the OUTPUT directory. A local copy of geNomad's database (DATABASE directory), which can be downloaded with the download-database command, is required. The end-to-end command omits some options. If you want to have a more granular control over the execution parameters, please execute each module separately.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
- **Homepage**: https://portal.nersc.gov/genomad/
- **Package**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomad end-to-end [OPTIONS] INPUT OUTPUT DATABASE                      
                                                                                
 Takes an INPUT file (FASTA format) and executes all modules of the geNomad     
 pipeline for plasmid and virus identification. Output files are written in the 
 OUTPUT directory. A local copy of geNomad's database (DATABASE directory),     
 which can be downloaded with the download-database command, is required. The   
 end-to-end command omits some options. If you want to have a more granular     
 control over the execution parameters, please execute each module separately.  
                                                                                
  ╭── geNomad pipeline ────────────────────────────────────╮                    
 │                    ╭───────────╮                       │                     
 │           ╭────────┤   INPUT   │                       │                     
 │           │        ╰─────┬─────╯                       │                     
 │           │  ╭───────────▼────────────╮                │                     
 │           │  │        annotate        ├──┬──────────╮  │                     
 │           │  ╰───────────┬────────────╯  │          │  │                     
 │           │  ╭───────────▼────────────╮  │          │  │                     
 │           │  │    find-proviruses     │  │          │  │                     
 │           │  ╰┬──────────────────────┬╯  │          │  │                     
 │  ╭────────▼───▼──────────╮╭──────────▼───▼────────╮ │  │                     
 │  │   nn-classification   ││ marker-classification │ │  │                     
 │  ╰────────────┬──────────╯╰──────────┬────────────╯ │  │                     
 │            ╭──▼──────────────────────▼──╮           │  │                     
 │            │ aggregated-classification  │           │  │                     
 │            ╰─────────────┬──────────────╯           │  │                     
 │            ╭ ─ ─ ─ ─ ─ ─ ▼ ─ ─ ─ ─ ─ ─ ─            │  │                     
 │                  score-calibration      │           │  │                     
 │            │ (optional, off by default)             │  │                     
 │             ─ ─ ─ ─ ─ ─ ─┬─ ─ ─ ─ ─ ─ ─ ╯           │  │                     
 │            ╭─────────────▼──────────────╮           │  │                     
 │            │          summary           ◀───────────╯  │                     
 │            ╰─────────────┬──────────────╯              │                     
 │                    ╭─────▼─────╮                       │                     
 │                    │  OUTPUTS  │                       │                     
 │                    ╰───────────╯                       │                     
 ╰────────────────────────────────────────────────────────╯                     
                                                                                
╭─ Filtering presets ──────────────────────────────────────────────────────────╮
│                                                                              │
│  --conservative/--relaxed   After classification, sequences are further      │
│                             filtered to remove possible false positives.     │
│                             The --conservative preset makes those filters    │
│                             even more aggressive, resulting in more          │
│                             restricted sets of plasmid and virus,            │
│                             containing only sequences whose classification   │
│                             is strongly supported. The --relaxed preset      │
│                             disables all post-classification filters.        │
│                             These presets cannot be used together with the   │
│                             following parameters: --min-score, --max-fdr,    │
│                             --min-number-genes,                              │
│                             --min-plasmid-marker-enrichment,                 │
│                             --min-virus-marker-enrichment,                   │
│                             --min-plasmid-hallmarks,                         │
│                             --min-plasmid-hallmarks-short-seqs,              │
│                             --min-virus-hallmarks,                           │
│                             --min-virus-hallmarks-short-seqs, and            │
│                             --max-uscg.                                      │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Basic options ──────────────────────────────────────────────────────────────╮
│                                                                              │
│  --cleanup                             Delete intermediate files after       │
│                                        execution.                            │
│  --restart                             Overwrite existing intermediate       │
│                                        files.                                │
│  --disable-find-proviruses             Skip the execution of the             │
│                                        find-proviruses module.               │
│  --disable-nn-classification           Skip the execution of the             │
│                                        nn-classification and                 │
│                                        aggregated-classification modules.    │
│  --enable-score-calibration            Execute the score-calibration         │
│                                        module.                               │
│  --threads                     -t      Number of threads to use. [default:   │
│                                        20] (INTEGER)                         │
│  --verbose/--quiet             -v/-q   Display the execution log. [default:  │
│                                        verbose]                              │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ annotation options ─────────────────────────────────────────────────────────╮
│                                                                              │
│  --lenient-taxonomy         Allow classification of virus genomes to taxa    │
│                             below the family rank (subfamily, genus,         │
│                             subgenus, and species). The subfamily and        │
│                             subgenus ranks are only shown if                 │
│                             --full-ictv-lineage is also used.                │
│  --full-ictv-lineage        Output the full ICTV lineage of each virus       │
│                             genome, including ranks that are hidden by       │
│                             default (subrealm, subkingdom, subphylum,        │
│                             subclass, suborder, subfamily, and, subgenus).   │
│                             The subfamily and subgenus ranks are only shown  │
│                             if --lenient-taxonomy is also used.              │
│  --sensitivity         -s   MMseqs2 marker search sensitivity. Higher        │
│                             values will annotate more proteins, but the      │
│                             search will be slower and consume more memory.   │
│                             [default: 4.2] (FLOAT RANGE x>=0.0)              │
│  --splits                   Split the data for the MMseqs2 search. Higher    │
│                             values will reduce memory usage, but will make   │
│                             the search slower. If the MMseqs2 search is      │
│                             failing, try to increase the number of splits.   │
│                             [default: 0] (INTEGER RANGE x>=0)                │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ find-proviruses options ────────────────────────────────────────────────────╮
│                                                                              │
│  --skip-integrase-identification   Disable provirus boundary extension       │
│                                    using nearby integrases.                  │
│  --skip-trna-identification        Disable provirus boundary extension       │
│                                    using nearby tRNAs.                       │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ score-calibration options ──────────────────────────────────────────────────╮
│                                                                              │
│  --composition   Method for estimating sample composition. [default: auto]   │
│                  (auto|metagenome|virome)                                    │
│  --force-auto    Force automatic composition estimation regardless of the    │
│                  sample size.                                                │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ summary options ────────────────────────────────────────────────────────────╮
│                                                                              │
│  --min-score                          Minimum score to flag a sequence as    │
│                                       virus or plasmid. [default: 0.7]       │
│                                       (FLOAT RANGE 0.0<=x<=1.0)              │
│  --max-fdr                            Maximum accepted false discovery       │
│                                       rate. This option will be ignored if   │
│                                       the scores were not calibrated.        │
│                                       [default: 0.1] (FLOAT RANGE            │
│                                       0.0<=x<=1.0)                           │
│  --min-number-genes                   The minimum number of genes a          │
│                                       sequence must encode to be considered  │
│                                       for classification as a plasmid or     │
│                                       virus. [default: 1] (INTEGER RANGE     │
│                                       x>=0)                                  │
│  --min-plasmid-marker-enrichment      Minimum allowed value for the plasmid  │
│                                       marker enrichment score, which         │
│                                       represents the total enrichment of     │
│                                       plasmid markers in the sequence.       │
│                                       Sequences with multiple plasmid        │
│                                       markers will have higher values than   │
│                                       the ones that encode few or no         │
│                                       markers. This option will be ignored   │
│                                       if the annotation module was not       │
│                                       executed. [default: 0.1] (FLOAT)       │
│  --min-virus-marker-enrichment        Minimum allowed value for the virus    │
│                                       marker enrichment score, which         │
│                                       represents the total enrichment of     │
│                                       virus markers in the sequence.         │
│                                       Sequences with multiple virus markers  │
│                                       will have higher values than the ones  │
│                                       that encode few or no markers. This    │
│                                       option will be ignored if the          │
│                                       annotation module was not executed.    │
│                                       [default: 0.0] (FLOAT)                 │
│  --min-plasmid-hallmarks              Minimum number of plasmid hallmarks    │
│                                       in the identified plasmids. This       │
│                                       option will be ignored if the          │
│                                       annotation module was not executed.    │
│                                       [default: 0] (INTEGER RANGE x>=0)      │
│  --min-plasmid-hallmarks-short-seqs   Minimum number of plasmid hallmarks    │
│                                       in plasmids shorter than 2,500 bp.     │
│                                       This option will be ignored if the     │
│                                       annotation module was not executed.    │
│                                       [default: 1] (INTEGER RANGE x>=0)      │
│  --min-virus-hallmarks                Minimum number of virus hallmarks in   │
│                                       the identified viruses. This option    │
│                                       will be ignored if the annotation      │
│                                       module was not executed. [default: 0]  │
│                                       (INTEGER RANGE x>=0)                   │
│  --min-virus-hallmarks-short-seqs     Minimum number of virus hallmarks in   │
│                                       viruses shorter than 2,500 bp. This    │
│                                       option will be ignored if the          │
│                                       annotation module was not executed.    │
│                                       [default: 1] (INTEGER RANGE x>=0)      │
│  --max-uscg                           Maximum allowed number of universal    │
│                                       single copy genes (USCGs) in a virus   │
│                                       or a plasmid. Sequences with more      │
│                                       than this number of USCGs will not be  │
│                                       classified as viruses or plasmids,     │
│                                       regardless of their score. This        │
│                                       option will be ignored if the          │
│                                       annotation module was not executed.    │
│                                       [default: 4] (INTEGER)                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Other ──────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  --help      -h   Show this message and exit.                                │
│  --version        Show the version and exit.                                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  *   INPUT      [required] (PATH)                                            │
│  *   OUTPUT     [required] (PATH)                                            │
│  *   DATABASE   [required] (PATH)                                            │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## genomad_annotate

### Tool Description
Predict the genes in the INPUT file (FASTA format), annotate them using geNomad's markers (located in the DATABASE directory), and write the results to the OUTPUT directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
- **Homepage**: https://portal.nersc.gov/genomad/
- **Package**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomad annotate [OPTIONS] INPUT OUTPUT DATABASE                        
                                                                                
 Predict the genes in the INPUT file (FASTA format), annotate them using        
 geNomad's markers (located in the DATABASE directory), and write the results   
 to the OUTPUT directory.                                                       
                                                                                
╭─ Basic options ──────────────────────────────────────────────────────────────╮
│                                                                              │
│  --cleanup                   Delete intermediate files after execution.      │
│  --restart                   Overwrite existing intermediate files.          │
│  --threads           -t      Number of threads to use. [default: 20]         │
│                              (INTEGER)                                       │
│  --verbose/--quiet   -v/-q   Display the execution log. [default: verbose]   │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced options ───────────────────────────────────────────────────────────╮
│                                                                              │
│  --lenient-taxonomy         Allow classification of virus genomes to taxa    │
│                             below the family rank (subfamily, genus,         │
│                             subgenus, and species). The subfamily and        │
│                             subgenus ranks are only shown if                 │
│                             --full-ictv-lineage is also used.                │
│  --full-ictv-lineage        Output the full ICTV lineage of each virus       │
│                             genome, including ranks that are hidden by       │
│                             default (subrealm, subkingdom, subphylum,        │
│                             subclass, suborder, subfamily, and, subgenus).   │
│                             The subfamily and subgenus ranks are only shown  │
│                             if --lenient-taxonomy is also used.              │
│  --sensitivity         -s   MMseqs2 marker search sensitivity. Higher        │
│                             values will annotate more proteins, but the      │
│                             search will be slower and consume more memory.   │
│                             [default: 4.2] (FLOAT RANGE x>=0.0)              │
│  --evalue              -e   Maximum accepted E-value in the MMseqs2 search.  │
│                             [default: 0.001] (FLOAT)                         │
│  --splits                   Split the data for the MMseqs2 search. Higher    │
│                             values will reduce memory usage, but will make   │
│                             the search slower. If the MMseqs2 search is      │
│                             failing, try to increase the number of splits.   │
│                             [default: 0] (INTEGER RANGE x>=0)                │
│  --use-minimal-db           Use a smaller marker database to annotate        │
│                             proteins. This will make execution faster but    │
│                             sensitivity will be reduced.                     │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Other ──────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  --help      -h   Show this message and exit.                                │
│  --version        Show the version and exit.                                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  *   INPUT      [required] (PATH)                                            │
│  *   OUTPUT     [required] (PATH)                                            │
│  *   DATABASE   [required] (PATH)                                            │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## genomad_find-proviruses

### Tool Description
Find integrated viruses within the sequences in INPUT file using the geNomad markers (located in the DATABASE directory) and write the results to the OUTPUT directory. This command depends on the data generated by the annotate module.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
- **Homepage**: https://portal.nersc.gov/genomad/
- **Package**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomad find-proviruses [OPTIONS] INPUT OUTPUT DATABASE                 
                                                                                
 Find integrated viruses within the sequences in INPUT file using the geNomad   
 markers (located in the DATABASE directory) and write the results to the       
 OUTPUT directory. This command depends on the data generated by the annotate   
 module.                                                                        
                                                                                
╭─ Basic options ──────────────────────────────────────────────────────────────╮
│                                                                              │
│  --cleanup                                 Delete intermediate files after   │
│                                            execution.                        │
│  --restart                                 Overwrite existing intermediate   │
│                                            files.                            │
│  --skip-integrase-identification           Disable provirus boundary         │
│                                            extension using nearby            │
│                                            integrases.                       │
│  --skip-trna-identification                Disable provirus boundary         │
│                                            extension using nearby tRNAs.     │
│  --threads                         -t      Number of threads to use.         │
│                                            [default: 20] (INTEGER)           │
│  --verbose/--quiet                 -v/-q   Display the execution log.        │
│                                            [default: verbose]                │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced options ───────────────────────────────────────────────────────────╮
│                                                                              │
│  --lenient-taxonomy                  Allow classification of virus genomes   │
│                                      to taxa below the family rank           │
│                                      (subfamily, genus, subgenus, and        │
│                                      species). The subfamily and subgenus    │
│                                      ranks are only shown if                 │
│                                      --full-ictv-lineage is also used.       │
│  --full-ictv-lineage                 Output the full ICTV lineage of each    │
│                                      virus genome, including ranks that are  │
│                                      hidden by default (subrealm,            │
│                                      subkingdom, subphylum, subclass,        │
│                                      suborder, subfamily, and, subgenus).    │
│                                      The subfamily and subgenus ranks are    │
│                                      only shown if --lenient-taxonomy is     │
│                                      also used.                              │
│  --crf-threshold                     Minimum gene-level score to flag a      │
│                                      provirus gene using the conditional     │
│                                      random field model. Lower values will   │
│                                      result in longer proviruses but will    │
│                                      increase the probability of host genes  │
│                                      being flagged as part of proviruses.    │
│                                      [default: 0.4] (FLOAT RANGE             │
│                                      0.0<=x<=1.0)                            │
│  --marker-threshold                  Minimum total virus marker score        │
│                                      allowed for proviruses that do not      │
│                                      encode integrases or are not located    │
│                                      at scaffold edges. Lower values will    │
│                                      increase the sensitivity but reduce     │
│                                      the precision of the provirus           │
│                                      identification procedure. [default:     │
│                                      12.0] (FLOAT)                           │
│  --marker-threshold-integrase        Minimum total virus marker score        │
│                                      allowed for proviruses that encode      │
│                                      integrases. [default: 8] (FLOAT)        │
│  --marker-threshold-edge             Minimum total virus marker score        │
│                                      allowed for proviruses that are         │
│                                      located at scaffold edges. [default:    │
│                                      8] (FLOAT)                              │
│  --max-integrase-distance            Maximum allowed distance between        │
│                                      provirus boundaries and the integrases  │
│                                      used for boundary extension. [default:  │
│                                      10000] (INTEGER RANGE x>=0)             │
│  --max-trna-distance                 Maximum allowed distance between        │
│                                      provirus boundaries and the tRNAs used  │
│                                      for boundary extension. [default:       │
│                                      5000] (INTEGER RANGE x>=0)              │
│  --sensitivity                  -s   MMseqs2 integrase search sensitivity.   │
│                                      Higher values will identify more        │
│                                      integrases, but the search will be      │
│                                      slower and consume more memory.         │
│                                      [default: 8.2] (FLOAT RANGE x>=0.0)     │
│  --evalue                       -e   Maximum accepted E-value in the         │
│                                      MMseqs2 integrase search. [default:     │
│                                      0.001] (FLOAT)                          │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Other ──────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  --help      -h   Show this message and exit.                                │
│  --version        Show the version and exit.                                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  *   INPUT      [required] (PATH)                                            │
│  *   OUTPUT     [required] (PATH)                                            │
│  *   DATABASE   [required] (PATH)                                            │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## genomad_marker-classification

### Tool Description
Classify the sequences in the INPUT file (FASTA format) based on the presence of geNomad markers (located in the DATABASE directory) and write the results to the OUTPUT directory. This command depends on the data generated by the annotate module.

### Metadata
- **Docker Image**: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
- **Homepage**: https://portal.nersc.gov/genomad/
- **Package**: https://anaconda.org/channels/bioconda/packages/genomad/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: genomad marker-classification [OPTIONS] INPUT OUTPUT DATABASE           
                                                                                
 Classify the sequences in the INPUT file (FASTA format) based on the presence  
 of geNomad markers (located in the DATABASE directory) and write the results   
 to the OUTPUT directory. This command depends on the data generated by the     
 annotate module.                                                               
                                                                                
╭─ Basic options ──────────────────────────────────────────────────────────────╮
│                                                                              │
│  --restart                   Overwrite existing intermediate files.          │
│  --threads           -t      Number of threads to use. [default: 20]         │
│                              (INTEGER)                                       │
│  --verbose/--quiet   -v/-q   Display the execution log. [default: verbose]   │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Other ──────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  --help      -h   Show this message and exit.                                │
│  --version        Show the version and exit.                                 │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│                                                                              │
│  *   INPUT      [required] (PATH)                                            │
│  *   OUTPUT     [required] (PATH)                                            │
│  *   DATABASE   [required] (PATH)                                            │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```

