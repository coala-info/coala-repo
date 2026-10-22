# trinotate CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trinotate_Trinotate | Failed | image problem: Trinotate --init and --report call /usr/local/bin/util/... scripts that the image keeps flat in /usr/local/bin (Can't exec util/trinotateSeqLoader/TrinotateSeqLoader.pl); CWL fixed (removed invented command argument, db staged writable) |

## trinotate_Trinotate

### Tool Description
Trinotate: Annotation of,"Trinity"-assembled Transcriptome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
- **Homepage**: https://trinotate.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Total Downloads**: 42.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
___________      .__               __          __           
              __    ___/______|__| ____   _____/  |______ _/  |_  ____   
                |    |  _  __   |/     /  _    ____  \   __/ __   
                |    |   |  | /  |   |  (  <_> )  |  / __ |  |   ___/  
                |____|   |__|  |__|___|  /____/|__| (____  /__|  ___  > 
                                       /                 /          /  

     usage: /usr/local/bin/Trinotate --db <sqlite.db> <--command ...>
 

     <commands>: 

         * Initial creation of the Trinotate sqlite database and downloading of the required data sets
              
             Trinotate --db <sqlite.db> --create --trinotate_data_dir /path/to/TRINOTATE_DATA_DIR

                 The sqlite.db file is created as named and search databases are downloaded into /path/to/TRINOTATE_DATA_DIR
                   (Note, if EggnogMapper is installed and env var EGGNOG_DATA_DIR is NOT set, 
                    will additionally download those data too into TRINOTATE_DATA_DIR !) 

         * Initial import of transcriptome and protein data:

             Trinotate --db <sqlite.db> --init --gene_trans_map <file> --transcript_fasta <file> --transdecoder_pep <file>

         * Running annotation computes automatically including auto-loading of results.

             * to run ALL supported computes:
                   
                   Trinotate --db <sqlite.db> --run ALL --CPU <int> --transcript_fasta <file> --transdecoder_pep <file> 

             * or to run select supported computes, indicate which ones to run: 

                   Trinotate --db <sqlite.db> --CPU <int> --transcript_fasta <file> --transdecoder_pep <file> 
                                   --run "swissprot_blastp swissprot_blastx pfam signalp6 tmhmmv2 infernal EggnogMapper" 

                    Notes:
                        -  when specifying run with multiple values, enclose the list in quotes as shown above.
                        -  include --use_diamond if you would prefer to use diamond blast instead of ncbi (default) blast)
                        -  include --trinotate_data_dir <path> unless you have TRINOTATE_DATA_DIR env var set. 
                        -  if running using provided docker or singularity, signalp6 is not automatically included due to licensing restrictions)
                        -  deeptmhmm must be run separately from Trinotate and then loaded using Trinotate --LOAD_deeptmhmm

         * Transdecoder loading protein search results:

             Trinotate --db <sqlite.db> --LOAD_swissprot_blastp <file.outfmt6>
             Trinotate --db <sqlite.db> --LOAD_pfam <file>
             Trinotate --db <sqlite.db> --LOAD_signalp <file>
             Trinotate --db <sqlite.db> --LOAD_EggnogMapper <file>
             Trinotate --db <sqlite.db> --LOAD_tmhmmv2 <file>  or Trinotate --db <sqlite.db> --LOAD_deeptmhmm <file.gff3>


          * Trinity loading transcript search results:

             Trinotate --db <sqlite.db> --LOAD_swissprot_blastx <file.outfmt6>
             Trinotate --db <sqlite.db> --LOAD_infernal <file>
             

          * Load custom blast results using any searchable database

             Trinotate --db <sqlite.db> --LOAD_custom_blast <file.outfmt6> --blast_type <blastp|blastx> --custom_db_name <database_name>
                    (The custom_db_name is used for the column name for that annotation in the final report.)

          * report generation:

             Trinotate --db <sqlite.db> --report [ -E (default: 1e-5) ] 
                                                 [--pfam_cutoff DNC|DGC|DTC|SNC|SGC|STC (default: DNC=domain noise cutoff)] 
                                                 [--incl_pep] 
                                                 [--incl_trans]
```


## Metadata
- **Skill**: generated
