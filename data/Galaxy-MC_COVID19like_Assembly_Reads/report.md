# MC_COVID19like_Assembly_Reads CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://covid19.galaxyproject.org/genomics/2-assembly/
- **Package**: https://workflowhub.eu/workflows/68
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/68/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 1.6K
- **Last updated**: 2023-02-13
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-MC_COVID19like_Assembly_Reads.ga` (Main Workflow)
- **Project**: Italy-Covid-data-Portal
- **Views**: 7962

## Description

This WF is based on the official Covid19-Galaxy assembly workflow as available from https://covid19.galaxyproject.org/genomics/2-assembly/ . It has been adapted to suit the needs of the analysis of metagenomics sequencing data. Prior to be submitted to INDSC databases, these data need to be cleaned from contaminant reads, including reads of possible human origin. 

The assembly of the SARS-CoV-2 genome is performed using both the Unicycler and the SPAdes assemblers, similar to the original WV.

To facilitate the deposition of raw sequencing reads in INDSC databases, different fastq files are saved during the different steps of the WV. Which reflect different levels of stringency/filtration:

(1) Initially fastq are filtered to remove human reads. 
(2) Subsequently, a similarity search is performed against the reference assembly of the SARS-CoV-2 genome, to retain only SARS-CoV-2 like reads. 
(3) Finally, SARS-CoV-2 reads are assembled, and the bowtie2 program is used to identify (and save in the corresponding fastq files) only reads that are completely identical to the final assembly of the genome.

Any of the fastq files produced in (1), (2) or (3) are suitable for being submitted in  raw reads repositories. While the files filtered according to (1) are richer and contain more data, including for example genomic sequences of different microbes living in the oral cavity; files filtered according to (3) contain only the reads that are completely identical to the final assembly. This should guarantee that any re-analysis/re-assembly of these always produce consistent and identical results. File obtained at (2) include all the reads in the sequencing reaction that had some degree of similarity with the reference SARS-CoV-2 genome, these may include subgenomic RNAs, but also polymorphic regions/variants in the case of a coinfection by multiple SARS-CoV-2 strains. Consequently, reanalysis of these data is not guarateed to produce identical and consistent results, depending on the parameters used during the assembly. However, these data contain more information.

Please feel free to comment,  ask questions and/or add suggestions
