# tooldistillator CWL Generation Report

## tooldistillator_abricate

### Tool Description
Extract information from output(s) of abricate (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2026-02-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: tooldistillator.py abricate <options>

Extract information from output(s) of abricate (OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        abricate version for abricate
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for abricate
  --hid HID             historic ID for abricate file from galaxy for abricate
```


## tooldistillator_amrfinderplus

### Tool Description
Extract information from output(s) of amrfinderplus (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py amrfinderplus <options>

Extract information from output(s) of amrfinderplus (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        amrfinderplus version number for amrfinderplus
  --hid HID             historic ID for amrfinderplus file from galaxy for
                        amrfinderplus
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for amrfinderplus
  --point_mutation_report_path POINT_MUTATION_REPORT_PATH
                        point mutation report file for amrfinderplus
  --point_mutation_report_hid POINT_MUTATION_REPORT_HID
                        historic ID for point mutation report file from galaxy
                        for amrfinderplus
  --nucleotide_sequence_path NUCLEOTIDE_SEQUENCE_PATH
                        nucleotide identified sequence fasta file for
                        amrfinderplus
  --nucleotide_sequence_hid NUCLEOTIDE_SEQUENCE_HID
                        historic ID for nucleotide sequence fasta file from
                        galaxy for amrfinderplus
```


## tooldistillator_argnorm

### Tool Description
Extract information from output(s) of argnorm (output.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py argnorm <options>

Extract information from output(s) of argnorm (output.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        argnorm version number for argnorm
  --hid HID             historic ID for argnorm file from galaxy for argnorm
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for argnorm
```


## tooldistillator_bakta

### Tool Description
Extract information from output(s) of bakta (OUTPUT.json)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py bakta <options>

Extract information from output(s) of bakta (OUTPUT.json)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             historic ID to bakta result file from galaxy for bakta
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        bakta version for bakta
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for bakta
  --annotation_tabular_path ANNOTATION_TABULAR_PATH
                        annotation file in TSV format for bakta
  --annotation_tabular_hid ANNOTATION_TABULAR_HID
                        historic ID for annotation tsv file from galaxy for
                        bakta
  --gff_file_path GFF_FILE_PATH
                        annotation file result in gff3 format for bakta
  --gff_file_hid GFF_FILE_HID
                        historic ID for gff file from galaxy for bakta
  --annotation_genbank_path ANNOTATION_GENBANK_PATH
                        annotation file in genbank format for bakta
  --annotation_genbank_hid ANNOTATION_GENBANK_HID
                        historic ID for annotation genbank file from galaxy
                        for bakta
  --annotation_embl_path ANNOTATION_EMBL_PATH
                        annotation file in embl format for bakta
  --annotation_embl_hid ANNOTATION_EMBL_HID
                        historic ID for annotation embl file from galaxy for
                        bakta
  --contig_sequences_path CONTIG_SEQUENCES_PATH
                        contig sequences in fasta ([output].fna) for bakta
  --contig_sequences_hid CONTIG_SEQUENCES_HID
                        historic ID for contigs fasta file from galaxy for
                        bakta
  --nucleotide_annotation_path NUCLEOTIDE_ANNOTATION_PATH
                        nuleotide file ([output].ffn) of the annotation for
                        bakta
  --nucleotide_annotation_hid NUCLEOTIDE_ANNOTATION_HID
                        historic ID for nucleotide file from galaxy for bakta
  --amino_acid_annotation_path AMINO_ACID_ANNOTATION_PATH
                        amino acid file of the annotation for bakta
  --amino_acid_annotation_hid AMINO_ACID_ANNOTATION_HID
                        historic ID for amino acide sequence file from galaxy
                        for bakta
  --hypothetical_protein_path HYPOTHETICAL_PROTEIN_PATH
                        hypothetical protein CDS amino acid sequences as fasta
                        for bakta
  --hypothetical_protein_hid HYPOTHETICAL_PROTEIN_HID
                        historic ID for hypothetical protein file file from
                        galaxy for bakta
  --hypothetical_tabular_path HYPOTHETICAL_TABULAR_PATH
                        hypothetical protein CDS for bakta
  --hypothetical_tabular_hid HYPOTHETICAL_TABULAR_HID
                        historic ID for hypothetical tabular file from galaxy
                        for bakta
  --summary_result_path SUMMARY_RESULT_PATH
                        summary file of the bakta analysis in txt format for
                        bakta
  --summary_result_hid SUMMARY_RESULT_HID
                        historic ID for summary file from galaxy for bakta
  --plot_file_path PLOT_FILE_PATH
                        genome annotation plot file path for bakta
  --plot_file_hid PLOT_FILE_HID
                        historic ID for plot file from galaxy for bakta
```


## tooldistillator_bandage

### Tool Description
Extract information from output(s) of bandage (OUTPUT.txt)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py bandage <options>

Extract information from output(s) of bandage (OUTPUT.txt)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        bandage version number for bandage
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for bandage
  --hid HID             historic ID for bandage file from galaxy for bandage
  --bandage_plot_path BANDAGE_PLOT_PATH
                        bandage plot file for bandage
  --bandage_plot_hid BANDAGE_PLOT_HID
                        historic ID for bandage plot from galaxy for bandage
```


## tooldistillator_bracken

### Tool Description
Extract information from output(s) of bracken (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py bracken <options>

Extract information from output(s) of bracken (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to kraken report file from Galaxy for
                        bracken
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        bracken version for bracken
  --reference_database_version REFERENCE_DATABASE_VERSION
                        bracken DB version for bracken
  --read_len READ_LEN   read length value for bracken
  --level LEVEL         level to estimate abundance for bracken
  --threshold THRESHOLD
                        number of reads required PRIOR to abundance estimation
                        for bracken
  --kraken_report_path KRAKEN_REPORT_PATH
                        New kraken report estimated from bracken for bracken
  --kraken_report_hid KRAKEN_REPORT_HID
                        Historic ID to kraken results file from Galaxy for
                        bracken
```


## tooldistillator_bwa

### Tool Description
Extract information from output(s) of bwa (input.bam)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py bwa <options>

Extract information from output(s) of bwa (input.bam)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to bwa contigs file from Galaxy for bwa
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        bwa version number for bwa
  --reference_database_version REFERENCE_DATABASE_VERSION
                        bwa reference genome for bwa
  --paired_second_file_path PAIRED_SECOND_FILE_PATH
                        if paired inputs are uses for bwa
  --paired_second_file_hid PAIRED_SECOND_FILE_HID
                        Galaxy HID to the paired file for bwa
```


## tooldistillator_checkm2

### Tool Description
Extract information from output(s) of checkm2 (quality_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py checkm2 <options>

Extract information from output(s) of checkm2 (quality_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        checkm2 version number for checkm2
  --hid HID             historic ID for checkm2 file from galaxy for checkm2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for checkm2
  --diamond_results_path DIAMOND_RESULTS_PATH
                        DIAMOND_RESULTS file for checkm2
  --diamond_results_hid DIAMOND_RESULTS_HID
                        historic ID for DIAMOND results file from galaxy for
                        checkm2
  --protein_zip_path PROTEIN_ZIP_PATH
                        protein sequence fasta files in a ZIP file for checkm2
  --protein_zip_hid PROTEIN_ZIP_HID
                        historic ID for protein ZIP file from galaxy for
                        checkm2
  --checkm2_log_path CHECKM2_LOG_PATH
                        Checkm2 log file for checkm2
  --checkm2_log_hid CHECKM2_LOG_HID
                        historic ID for Checkm2 log file from galaxy for
                        checkm2
```


## tooldistillator_concoct

### Tool Description
Extract information from output(s) of concoct (merge_cluster.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py concoct <options>

Extract information from output(s) of concoct (merge_cluster.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to Concoct clusters file from Galaxy for
                        concoct
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Concoct version number for concoct
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for concoct
  --fasta_bin_zip_folder_path FASTA_BIN_ZIP_FOLDER_PATH
                        Bin fasta format ZIP folder for Concoct for concoct
  --fasta_bin_zip_folder_hid FASTA_BIN_ZIP_FOLDER_HID
                        Historic ID to bin fasta format ZIP folder from Galaxy
                        for concoct
  --contigs_cut_up_file_path CONTIGS_CUT_UP_FILE_PATH
                        Contigs cut up fasta file from Concoct for concoct
  --contigs_cut_up_file_hid CONTIGS_CUT_UP_FILE_HID
                        Historic ID to contigs cut up fasta file from Galaxy
                        for concoct
  --coordinates_cut_up_file_path COORDINATES_CUT_UP_FILE_PATH
                        Coordinates contigs cut up bed file from Concoct for
                        concoct
  --coordinates_cut_up_file_hid COORDINATES_CUT_UP_FILE_HID
                        Historic ID to coordinates contigs cut up bed file
                        from Galaxy for concoct
  --coverage_table_file_path COVERAGE_TABLE_FILE_PATH
                        Coverage table file from Concoct for concoct
  --coverage_table_file_hid COVERAGE_TABLE_FILE_HID
                        Historic ID to coverage table file from Galaxy for
                        concoct
  --log_file_path LOG_FILE_PATH
                        Log file from Concoct for concoct
  --log_file_hid LOG_FILE_HID
                        Historic ID to Concoct log file from Galaxy for
                        concoct
```


## tooldistillator_coreprofiler

### Tool Description
Extract information from output(s) of coreprofiler (results.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py coreprofiler <options>

Extract information from output(s) of coreprofiler (results.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID for coreprofiler file from galaxy for
                        coreprofiler
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        coreprofiler version for coreprofiler
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for coreprofiler
  --profiles_json_path PROFILES_JSON_PATH
                        JSON file containing info about files with temp
                        alleles for coreprofiler
  --profiles_json_hid PROFILES_JSON_HID
                        Historic ID for profiles JSON file from galaxy for
                        coreprofiler
  --alleles_fna_path ALLELES_FNA_PATH
                        FASTA file with new alleles sequences if detected for
                        coreprofiler
  --alleles_fna_hid ALLELES_FNA_HID
                        Historic ID for new alleles FASTA file from galaxy for
                        coreprofiler
```


## tooldistillator_coverm

### Tool Description
Extract information from output(s) of coverm (coverage_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py coverm <options>

Extract information from output(s) of coverm (coverage_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        coverm version number for coverm
  --hid HID             historic ID for coverm file from galaxy for coverm
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for coverm
  --dereplication_cluster_definition_path DEREPLICATION_CLUSTER_DEFINITION_PATH
                        dereplicated representative and member lines file for
                        coverm
  --dereplication_cluster_definition_hid DEREPLICATION_CLUSTER_DEFINITION_HID
                        historic ID for dereplicated representative and member
                        lines file from galaxy for coverm
  --dereplication_representative_fasta_zip_path DEREPLICATION_REPRESENTATIVE_FASTA_ZIP_PATH
                        representative genome files in a ZIP file for coverm
  --dereplication_representative_fasta_zip_hid DEREPLICATION_REPRESENTATIVE_FASTA_ZIP_HID
                        historic ID for representative genome ZIP file from
                        galaxy for coverm
```


## tooldistillator_dastool

### Tool Description
Extract information from output(s) of dastool (summary.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py dastool <options>

Extract information from output(s) of dastool (summary.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to DasTool clusters file from Galaxy for
                        dastool
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        DasTool version number for dastool
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for dastool
  --fasta_bin_zip_folder_path FASTA_BIN_ZIP_FOLDER_PATH
                        Bin fasta format ZIP folder for DasTool for dastool
  --fasta_bin_zip_folder_hid FASTA_BIN_ZIP_FOLDER_HID
                        Historic ID to bin fasta format ZIP folder from Galaxy
                        for dastool
  --contig_to_bin_file_path CONTIG_TO_BIN_FILE_PATH
                        Contig to bin file from DasTool for dastool
  --contig_to_bin_file_hid CONTIG_TO_BIN_FILE_HID
                        Historic ID to contig to bin file from Galaxy for
                        dastool
  --quality_and_completness_file_path QUALITY_AND_COMPLETNESS_FILE_PATH
                        Quality and completness file from DasTool for dastool
  --quality_and_completness_file_hid QUALITY_AND_COMPLETNESS_FILE_HID
                        Historic ID to quality and completness file from
                        Galaxy for dastool
  --protein_sequences_file_path PROTEIN_SEQUENCES_FILE_PATH
                        Protein sequences file from DasTool for dastool
  --protein_sequences_file_hid PROTEIN_SEQUENCES_FILE_HID
                        Historic ID to protein sequences file from Galaxy for
                        dastool
  --unbinned_sequences_file_path UNBINNED_SEQUENCES_FILE_PATH
                        Unbinned sequences file from DasTool for dastool
  --unbinned_sequences_file_hid UNBINNED_SEQUENCES_FILE_HID
                        Historic ID to unbinned sequences file from Galaxy for
                        dastool
  --log_file_path LOG_FILE_PATH
                        Log file from DasTool for dastool
  --log_file_hid LOG_FILE_HID
                        Historic ID to DasTool log file from Galaxy for
                        dastool
```


## tooldistillator_deeparg

### Tool Description
Extract information from output(s) of deeparg (report.txt)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py deeparg <options>

Extract information from output(s) of deeparg (report.txt)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        deeparg version for deeparg
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for deeparg
  --hid HID             historic ID for deeparg file from galaxy for deeparg
  --report_ARG_merged_path REPORT_ARG_MERGED_PATH
                        DeepARG ARG merged report file for deeparg
  --report_ARG_merged_hid REPORT_ARG_MERGED_HID
                        historic ID to ARG merged report file from Galaxy for
                        deeparg
  --report_ARG_merged_quant_subtype_path REPORT_ARG_MERGED_QUANT_SUBTYPE_PATH
                        DeepARG ARG merged quant subtype report file for
                        deeparg
  --report_ARG_merged_quant_subtype_hid REPORT_ARG_MERGED_QUANT_SUBTYPE_HID
                        historic ID to ARG merged quant subtype report file
                        from Galaxy for deeparg
  --report_ARG_merged_quant_type_path REPORT_ARG_MERGED_QUANT_TYPE_PATH
                        DeepARG ARG merged quant type report file for deeparg
  --report_ARG_merged_quant_type_hid REPORT_ARG_MERGED_QUANT_TYPE_HID
                        historic ID to ARG merged quant type report file from
                        Galaxy for deeparg
  --report_potential_ARG_path REPORT_POTENTIAL_ARG_PATH
                        DeepARG potential ARG report file for deeparg
  --report_potential_ARG_hid REPORT_POTENTIAL_ARG_HID
                        historic ID to potential ARG report file from Galaxy
                        for deeparg
  --sequence_clean_file_path SEQUENCE_CLEAN_FILE_PATH
                        Sequence clean file from deeparg for deeparg
  --sequence_clean_file_hid SEQUENCE_CLEAN_FILE_HID
                        Historic ID to sequence clean file from Galaxy for
                        deeparg
  --bam_clean_file_path BAM_CLEAN_FILE_PATH
                        Binary Alignment clean file from deeparg for deeparg
  --bam_clean_file_hid BAM_CLEAN_FILE_HID
                        Historic ID to clean alignment file from Galaxy for
                        deeparg
  --sam_clean_file_path SAM_CLEAN_FILE_PATH
                        Sequence Alignment clean file from deeparg for deeparg
  --sam_clean_file_hid SAM_CLEAN_FILE_HID
                        Historic ID to clean alignment file from Galaxy for
                        deeparg
  --bam_clean_sorted_file_path BAM_CLEAN_SORTED_FILE_PATH
                        Binary Alignment clean sorted file from deeparg for
                        deeparg
  --bam_clean_sorted_file_hid BAM_CLEAN_SORTED_FILE_HID
                        Historic ID to clean sorted alignment file from Galaxy
                        for deeparg
  --daa_clean_align_file_path DAA_CLEAN_ALIGN_FILE_PATH
                        DAA clean align file from deeparg for deeparg
  --daa_clean_align_file_hid DAA_CLEAN_ALIGN_FILE_HID
                        Historic ID to daa sorted alignment file from Galaxy
                        for deeparg
```


## tooldistillator_drep

### Tool Description
Extract information from output(s) of drep (quality_and_cluster_summary.csv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py drep <options>

Extract information from output(s) of drep (quality_and_cluster_summary.csv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to dRep clusters file from Galaxy for drep
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        dRep version number for drep
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for drep
  --fasta_dereplicated_bin_zip_folder_path FASTA_DEREPLICATED_BIN_ZIP_FOLDER_PATH
                        Dereplicated bin fasta format ZIP folder for dRep for
                        drep
  --fasta_dereplicated_bin_zip_folder_hid FASTA_DEREPLICATED_BIN_ZIP_FOLDER_HID
                        Historic ID to dereplicated bin fasta format ZIP
                        folder from Galaxy for drep
  --bdb_file_path BDB_FILE_PATH
                        Bdb file for dRep for drep
  --bdb_file_hid BDB_FILE_HID
                        Historic ID to Bdb file from Galaxy for drep
  --cdb_file_path CDB_FILE_PATH
                        Cdb file for dRep for drep
  --cdb_file_hid CDB_FILE_HID
                        Historic ID to Cdb file from Galaxy for drep
  --chdb_file_path CHDB_FILE_PATH
                        Chdb file for dRep for drep
  --chdb_file_hid CHDB_FILE_HID
                        Historic ID to Chdb file from Galaxy for drep
  --mdb_file_path MDB_FILE_PATH
                        Mdb file for dRep for drep
  --mdb_file_hid MDB_FILE_HID
                        Historic ID to Mdb file from Galaxy for drep
  --ndb_file_path NDB_FILE_PATH
                        Ndb file for dRep for drep
  --ndb_file_hid NDB_FILE_HID
                        Historic ID to Ndb file from Galaxy for drep
  --sdb_file_path SDB_FILE_PATH
                        Sdb file for dRep for drep
  --sdb_file_hid SDB_FILE_HID
                        Historic ID to Sdb file from Galaxy for drep
  --wdb_file_path WDB_FILE_PATH
                        Wdb file for dRep for drep
  --wdb_file_hid WDB_FILE_HID
                        Historic ID to Wdb file from Galaxy for drep
  --winning_genomes_pdf_path WINNING_GENOMES_PDF_PATH
                        Winning genomes pdf file for dRep for drep
  --winning_genomes_pdf_hid WINNING_GENOMES_PDF_HID
                        Historic ID to winning genomes pdf file from Galaxy
                        for drep
  --cluster_scoring_pdf_path CLUSTER_SCORING_PDF_PATH
                        Cluster scoring pdf file for dRep for drep
  --cluster_scoring_pdf_hid CLUSTER_SCORING_PDF_HID
                        Historic ID to cluster scoring pdf file from Galaxy
                        for drep
  --clustering_scatterplots_pdf_path CLUSTERING_SCATTERPLOTS_PDF_PATH
                        Clustering scatterplots pdf file for dRep for drep
  --clustering_scatterplots_pdf_hid CLUSTERING_SCATTERPLOTS_PDF_HID
                        Historic ID to clustering scatterplots pdf file from
                        Galaxy for drep
  --primary_clustering_dendrogram_pdf_path PRIMARY_CLUSTERING_DENDROGRAM_PDF_PATH
                        Primary clustering dendrogram pdf file for dRep for
                        drep
  --primary_clustering_dendrogram_pdf_hid PRIMARY_CLUSTERING_DENDROGRAM_PDF_HID
                        Historic ID to primary clustering dendrogram pdf file
                        from Galaxy for drep
  --secondary_clustering_dendrogram_pdf_path SECONDARY_CLUSTERING_DENDROGRAM_PDF_PATH
                        Secondary clustering dendrogram pdf file for dRep for
                        drep
  --secondary_clustering_dendrogram_pdf_hid SECONDARY_CLUSTERING_DENDROGRAM_PDF_HID
                        Historic ID to secondary clustering dendrogram pdf
                        file from Galaxy for drep
  --secondary_clustering_mds_pdf_path SECONDARY_CLUSTERING_MDS_PDF_PATH
                        Secondary clustering MDS pdf file for dRep for drep
  --secondary_clustering_mds_pdf_hid SECONDARY_CLUSTERING_MDS_PDF_HID
                        Historic ID to secondary clustering MDS pdf file from
                        Galaxy for drep
  --log_file_path LOG_FILE_PATH
                        Log file from dRep for drep
  --log_file_hid LOG_FILE_HID
                        Historic ID to dRep log file from Galaxy for drep
```


## tooldistillator_eggnogmapper

### Tool Description
Extract information from output(s) of eggnogmapper (annotations_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py eggnogmapper <options>

Extract information from output(s) of eggnogmapper (annotations_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to eggnogmapper annotation file from
                        Galaxy for eggnogmapper
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        eggnogmapper version number for eggnogmapper
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for eggnogmapper
  --seed_orthologs_report_path SEED_ORTHOLOGS_REPORT_PATH
                        Seed orthologs report file for eggnogmapper
  --seed_orthologs_report_hid SEED_ORTHOLOGS_REPORT_HID
                        Historic ID to seed orthologs report file from Galaxy
                        for eggnogmapper
  --orthologs_report_path ORTHOLOGS_REPORT_PATH
                        Orthologs report file for eggnogmapper
  --orthologs_report_hid ORTHOLOGS_REPORT_HID
                        Historic ID to orthologs report file from Galaxy for
                        eggnogmapper
```


## tooldistillator_fastp

### Tool Description
Extract information from output(s) of fastp (report.json)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py fastp <options>

Extract information from output(s) of fastp (report.json)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        fastp version number for fastp
  --hid HID             historic ID for fastp file from galaxy for fastp
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for fastp
  --trimmed_forward_R1_path TRIMMED_FORWARD_R1_PATH
                        forward R1 trimmed file for fastp
  --trimmed_forward_R1_hid TRIMMED_FORWARD_R1_HID
                        historic ID for forward reads file from galaxy for
                        fastp
  --trimmed_reverse_R2_path TRIMMED_REVERSE_R2_PATH
                        reverse R2 trimmed file for fastp
  --trimmed_reverse_R2_hid TRIMMED_REVERSE_R2_HID
                        historic ID for reverse reads file from galaxy for
                        fastp
  --html_report_path HTML_REPORT_PATH
                        html fastp report path for fastp
  --html_report_hid HTML_REPORT_HID
                        historic ID for fastp html report for fastp
```


## tooldistillator_fastqc

### Tool Description
Extract information from output(s) of fastqc (report.txt)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py fastqc <options>

Extract information from output(s) of fastqc (report.txt)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        fastqc version number for fastqc
  --hid HID             historic ID for fastqc file from galaxy for fastqc
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for fastqc
  --html_report_path HTML_REPORT_PATH
                        html fastqc report path for fastqc
  --html_report_hid HTML_REPORT_HID
                        historic ID for fastqc html report for fastqc
```


## tooldistillator_filtlong

### Tool Description
Extract information from output(s) of filtlong (input.fastq)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py filtlong <options>

Extract information from output(s) of filtlong (input.fastq)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        filtlong version number for filtlong
  --hid HID             Historic ID to filtlong contigs file from Galaxy for
                        filtlong
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for filtlong
```


## tooldistillator_flye

### Tool Description
Extract information from output(s) of flye (contig.fasta)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py flye <options>

Extract information from output(s) of flye (contig.fasta)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to flye contigs file from Galaxy for flye
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        flye version number for flye
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for flye
  --contig_graph_path CONTIG_GRAPH_PATH
                        Assembly graph file for flye
  --contig_graph_hid CONTIG_GRAPH_HID
                        Historic ID to assembly graph from Galaxy for flye
  --tsv_file_path TSV_FILE_PATH
                        Assembly info file from flye for flye
  --tsv_file_hid TSV_FILE_HID
                        Historic ID to assembly info file from Galaxy for flye
```


## tooldistillator_groot

### Tool Description
Extract information from output(s) of groot (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py groot <options>

Extract information from output(s) of groot (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        groot version for groot
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for groot
  --hid HID             historic ID for groot file from galaxy for groot
  --groot_log_path GROOT_LOG_PATH
                        Groot log file for groot
  --groot_log_hid GROOT_LOG_HID
                        historic ID for Groot log file from galaxy for groot
  --bam_file_path BAM_FILE_PATH
                        Binary Alignment file from groot for groot
  --bam_file_hid BAM_FILE_HID
                        Historic ID to alignment file from Galaxy for groot
```


## tooldistillator_gtdbtk

### Tool Description
Extract information from output(s) of gtdbtk (tax_summary.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py gtdbtk <options>

Extract information from output(s) of gtdbtk (tax_summary.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to GTDB-tk annotation file from Galaxy for
                        gtdbtk
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        GTDB-tk version number for gtdbtk
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for gtdbtk
  --classify_directory_path CLASSIFY_DIRECTORY_PATH
                        Classify ZIP directory path for gtdbtk
  --classify_directory_hid CLASSIFY_DIRECTORY_HID
                        Historic ID to classify directory from Galaxy for
                        gtdbtk
  --align_directory_path ALIGN_DIRECTORY_PATH
                        Align ZIP directory path for gtdbtk
  --align_directory_hid ALIGN_DIRECTORY_HID
                        Historic ID to align directory from Galaxy for gtdbtk
  --identify_directory_path IDENTIFY_DIRECTORY_PATH
                        Identify ZIP directory path for gtdbtk
  --identify_directory_hid IDENTIFY_DIRECTORY_HID
                        Historic ID to identify directory from Galaxy for
                        gtdbtk
  --log_file_path LOG_FILE_PATH
                        Log file path for gtdbtk
  --log_file_hid LOG_FILE_HID
                        Historic ID to log file from Galaxy for gtdbtk
```


## tooldistillator_integronfinder2

### Tool Description
Extract information from output(s) of integronfinder2 (OUTPUT.integrons, OUTPUT.summary)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py integronfinder2 <options>

Extract information from output(s) of integronfinder2 (OUTPUT.integrons,
OUTPUT.summary)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             historic ID for integronfinder file from galaxy for
                        integronfinder2
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        integronfinder version for integronfinder2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for integronfinder2
  --summary_file_path SUMMARY_FILE_PATH
                        integronfinder summary file path for integronfinder2
  --summary_file_hid SUMMARY_FILE_HID
                        historic ID for summary file from galaxy for
                        integronfinder2
```


## tooldistillator_isescan

### Tool Description
Extract information from output(s) of isescan (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py isescan <options>

Extract information from output(s) of isescan (OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID for isescan file from galaxy for isescan
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        isescan version for isescan
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for isescan
  --orf_fna_path ORF_FNA_PATH
                        fasta file with nucleotide orf sequences for isescan
  --orf_fna_hid ORF_FNA_HID
                        Historic ID for orf fasta file from galaxy for isescan
  --orf_faa_path ORF_FAA_PATH
                        fasta file with amino acide orf sequences for isescan
  --orf_faa_hid ORF_FAA_HID
                        Historic ID for orf amino acid file from galaxy for
                        isescan
  --is_fna_path IS_FNA_PATH
                        fasta file with nucleotide IS sequences for isescan
  --is_fna_hid IS_FNA_HID
                        Historic ID for IS file from galaxy for isescan
  --summary_path SUMMARY_PATH
                        summary of isescan analysis for isescan
  --summary_hid SUMMARY_HID
                        Historic ID for summary file from galaxy for isescan
  --annotation_path ANNOTATION_PATH
                        isescan annotation gff3 file for isescan
  --annotation_hid ANNOTATION_HID
                        Historic ID for gff annotation file from galaxy for
                        isescan
```


## tooldistillator_kraken2

### Tool Description
Extract information from output(s) of kraken2 (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py kraken2 <options>

Extract information from output(s) of kraken2 (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             kraken report hid for kraken2
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        kraken2 version for kraken2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        kraken2 DB version for kraken2
  --seq_classification_file_path SEQ_CLASSIFICATION_FILE_PATH
                        file containing the classification of each reads for
                        kraken2
  --seq_classification_file_hid SEQ_CLASSIFICATION_FILE_HID
                        historic ID for read classification file from Galaxy
                        for kraken2
```


## tooldistillator_maxbin2

### Tool Description
Extract information from output(s) of maxbin2 (bin_summary.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py maxbin2 <options>

Extract information from output(s) of maxbin2 (bin_summary.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to Maxbin2 contigs file from Galaxy for
                        maxbin2
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Maxbin2 version number for maxbin2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for maxbin2
  --fasta_bin_zip_folder_path FASTA_BIN_ZIP_FOLDER_PATH
                        Bin fasta format ZIP folder for Maxbin2 for maxbin2
  --fasta_bin_zip_folder_hid FASTA_BIN_ZIP_FOLDER_HID
                        Historic ID to bin fasta format ZIP folder from Galaxy
                        for maxbin2
  --bin_predicted_markers_zip_folder_path BIN_PREDICTED_MARKERS_ZIP_FOLDER_PATH
                        Bin predicted markers ZIP folder for Maxbin2 for
                        maxbin2
  --bin_predicted_markers_zip_folder_hid BIN_PREDICTED_MARKERS_ZIP_FOLDER_HID
                        Historic ID to bin predicted markers ZIP folder from
                        Galaxy for maxbin2
  --too_short_sequences_file_path TOO_SHORT_SEQUENCES_FILE_PATH
                        Too short sequences file from Maxbin2 for maxbin2
  --too_short_sequences_file_hid TOO_SHORT_SEQUENCES_FILE_HID
                        Historic ID to too short sequences file from Galaxy
                        for maxbin2
  --unclassified_sequences_file_path UNCLASSIFIED_SEQUENCES_FILE_PATH
                        Unclassified sequences file from Maxbin2 for maxbin2
  --unclassified_sequences_file_hid UNCLASSIFIED_SEQUENCES_FILE_HID
                        Historic ID to unclassified sequences file from Galaxy
                        for maxbin2
  --marker_gene_presence_file_path MARKER_GENE_PRESENCE_FILE_PATH
                        Marker gene presence file from Maxbin2 for maxbin2
  --marker_gene_presence_file_hid MARKER_GENE_PRESENCE_FILE_HID
                        Historic ID to marker gene presence file from Galaxy
                        for maxbin2
  --marker_gene_presence_plot_path MARKER_GENE_PRESENCE_PLOT_PATH
                        Marker gene presence plot from Maxbin2 for maxbin2
  --marker_gene_presence_plot_hid MARKER_GENE_PRESENCE_PLOT_HID
                        Historic ID to marker gene presence plot from Galaxy
                        for maxbin2
  --log_file_path LOG_FILE_PATH
                        Log file from Maxbin2 for maxbin2
  --log_file_hid LOG_FILE_HID
                        Historic ID to Maxbin2 log file from Galaxy for
                        maxbin2
```


## tooldistillator_megahit

### Tool Description
Extract information from output(s) of megahit (contig.fasta)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py megahit <options>

Extract information from output(s) of megahit (contig.fasta)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to megahit contigs file from Galaxy for
                        megahit
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        megahit version number for megahit
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for megahit
  --intermediate_contig_folder_path INTERMEDIATE_CONTIG_FOLDER_PATH
                        Intermediate contig folder for Megahit assembly for
                        megahit
  --intermediate_contig_folder_hid INTERMEDIATE_CONTIG_FOLDER_HID
                        Historic ID to intermediate contig folder from Galaxy
                        for megahit
  --log_file_path LOG_FILE_PATH
                        Log file from megahit for megahit
  --log_file_hid LOG_FILE_HID
                        Historic ID to megahit log file from Galaxy for
                        megahit
```


## tooldistillator_metabat2

### Tool Description
Extract information from output(s) of metabat2 (depth.txt)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py metabat2 <options>

Extract information from output(s) of metabat2 (depth.txt)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to Metabat2 clusters file from Galaxy for
                        metabat2
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Metabat2 version number for metabat2
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for metabat2
  --fasta_bin_zip_folder_path FASTA_BIN_ZIP_FOLDER_PATH
                        Bin fasta format ZIP folder for Metabat2 for metabat2
  --fasta_bin_zip_folder_hid FASTA_BIN_ZIP_FOLDER_HID
                        Historic ID to bin fasta format ZIP folder from Galaxy
                        for metabat2
  --too_short_sequences_file_path TOO_SHORT_SEQUENCES_FILE_PATH
                        Too short sequences file from Metabat2 for metabat2
  --too_short_sequences_file_hid TOO_SHORT_SEQUENCES_FILE_HID
                        Historic ID to too short sequences file from Galaxy
                        for metabat2
  --unbinned_sequences_file_path UNBINNED_SEQUENCES_FILE_PATH
                        Unbinned sequences file from Metabat2 for metabat2
  --unbinned_sequences_file_hid UNBINNED_SEQUENCES_FILE_HID
                        Historic ID to unbinned sequences file from Galaxy for
                        metabat2
  --low_depth_sequences_file_path LOW_DEPTH_SEQUENCES_FILE_PATH
                        Low depth file from Metabat2 for metabat2
  --low_depth_sequences_file_hid LOW_DEPTH_SEQUENCES_FILE_HID
                        Historic ID to low depth sequences file from Galaxy
                        for metabat2
```


## tooldistillator_mmseqs2linclust

### Tool Description
Extract information from output(s) of mmseqs2linclust (contig.fasta)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py mmseqs2linclust <options>

Extract information from output(s) of mmseqs2linclust (contig.fasta)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to mmseqs2 linclust representative
                        sequence file from Galaxy for mmseqs2linclust
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        mmseqs2 version number for mmseqs2linclust
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for mmseqs2linclust
  --cluster_fasta_like_path CLUSTER_FASTA_LIKE_PATH
                        Cluster FASTA-like format for mmseqs2linclust
  --cluster_fasta_like_hid CLUSTER_FASTA_LIKE_HID
                        Historic ID to cluster FASTA-like format from Galaxy
                        for mmseqs2linclust
  --tsv_file_path TSV_FILE_PATH
                        Cluster TSV file from mmseqs2 linclust for
                        mmseqs2linclust
  --tsv_file_hid TSV_FILE_HID
                        Historic ID to cluster TSV file from Galaxy for
                        mmseqs2linclust
```


## tooldistillator_mmseqs2taxonomy

### Tool Description
Extract information from output(s) of mmseqs2taxonomy (tax_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py mmseqs2taxonomy <options>

Extract information from output(s) of mmseqs2taxonomy (tax_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to mmseqs2 taxonomy representative
                        sequence file from Galaxy for mmseqs2taxonomy
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        mmseqs2 version number for mmseqs2taxonomy
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for mmseqs2taxonomy
  --kraken_report_path KRAKEN_REPORT_PATH
                        Taxonomy report Kraken format for mmseqs2taxonomy
  --kraken_report_hid KRAKEN_REPORT_HID
                        Historic ID to taxonomy Kraken file from Galaxy for
                        mmseqs2taxonomy
  --krona_report_path KRONA_REPORT_PATH
                        Taxonomy report Krona format for mmseqs2taxonomy
  --krona_report_hid KRONA_REPORT_HID
                        Historic ID to taxonomy Krona file from Galaxy for
                        mmseqs2taxonomy
```


## tooldistillator_multiqc

### Tool Description
Extract information from output(s) of multiqc (output.html)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py multiqc <options>

Extract information from output(s) of multiqc (output.html)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        multiqc version for multiqc
  --hid HID             historic ID for multiqc file from galaxy for multiqc
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for multiqc
```


## tooldistillator_plasmidfinder

### Tool Description
Extract information from output(s) of plasmidfinder (plasmidfinder.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py plasmidfinder <options>

Extract information from output(s) of plasmidfinder (plasmidfinder.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID for plasmidfinder file from galaxy for
                        plasmidfinder
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        plasmidfinder version for plasmidfinder
  --reference_database_version REFERENCE_DATABASE_VERSION
                        plasmidfinder DB version for plasmidfinder
  --plasmid_result_tabular_path PLASMID_RESULT_TABULAR_PATH
                        plasmidfinder results in tabular format for
                        plasmidfinder
  --plasmid_result_tabular_hid PLASMID_RESULT_TABULAR_HID
                        plasmidfinder results hid in Galaxy for plasmidfinder
  --genome_hit_path GENOME_HIT_PATH
                        fasta file with hits in genome, doesn't work for
                        multiple input for plasmidfinder
  --genome_hit_hid GENOME_HIT_HID
                        Historic ID for genome hit file from galaxy for
                        plasmidfinder
  --plasmid_hit_path PLASMID_HIT_PATH
                        fasta file with plasmid sequences, doesn't work for
                        multiple input for plasmidfinder
  --plasmid_hit_hid PLASMID_HIT_HID
                        Historic ID for plasmid sequence hit file from galaxy
                        for plasmidfinder
```


## tooldistillator_polypolish

### Tool Description
Extract information from output(s) of polypolish (contig.fasta)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py polypolish <options>

Extract information from output(s) of polypolish (contig.fasta)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to polypolish contigs file from Galaxy for
                        polypolish
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        polypolish version number for polypolish
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for polypolish
```


## tooldistillator_prodigal

### Tool Description
Extract information from output(s) of prodigal (gene_coordinates.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py prodigal <options>

Extract information from output(s) of prodigal (gene_coordinates.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             historic ID for Prodigal file from galaxy for prodigal
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Prodigal version number for prodigal
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for prodigal
  --protein_translation_file_path PROTEIN_TRANSLATION_FILE_PATH
                        Proteins from all the sequences fasta file for
                        prodigal for prodigal
  --protein_translation_file_hid PROTEIN_TRANSLATION_FILE_HID
                        Historic ID to proteins fasta file from Galaxy for
                        prodigal
  --potential_gene_start_file_path POTENTIAL_GENE_START_FILE_PATH
                        Potential genes start file for prodigal for prodigal
  --potential_gene_start_file_hid POTENTIAL_GENE_START_FILE_HID
                        Historic ID to potential genes start file from Galaxy
                        for prodigal
  --gbk_genes_coordinate_file_path GBK_GENES_COORDINATE_FILE_PATH
                        GBK genes coordinate file for prodigal for prodigal
  --gbk_genes_coordinate_file_hid GBK_GENES_COORDINATE_FILE_HID
                        Historic ID to GBK genes coordinate file from Galaxy
                        for prodigal
  --gff_genes_coordinate_file_path GFF_GENES_COORDINATE_FILE_PATH
                        GFF3 genes coordinate file for prodigal for prodigal
  --gff_genes_coordinate_file_hid GFF_GENES_COORDINATE_FILE_HID
                        Historic ID to GFF3 genes coordinate file from Galaxy
                        for prodigal
  --sco_genes_coordinate_file_path SCO_GENES_COORDINATE_FILE_PATH
                        SCO genes coordinate file for prodigal for prodigal
  --sco_genes_coordinate_file_hid SCO_GENES_COORDINATE_FILE_HID
                        Historic ID to SCO genes coordinate file from Galaxy
                        for prodigal
```


## tooldistillator_quast

### Tool Description
Extract information from output(s) of quast (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py quast <options>

Extract information from output(s) of quast (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to quast file from Galaxy for quast
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for quast
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Quast version number for quast
  --quast_html_path QUAST_HTML_PATH
                        Quast html report file for quast
  --quast_html_hid QUAST_HTML_HID
                        Historic ID to quast html file from Galaxy for quast
```


## tooldistillator_recentrifuge

### Tool Description
Extract information from output(s) of recentrifuge (data.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py recentrifuge <options>

Extract information from output(s) of recentrifuge (data.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             historic ID to recentrifuge data file provided by
                        Galaxy for recentrifuge
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        recentrifuge version for recentrifuge
  --reference_database_version REFERENCE_DATABASE_VERSION
                        ncbi taxonomy DB version for recentrifuge
  --rcf_stat_path RCF_STAT_PATH
                        recentrifuge statistic file for recentrifuge
  --rcf_stat_hid RCF_STAT_HID
                        historic ID provided by Galaxy for recentrifuge
  --rcf_html_path RCF_HTML_PATH
                        recentrifuge html report file for recentrifuge
  --rcf_html_hid RCF_HTML_HID
                        recentrifuge html report file for recentrifuge
```


## tooldistillator_refseqmasher

### Tool Description
Extract information from output(s) of refseqmasher (OUTPUT.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py refseqmasher <options>

Extract information from output(s) of refseqmasher (OUTPUT.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to refseq result from Galaxy for
                        refseqmasher
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for refseqmasher
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        refseqmasher version number for refseqmasher
```


## tooldistillator_shovill

### Tool Description
Extract information from output(s) of shovill (contig.fasta)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py shovill <options>

Extract information from output(s) of shovill (contig.fasta)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID to shovill contigs file from Galaxy for
                        shovill
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        shovill version number for shovill
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for shovill
  --contig_graph_path CONTIG_GRAPH_PATH
                        Assembly graph file for shovill
  --contig_graph_hid CONTIG_GRAPH_HID
                        Historic ID to assembly graph from Galaxy for shovill
  --bam_file_path BAM_FILE_PATH
                        Binary Alignment file from shovill for shovill
  --bam_file_hid BAM_FILE_HID
                        Historic ID to alignment file from Galaxy for shovill
```


## tooldistillator_staramr

### Tool Description
Extract information from output(s) of staramr (resfinder.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py staramr <options>

Extract information from output(s) of staramr (resfinder.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID provided by Galaxy for resfinder file for
                        staramr
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        tool version for staramr
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for staramr
  --mlst_file_path MLST_FILE_PATH
                        mlst output file from staramr for staramr
  --mlst_file_hid MLST_FILE_HID
                        Historic ID provided by Galaxy for mlst file for
                        staramr
  --plasmidfinder_file_path PLASMIDFINDER_FILE_PATH
                        plasmid output file from staramr for staramr
  --plasmidfinder_file_hid PLASMIDFINDER_FILE_HID
                        Historic ID provided by Galaxy for plasmid for staramr
  --pointfinder_file_path POINTFINDER_FILE_PATH
                        pointfinder output file from staramr for staramr
  --pointfinder_file_hid POINTFINDER_FILE_HID
                        Historic ID provided by Galaxy for pointfinder for
                        staramr
  --setting_file_path SETTING_FILE_PATH
                        setting file from staramr analysis for staramr
  --setting_file_hid SETTING_FILE_HID
                        Historic ID provided by Galaxy for settings for
                        staramr
```


## tooldistillator_sylph

### Tool Description
Extract information from output(s) of sylph (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py sylph <options>

Extract information from output(s) of sylph (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        sylph version number for sylph
  --hid HID             historic ID for sylph file from galaxy for sylph
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for sylph
```


## tooldistillator_sylphtax

### Tool Description
Extract information from output(s) of sylphtax (merge_report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py sylphtax <options>

Extract information from output(s) of sylphtax (merge_report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        sylph-tax version number for sylphtax
  --hid HID             historic ID for sylph-tax file from galaxy for
                        sylphtax
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for sylphtax
  --taxonomic_profile_folder_path TAXONOMIC_PROFILE_FOLDER_PATH
                        Taxonomic profile folder for sylph-tax for sylphtax
  --taxonomic_profile_folder_hid TAXONOMIC_PROFILE_FOLDER_HID
                        Historic ID to taxonomic profile folder from Galaxy
                        for sylphtax
```


## tooldistillator_tabular_file

### Tool Description
Extract information from output(s) of tabular_file (report.tsv)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py tabular_file <options>

Extract information from output(s) of tabular_file (report.tsv)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --hid HID             Historic ID provided by Galaxy for tabular file for
                        tabular_file
  --analysis_software_name ANALYSIS_SOFTWARE_NAME
                        Tool name to the input file for tabular_file
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for tabular_file
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        Software version to the input file for tabular_file
```


## tooldistillator_tooltest

### Tool Description
Extract information from output(s) of tooltest (unitest)

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator.py tooltest <options>

Extract information from output(s) of tooltest (unitest)

positional arguments:
  report                Path to report(s)

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output location
  --analysis_software_version ANALYSIS_SOFTWARE_VERSION
                        abricate version for tooltest
  --reference_database_version REFERENCE_DATABASE_VERSION
                        DB version for tooltest
  --hid HID             historic ID for abricate file from galaxy for tooltest
```


## tooldistillator_summarize

### Tool Description
Aggregate several reports

### Metadata
- **Docker Image**: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
- **Homepage**: https://gitlab.com/ifb-elixirfr/abromics
- **Package**: https://anaconda.org/channels/bioconda/packages/tooldistillator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tooldistillator summarize <options> <list of reports>

Aggregate several reports

positional arguments:
  tooldistillator_reports
                        list of tooldistillator reports

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output file path for summary
  -f, --force           Overwrite to the output file mandatory
```


## Metadata
- **Skill**: not generated
