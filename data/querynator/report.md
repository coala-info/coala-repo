# querynator CWL Generation Report

## querynator_create-report

### Tool Description
Generates reports from CGI and CIViC result folders.

### Metadata
- **Docker Image**: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/qbic-pipelines/querynator
- **Package**: https://anaconda.org/channels/bioconda/packages/querynator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/querynator/overview
- **Total Downloads**: 16.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qbic-pipelines/querynator
- **Stars**: N/A
### Original Help Text
```text
__ 
  ____ ___  _____  _______  ______  ____ _/ /_____  _____
 / __ `/ / / / _ \/ ___/ / / / __ \/ __ `/ __/ __ \/ ___/
/ /_/ / /_/ /  __/ /  / /_/ / / / / /_/ / /_/ /_/ / /
\__, /\__,_/\___/_/   \__, /_/ /_/\__,_/\__/\____/_/
  /_/                /____/


Usage: querynator create-report [OPTIONS]

Options:
  -c, --cgi_path PATH    Path to a CGI result folder generated using the
                         querynator  [required]
  -j, --civic_path PATH  Path to a CIViC result folder generated using the
                         querynator  [required]
  -o, --outdir TEXT      Name of new directory in which reports will be
                         stored.  [required]
  --help                 Show this message and exit.
```


## querynator_query-api-cgi

### Tool Description
Query the CGI API

### Metadata
- **Docker Image**: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/qbic-pipelines/querynator
- **Package**: https://anaconda.org/channels/bioconda/packages/querynator/overview
- **Validation**: PASS

