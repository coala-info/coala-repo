[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinks/)](index.html)

* [Introduction](index.html)
* Data

  + Molecular data
  + [Query](query.html)
  + [Download & Prepare](download_prepare.html)
  + Other data
  + [Clinical data](clinical.html)
  + [Mutation data](mutation.html)
  + [Molecular subtypes](subtypes.html)
  + [ATAC-seq](http://rpubs.com/tiagochst/atac_seq_workshop)
* Analysis

  + [Analysis functions](analysis.html)
  + [Other functions](extension.html)
  + [Importing data to DESeq2](http://rpubs.com/tiagochst/TCGAbiolinks_to_DESEq2)
  + [Glioma classsifier](classifiers.html)
* [Case Study](casestudy.html)

* Workshops
  + TCGA workshop
  + [Workshop - TCGA data analysis](http://rpubs.com/tiagochst/TCGAworkshop)
  + ELMER workshop
  + [Workshop for multi-omics analysis with ELMER](http://rpubs.com/tiagochst/ELMER_workshop)
  + ATAC-Seq workshop
  + [Workshop for ATAC-Seq analysis](http://rpubs.com/tiagochst/atac_seq_workshop)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
* + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)

# TCGAbiolinks: Clinical data

#### 30 October 2025

**TCGAbiolinks** has provided a few functions to search, download and parse clinical data. This section starts by explaining the different sources for clinical information in GDC, followed by the necessary function to access these sources.

---

# Useful information

Different sources

In GDC database the clinical data can be retrieved from different sources:

* indexed clinical: a refined clinical data that is created using the XML files.
* XML files: original source of the data
* BCR Biotab: tsv files parsed from XML files

There are two main differences between the indexed clinical and XML files:

* XML has more information: radiation, drugs information, follow-ups, biospecimen, etc. So the indexed one is only a subset of the XML files
* The indexed data contains the updated data with the follow up information. For example: if the patient is alive in the first time clinical data was collect and the in the next follow-up he is dead, the indexed data will show dead. The XML will have two fields, one for the first time saying he is alive (in the clinical part) and the follow-up saying he is dead.

Other useful clinical information available are:

* Tissue slide image
* Pathology report - Slide image

# BCR Biotab

## Clinical

In this example we will fetch clinical data from BCR Biotab files.

```
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR Biotab"
)
GDCdownload(query)
clinical.BCRtab.all <- GDCprepare(query)
names(clinical.BCRtab.all)
```

```
clinical.BCRtab.all$clinical_drug_acc  %>%
    head  %>%
    DT::datatable(options = list(scrollX = TRUE, keys = TRUE))
```

In this example we will fetch all ACC BCR Biotab files, and look for the ER status.

```
library(TCGAbiolinks)
query <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Clinical",
    data.type = "Clinical Supplement",
    data.format = "BCR Biotab"
)

GDCdownload(query)
clinical_tab_all <- GDCprepare(query)
```

```
# All available tables
names(clinical_tab_all)
```

```
## [1] "clinical_follow_up_v4.0_nte_acc" "clinical_omf_v4.0_acc"
## [3] "clinical_radiation_acc"          "clinical_patient_acc"
## [5] "clinical_drug_acc"               "clinical_follow_up_v4.0_acc"
## [7] "clinical_nte_acc"
```

```
# columns from clinical_patient
dplyr::glimpse(clinical_tab_all$clinical_patient_acc)
```

```
## Rows: 94
## Columns: 84
## $ bcr_patient_uuid                              <chr> "bcr_patient_uuid", "CDE…
## $ bcr_patient_barcode                           <chr> "bcr_patient_barcode", "…
## $ form_completion_date                          <chr> "form_completion_date", …
## $ prospective_collection                        <chr> "tissue_prospective_coll…
## $ retrospective_collection                      <chr> "tissue_retrospective_co…
## $ gender                                        <chr> "gender", "CDE_ID:220060…
## $ race                                          <chr> "race", "CDE_ID:2192199"…
## $ ethnicity                                     <chr> "ethnicity", "CDE_ID:219…
## $ history_other_malignancy                      <chr> "other_dx", "CDE_ID:3382…
## $ history_neoadjuvant_treatment                 <chr> "history_of_neoadjuvant_…
## $ tumor_status                                  <chr> "person_neoplasm_cancer_…
## $ vital_status                                  <chr> "vital_status", "CDE_ID:…
## $ radiation_treatment_adjuvant                  <chr> "radiation_therapy", "CD…
## $ pharmaceutical_tx_adjuvant                    <chr> "postoperative_rx_tx", "…
## $ pharm_tx_mitotane_indicator                   <chr> "mitotane_therapy", "CDE…
## $ pharm_tx_mitotane_adjuvant                    <chr> "mitotane_therapy_adjuva…
## $ pharm_tx_mitotane_theraputic_levels           <chr> "therapeutic_mitotane_le…
## $ pharm_tx_mitotane_theraputic_at_rec           <chr> "therapeutic_mitotane_lv…
## $ pharm_tx_mitotane_for_macro_disease           <chr> "mitotane_therapy_for_ma…
## $ pharm_tx_mitotane_theraputic_macro            <chr> "therapeutic_mitotane_lv…
## $ pharm_tx_mitotane_theraputic_at_prog          <chr> "therapeutic_mitotane_lv…
## $ clinical_status_within_3_mths_surgery         <chr> "post_surgical_procedure…
## $ treatment_outcome_first_course                <chr> "primary_therapy_outcome…
## $ laterality                                    <chr> "laterality", "CDE_ID:82…
## $ histologic_diagnosis                          <chr> "histological_type", "CD…
## $ initial_pathologic_dx_year                    <chr> "year_of_initial_patholo…
## $ ct_scan_preop_indicator                       <chr> "ct_scan", "CDE_ID:35348…
## $ ct_scan_preop_results                         <chr> "ct_scan_findings", "CDE…
## $ lymph_nodes_examined                          <chr> "primary_lymph_node_pres…
## $ lymph_nodes_examined_count                    <chr> "lymph_node_examined_cou…
## $ lymph_nodes_examined_he_count                 <chr> "number_of_lymphnodes_po…
## $ weiss_score_overall                           <chr> "weiss_score", "CDE_ID:3…
## $ mitoses_per_50_hpf                            <chr> "mitoses_count", "CDE_ID…
## $ ajcc_pathologic_tumor_stage                   <chr> "pathologic_stage", "CDE…
## $ residual_tumor                                <chr> "residual_tumor", "CDE_I…
## $ metastatic_dx_confirmed_by                    <chr> "metastatic_neoplasm_con…
## $ metastatic_dx_confirmed_by_other              <chr> "metastatic_neoplasm_con…
## $ metastatic_tumor_site...38                    <chr> "metastatic_neoplasm_ini…
## $ metastatic_tumor_site...39                    <chr> "distant_metastasis_anat…
## $ history_adrenal_hormone_excess                <chr> "excess_adrenal_hormone_…
## $ history_basis_adrenal_hormone_dx              <chr> "excess_adrenal_hormone_…
## $ molecular_studies_others_performed            <chr> "germline_testing_perfor…
## $ new_tumor_event_dx_indicator                  <chr> "new_tumor_event_after_i…
## $ age_at_initial_pathologic_diagnosis           <chr> "age_at_initial_patholog…
## $ atypical_mitotic_figures                      <chr> "atypical_mitotic_figure…
## $ clinical_M                                    <chr> "clinical_M", "CDE_ID:34…
## $ clinical_N                                    <chr> "clinical_N", "CDE_ID:34…
## $ clinical_T                                    <chr> "clinical_T", "CDE_ID:34…
## $ clinical_stage                                <chr> "clinical_stage", "CDE_I…
## $ cytoplasm_presence_less_than_equal_25_percent <chr> "cytoplasm_presence_less…
## $ days_to_birth                                 <chr> "days_to_birth", "CDE_ID…
## $ days_to_death                                 <chr> "days_to_death", "CDE_ID…
## $ days_to_initial_pathologic_diagnosis          <chr> "days_to_initial_patholo…
## $ days_to_last_followup                         <chr> "days_to_last_followup",…
## $ diffuse_architecture                          <chr> "diffuse_architecture", …
## $ disease_code                                  <chr> "disease_code", "CDE_ID:…
## $ extranodal_involvement                        <chr> "extranodal_involvement"…
## $ icd_10                                        <chr> "icd_10", "CDE_ID:322628…
## $ icd_o_3_histology                             <chr> "icd_o_3_histology", "CD…
## $ icd_o_3_site                                  <chr> "icd_o_3_site", "CDE_ID:…
## $ informed_consent_verified                     <chr> "informed_consent_verifi…
## $ invasion_of_tumor_capsule                     <chr> "invasion_of_tumor_capsu…
## $ mitotic_rate                                  <chr> "mitotic_rate", "CDE_ID:…
## $ necrosis                                      <chr> "necrosis", "CDE_ID:3648…
## $ nuclear_grade_III_IV                          <chr> "nuclear_grade_III_IV", …
## $ pathologic_M                                  <chr> "pathologic_M", "CDE_ID:…
## $ pathologic_N                                  <chr> "pathologic_N", "CDE_ID:…
## $ pathologic_T                                  <chr> "pathologic_T", "CDE_ID:…
## $ patient_id                                    <chr> "patient_id", "CDE_ID:",…
## $ project_code                                  <chr> "project_code", "CDE_ID:…
## $ ret                                           <chr> "ret", "CDE_ID:3121628",…
## $ sdha                                          <chr> "sdha", "CDE_ID:3121628"…
## $ sdhaf2_sdh5                                   <chr> "sdhaf2_sdh5", "CDE_ID:3…
## $ sdhb                                          <chr> "sdhb", "CDE_ID:3121628"…
## $ sdhc                                          <chr> "sdhc", "CDE_ID:3121628"…
## $ sdhd                                          <chr> "sdhd", "CDE_ID:3121628"…
## $ sinusoid_invasion                             <chr> "sinusoid_invasion", "CD…
## $ stage_other                                   <chr> "stage_other", "CDE_ID:2…
## $ system_version                                <chr> "system_version", "CDE_I…
## $ tissue_source_site                            <chr> "tissue_source_site", "C…
## $ tmem127                                       <chr> "tmem127", "CDE_ID:31216…
## $ tumor_tissue_site                             <chr> "tumor_tissue_site", "CD…
## $ vhl                                           <chr> "vhl", "CDE_ID:3121628",…
## $ weiss_venous_invasion                         <chr> "weiss_venous_invasion",…
```

## Biospecimen

```
# Biospecimen BCR Biotab
query_biospecimen <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Biospecimen",
    data.type = "Biospecimen Supplement",
    data.format = "BCR Biotab"
)
GDCdownload(query_biospecimen)
biospecimen_tab_all <- GDCprepare(query_biospecimen)
```

```
# All available tables
names(biospecimen_tab_all)
```

```
##  [1] "ssf_normal_controls_acc"           "biospecimen_analyte_acc"
##  [3] "biospecimen_shipment_portion_acc"  "biospecimen_diagnostic_slides_acc"
##  [5] "biospecimen_protocol_acc"          "biospecimen_portion_acc"
##  [7] "ssf_tumor_samples_acc"             "biospecimen_slide_acc"
##  [9] "biospecimen_aliquot_acc"           "biospecimen_sample_acc"
```

```
biospecimen_tab_all$biospecimen_sample_acc  %>%
    head  %>%
    DT::datatable(options = list(scrollX = TRUE, keys = TRUE))
```

# Clinical indexed data

In this example we will fetch clinical indexed data (same as showed in the data portal).

```
clinical <- GDCquery_clinic(project = "TCGA-ACC", type = "clinical")
```

```
clinical %>%
    head %>%
    DT::datatable(
        filter = 'top',
        options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
        rownames = FALSE
    )
```

```
clinical_beataml <- GDCquery_clinic(
    project = "BEATAML1.0-COHORT",
    type = "clinical"
)

clinical_cptac2 <- GDCquery_clinic(
    project = "CPTAC-2",
    type = "clinical"
)

clinical_genie <- GDCquery_clinic(
    project = "GENIE-MSK",
    type = "clinical"
)
```

# XML clinical data

The process to get data directly from the XML are: 1. Use `GDCquery` and `GDCDownload` functions to search/download either biospecimen or clinical XML files 2. Use `GDCprepare_clinic` function to parse the XML files.

The relation between one patient and other clinical information are 1:n, one patient could have several radiation treatments. For that reason, we only give the option to parse individual tables (only drug information, only radiation information,…) The selection of the table is done by the argument `clinical.info`.

clinical.info options to parse information for each data category

| data.category | clinical.info |
| --- | --- |
| Clinical | drug |
| Clinical | admin |
| Clinical | follow\_up |
| Clinical | radiation |
| Clinical | patient |
| Clinical | stage\_event |
| Clinical | new\_tumor\_event |
| Biospecimen | sample |
| Biospecimen | bio\_patient |
| Biospecimen | analyte |
| Biospecimen | aliquot |
| Biospecimen | protocol |
| Biospecimen | portion |
| Biospecimen | slide |
| Other | msi |

Below are several examples fetching clinical data directly from the clinical XML files.

```
query <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Clinical",
    data.format = "bcr xml",
    barcode = c("TCGA-RU-A8FL","TCGA-AA-3972")
)
GDCdownload(query)
clinical <- GDCprepare_clinic(query, clinical.info = "patient")
```

```
clinical %>%
    datatable(filter = 'top',
              options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
              rownames = FALSE)
```

```
clinical.drug <- GDCprepare_clinic(query, clinical.info = "drug")
```

```
clinical.drug %>%
    datatable(filter = 'top',
              options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
              rownames = FALSE)
```

```
clinical.radiation <- GDCprepare_clinic(query, clinical.info = "radiation")
```

```
clinical.radiation %>%
    datatable(filter = 'top',
              options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
              rownames = FALSE)
```

```
clinical.admin <- GDCprepare_clinic(query, clinical.info = "admin")
```

```
clinical.admin %>%
    datatable(filter = 'top',
              options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
              rownames = FALSE)
```

# Diagnostic Slide (SVS format)

```
# Pathology report from harmonized portal
query_harmonized <- GDCquery(
    project = "TCGA-COAD",
    data.category = "Biospecimen",
    data.type = "Slide Image",
    experimental.strategy = "Diagnostic Slide",
    barcode = c("TCGA-RU-A8FL","TCGA-AA-3972")
)
```

```
query_harmonized  %>%
    getResults %>%
    head  %>%
    DT::datatable(options = list(scrollX = TRUE, keys = TRUE))
```

# Filter functions

Also, some functions to work with clinical data are provided.

For example the function `TCGAquery_SampleTypes` will filter barcodes based on a type the argument typesample.

| Argument | Description |  |
| --- | --- | --- |
| barcode | is a list of samples as TCGA barcodes |  |
| typesample | a character vector indicating tissue type to query. Example: |  |
|  | TP | PRIMARY TUMOR |
|  | TR | RECURRENT TUMOR |
|  | TB | Primary Blood Derived Cancer-Peripheral Blood |
|  | TRBM | Recurrent Blood Derived Cancer-Bone Marrow |
|  | TAP | Additional-New Primary |
|  | TM | Metastatic |
|  | TAM | Additional Metastatic |
|  | THOC | Human Tumor Original Cells |
|  | TBM | Primary Blood Derived Cancer-Bone Marrow |
|  | NB | Blood Derived Normal |
|  | NT | Solid Tissue Normal |
|  | NBC | Buccal Cell Normal |
|  | NEBV | EBV Immortalized Normal |
|  | NBM | Bone Marrow Normal |

The function `TCGAquery_MatchedCoupledSampleTypes` will filter the samples that have all the typesample provided as argument. For example, if TP and TR are set as typesample, the function will return the barcodes of a patient if it has both types. So, if it has a TP, but not a TR, no barcode will be returned. If it has a TP and a TR both barcodes are returned.

An example of the function is below:

```
bar <- c(
    "TCGA-G9-6378-02A-11R-1789-07", "TCGA-CH-5767-04A-11R-1789-07",
    "TCGA-G9-6332-60A-11R-1789-07", "TCGA-G9-6336-01A-11R-1789-07",
    "TCGA-G9-6336-11A-11R-1789-07", "TCGA-G9-7336-11A-11R-1789-07",
    "TCGA-G9-7336-04A-11R-1789-07", "TCGA-G9-7336-14A-11R-1789-07",
    "TCGA-G9-7036-04A-11R-1789-07", "TCGA-G9-7036-02A-11R-1789-07",
    "TCGA-G9-7036-11A-11R-1789-07", "TCGA-G9-7036-03A-11R-1789-07",
    "TCGA-G9-7036-10A-11R-1789-07", "TCGA-BH-A1ES-10A-11R-1789-07",
    "TCGA-BH-A1F0-10A-11R-1789-07", "TCGA-BH-A0BZ-02A-11R-1789-07",
    "TCGA-B6-A0WY-04A-11R-1789-07", "TCGA-BH-A1FG-04A-11R-1789-08",
    "TCGA-D8-A1JS-04A-11R-2089-08", "TCGA-AN-A0FN-11A-11R-8789-08",
    "TCGA-AR-A2LQ-12A-11R-8799-08", "TCGA-AR-A2LH-03A-11R-1789-07",
    "TCGA-BH-A1F8-04A-11R-5789-07", "TCGA-AR-A24T-04A-55R-1789-07",
    "TCGA-AO-A0J5-05A-11R-1789-07", "TCGA-BH-A0B4-11A-12R-1789-07",
    "TCGA-B6-A1KN-60A-13R-1789-07", "TCGA-AO-A0J5-01A-11R-1789-07",
    "TCGA-AO-A0J5-01A-11R-1789-07", "TCGA-G9-6336-11A-11R-1789-07",
    "TCGA-G9-6380-11A-11R-1789-07", "TCGA-G9-6380-01A-11R-1789-07",
    "TCGA-G9-6340-01A-11R-1789-07", "TCGA-G9-6340-11A-11R-1789-07"
)

S <- TCGAquery_SampleTypes(bar,"TP")
S2 <- TCGAquery_SampleTypes(bar,"NB")

# Retrieve multiple tissue types  NOT FROM THE SAME PATIENTS
SS <- TCGAquery_SampleTypes(bar,c("TP","NB"))

# Retrieve multiple tissue types  FROM THE SAME PATIENTS
SSS <- TCGAquery_MatchedCoupledSampleTypes(bar,c("NT","TP"))
```

# Other useful code

To get all the information for TGCA samples you can use the script below:

```
# This code will get all clinical indexed data from TCGA
library(data.table)
library(dplyr)
library(regexPipes)
clinical <- TCGAbiolinks:::getGDCprojects()$project_id %>%
    regexPipes::grep("TCGA",value = TRUE) %>%
    sort %>%
    plyr::alply(1,GDCquery_clinic, .progress = "text") %>%
    rbindlist
readr::write_csv(clinical,path = paste0("all_clin_indexed.csv"))

# This code will get all clinical XML data from TCGA
getclinical <- function(proj){
    message(proj)
    while(1){
        result = tryCatch({
            query <- GDCquery(project = proj, data.category = "Clinical",data.format = "bcr xml")
            GDCdownload(query)
            clinical <- GDCprepare_clinic(query, clinical.info = "patient")
            for(i in c("admin","radiation","follow_up","drug","new_tumor_event")){
                message(i)
                aux <- GDCprepare_clinic(query, clinical.info = i)
                if(is.null(aux) || nrow(aux) == 0) next
                # add suffix manually if it already exists
                replicated <- which(grep("bcr_patient_barcode",colnames(aux), value = T,invert = T) %in% colnames(clinical))
                colnames(aux)[replicated] <- paste0(colnames(aux)[replicated],".",i)
                if(!is.null(aux)) clinical <- merge(clinical,aux,by = "bcr_patient_barcode", all = TRUE)
            }
            readr::write_csv(clinical,path = paste0(proj,"_clinical_from_XML.csv")) # Save the clinical data into a csv file
            return(clinical)
        }, error = function(e) {
            message(paste0("Error clinical: ", proj))
        })
    }
}
clinical <- TCGAbiolinks:::getGDCprojects()$project_id %>%
    regexPipes::grep("TCGA",value=T) %>% sort %>%
    plyr::alply(1,getclinical, .progress = "text") %>%
    rbindlist(fill = TRUE) %>% setDF %>% subset(!duplicated(clinical))

readr::write_csv(clinical,path = "all_clin_XML.csv")
# result: https://drive.google.com/open?id=0B0-8N2fjttG-WWxSVE5MSGpva1U
# Obs: this table has multiple lines for each patient, as the patient might have several followups, drug treatments,
# new tumor events etc...
```