### Original Help Text
```text
__ 
  ____ ___  _____  _______  ______  ____ _/ /_____  _____
 / __ `/ / / / _ \/ ___/ / / / __ \/ __ `/ __/ __ \/ ___/
/ /_/ / /_/ /  __/ /  / /_/ / / / / /_/ / /_/ /_/ / /
\__, /\__,_/\___/_/   \__, /_/ /_/\__,_/\__/\____/_/
  /_/                /____/


Usage: querynator query-api-cgi [OPTIONS]

Options:
  -m, --mutations PATH            Please provide the path to the PASS filtered
                                  variant file (vcf,tsv,gtf,hgvs): See more
                                  info here: https://www.cancergenomeinterpret
                                  er.org/faq#q22
  -a, --cnas PATH                 Please provide the path to the copy number
                                  alterations file:
  -l, --translocations PATH       Please provide the path to the file
                                  containing translocations:
  -o, --outdir TEXT               i.e. sample name. Directory in which results
                                  will be stored.  [required]
  -c, --cancer [Adrenal adenoma|Aneurysmal bone cyst|Adrenal cortex|Adrenal cortex adenoma|Adrenal cortex carcinoma|Atypical chronic myeloid leukemia|Acute erythroid leukemia|Anaplastic oligodendroglioma|Anaplastic large cell lymphoma|Acute lymphoblastic leukemia|Acral lentigious melanoma|Acute myeloid leukemia|Acute myeloid leukemia predisposition|Acute promyelocytic leukemia|Angiosarcoma|Brain|Basal cell carcinoma|B cell lymphoma|Bladder|Bladder transitional cell|Burkitt lymphoma|Breast adenocarcinoma|Brest predisposition|Breast lobular|Breast ductal|Breast mixed ductal and lobular|Billiary tract|Any cancer type|Cancer predisposition|Clear cell sarcoma|Cervix|Cervix squamous cell|Cholangiocarcinoma|Intrahepatic cholangiocarcinoma|Chronic lymphocytic leukemia|Cutaneous melanoma|Cutaneous melanoma predisposition|Chronic myeloid leukemia|Chronic myeloproliferitve neoplasm|Chronic neutrophilic leukemia|Central nervous system|Central nervous system lymphoma|Colon carcinoma|Colon carcinoma predisposition|Colon adenocarcinoma|Colorectal adenocarcinoma|Colorectal adenocarcinoma predisposition|Rectal adenocarcinoma|Chondrosarcoma|Cutaneous T-cell lymphoma|Desmoid tumor|Dermatofibrosarcoma|Difuse large B Cell lymphoma|Dysembryoplastic neuroepithelial tumour|Digestive system|Desmoplastic small round cell tumor|Digestive tract|Digestive tract predisposition|Eosinophilic chronic leukemia|Endometrium|Endometrial adenocarcinoma|Endometrial stromal|Eosinophilia|Endocrine System|Esophagous|Esophagous adenocarcinoma|Esophagous squamous cell|Ewing sarcoma|Eye|Familial adeno poliposis|Female germ cell tumor|Fibrous histiocytoma|Fibrosarcoma|Fibrosarcoma predisposition|Follicular lymphoma|Female reproductory system|Glioma|Glioblastoma|Glioblastoma multiforme|Giant cell astrocytoma|Gastroesophageal junction adenocarcinoma|Gastrointestinal stromal|Gastrointestinal stromal predisposition|Hepatic|Hepatic adenoma|Hepatic blastoma|Hepatic carcinoma|Hepatic carcinoma predisposition|Hairy-Cell leukemia|Hematologic malignancies|Hematologic malignancies predisposition|Hyper eosinophilic advanced snydrome|Hemangiopericytoma|Histiocytoma|Erdheim-Chester histiocytosis|Lagerhans cell histiocytosis|Hodking lymhpoma|Head an neck|Head an neck squamous|Inflammatory myofibroblastic|Lung|Lymphangioleiomyomatosis|Large B-Cell lymphoma|Leiomyosarcoma|Leydig cell adenoma|Lower grade glioma|Large granular leukemia|Liposarcoma|Dedifferentiated liposarcoma|Leukemia|Lymphoblastic leukemia|Lymphoblastic lymphoma|Lung adenocarcinoma|Lung squamous cell|Liver & billiary tract|Lymphoma|Malignant astrocytoma|MALT lymphoma|Mastocytosis|Medulloblastoma|Mantle cell lymphoma|Mast cell leukemia|Myelodisplasic proliferative syndrome|Myelodisplasic syndrome|Meningioma|Merkel cell carcinoma|Mesothelioma|Pleural mesothelioma|Myxoidfibrosarcoma|Male germ cell tumor|Megakaryoblastic leukemia|Multiple myeloma|Myelomonocyitic leukemia|Malignant peripheral nerve sheat tumor|Male reproductory system|Malignant rhabdoid tumor|Malignant rhabdoid tumor predisposition|Musculoskeletal & vascular systems|Mucosa-associated lymphoma|Mucosal melanoma|Myelofibrosis|Myoepithelioma|Myeloma|Myxoma|Neuroblastoma|Neuroendocrine|Neurofibroma|Non-hodking lymphoma|NUT midline carcinoma|Nervous system|Non-small cell lung|Non-seminomatous germ cell tumor|Nasopharyngeal|Oral cavity|Oral cavity squamous cell|Ororpharynx squamous cell|Osteosarcoma|Ovary|Ovary predisposition|Ovary clear cell|Ovary epithelial cell|Ovary granulosa cell|Ovary rhabdoid tumor|Ovary small cell|Ovary serous|Pancreas|Pancreas acinar|Pancreas adenocarcinoma|Pancreas neuroendocrine|Periampullary adenoma|Paraganglioma|Parathyroid adenoma|Pheochromocytoma and paraganglioma|Perivascular epithelioid cell|Pediatric glioma|Pheochromocytoma|Pilocityc astrocytoma|Anaplastic astrocytoma|Pituitary gland adenoma|Pleura|Plexiform neurofibroma|Peripheral nervous system|Pleuropulmonary blastoma|Prostate adenocarcinoma|Perypheral T-cell lymphoma|Extranodal natural killer/T-cell lymphoma|Polycitemia vera|Renal|Renal predisposition|Renal angiomyolipoma|Retinoblastoma|Renal clear cell|Renal chromophobe cell|Rectal carcinoma|Rhabdomyosarcoma|Renal papillary cell|Sarcoma|Squamous cell carcinoma|Squamous cell carcinoma predisposition|Sex-cord gonadal stromal|Schwannoma|Small cell lung|Salivary glands|Salivary glands adenoma|Salivary glands mucoepidermoid|Adenoid cystic carcinoma|Small intestine|Small intestine neuroendocrine|Skin|Skin predisposition|Small lymphocytic lymphoma|Systemic mastocytosis|Seminomatous germ cell tumor|Mixed germ cell tumor|Solid tumors|Solid tumors predisposition|Sensory system|Stomach|Stomach predisposition|Stomach adenocarcinoma|Soft tissue sarcoma|Synovial sarcoma|Testis|T-cell acute lymphoblastic leukemia|T-cell prolymphocytic leukemia|Teratoma|Thyroid|Thyroid adenoma|Thyroid carcinoma|Thyroid follicular|Thyroid medullary|Thyroid papillary|Thymic|Tongue squamous cell|Torax|Uterus|Uterine corpus endometroid carcinoma|Uterine carcinosarcoma|Uterine leiomyosarcoma|Urinary system|Urinary tract carcinoma|Urothelial|Upper tract urothelial carcinoma|Uveal melanoma|Waldenström macroglobulinemia|Wilms tumor|BENIGN]
                                  Please enter the cancer type to be searched.
                                  You must use quotation marks.
  -g, --genome [hg19|GRCh37|hg38|GRCh38]
                                  Please enter the genome version  [required]
  -t, --token TEXT                Please provide your token for CGI database
                                  [required]
  -e, --email TEXT                Please provide your user email address for
                                  CGI
  -f, --filter_vep                If set, filters out synoymous and low impact
                                  variants based on VEP annotation
  --help                          Show this message and exit.
```


## querynator_query-api-civic

### Tool Description
Query the Civic API for variants in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/querynator:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/qbic-pipelines/querynator
- **Package**: https://anaconda.org/channels/bioconda/packages/querynator/overview
- **Validation**: PASS

### Original Help Text
```text
__ 
  ____ ___  _____  _______  ______  ____ _/ /_____  _____
 / __ `/ / / / _ \/ ___/ / / / __ \/ __ `/ __/ __ \/ ___/
/ /_/ / /_/ /  __/ /  / /_/ / / / / /_/ / /_/ /_/ / /
\__, /\__,_/\___/_/   \__, /_/ /_/\__,_/\__/\____/_/
  /_/                /____/


Usage: querynator query-api-civic [OPTIONS]

Options:
  -v, --vcf PATH                  Please provide the path to a Variant Call
                                  Format (VCF) file (Version 4.2)  [required]
  -o, --outdir TEXT               i.e. sample name. Directory in which results
                                  will be stored.  [required]
  -g, --genome [GRCh37|GRCh38|NCBI36]
                                  Please enter the reference genome version
                                  [required]
  -c, --cancer TEXT               the cancer DOID (id or name) to be searched.
  -f, --filter_vep                if set, filters out synoymous and low impact
                                  variants based on VEP annotation
  -e, --filter_evidence TEXT      Key-Value pairs to filter the evidence
                                  items. Example: 'type=Predictive'
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated
