# renet2 CWL Generation Report

## renet2_predict

### Tool Description
RENET2 testing models [assemble, full-text]

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sujunhao/RENET2
- **Stars**: N/A
### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
usage: predict.py [-h] [--raw_data_dir RAW_DATA_DIR] [--model_dir MODEL_DIR]
                  [--label_f_name LABEL_F_NAME]
                  [--file_name_doc FILE_NAME_DOC]
                  [--file_name_snt FILE_NAME_SNT]
                  [--file_name_ann FILE_NAME_ANN]
                  [--word_index_fn WORD_INDEX_FN] [--gda_fn_d GDA_FN_D]
                  [--pretrained_model_p PRETRAINED_MODEL_P] [--use_cuda]
                  [--seed S] [--fix_snt_n N] [--fix_token_n N]
                  [--max_doc_num N] [--no_cache_file] [--add_cache_suf]
                  [--overwrite_cache] [--batch_size N] [--epochs N] [--lr LR]
                  [--l2_weight_decay L2] [--is_read_doc] [--read_abs]
                  [--models_number N] [--raw_input_read_batch N]
                  [--raw_input_read_batch_resume N] [--is_filter_sub]
                  [--read_ori_token] [--not_x_feature] [--read_old_file]
                  [--using_new_tokenizer] [--is_sensitive_mode]

RENET2 testing models [assemble, full-text]

optional arguments:
  -h, --help            show this help message and exit
  --raw_data_dir RAW_DATA_DIR
                        input data folder
  --model_dir MODEL_DIR
                        modle data dir
  --label_f_name LABEL_F_NAME
                        modle label name
  --file_name_doc FILE_NAME_DOC
                        document name
  --file_name_snt FILE_NAME_SNT
                        sentences file name
  --file_name_ann FILE_NAME_ANN
                        anns file name
  --word_index_fn WORD_INDEX_FN
                        word index data dir
  --gda_fn_d GDA_FN_D   found gda file folder
  --pretrained_model_p PRETRAINED_MODEL_P
                        pretrained based models
  --use_cuda            enables CUDA training default: False
  --seed S              random seed default: 42
  --fix_snt_n N         number of sentence in input, recommend [for abs 32,
                        for ft 400] default: 400
  --fix_token_n N       number of tokens default: 54
  --max_doc_num N       number of document, 0 for read all doc default: 0
  --no_cache_file       disables using cache file for data input default:
                        False
  --add_cache_suf       cache file suffix default: False
  --overwrite_cache     overwrite_cache default: False
  --batch_size N        input batch size for training default: 60
  --epochs N            number of epochs to train default: 10
  --lr LR               learning rate default: 0.0008
  --l2_weight_decay L2  L2 weight decay default: 5e-05
  --is_read_doc         reading doc file, not renet1's abstracts file default:
                        True
  --read_abs            reading_abs_only default: False
  --models_number N     number of models to train default: 10
  --raw_input_read_batch N
                        raw data read max doc batch number default: -1
  --raw_input_read_batch_resume N
                        raw data read max doc batch number resume default: -1
  --is_filter_sub       filter pmid in abs data
  --read_ori_token      get raw text
  --not_x_feature       do not use x_feature
  --read_old_file       reading dga files
  --using_new_tokenizer
                        using new tokenizer
  --is_sensitive_mode   using sensitive mode
```


## renet2_train

### Tool Description
RENET2 training models [assemble, full-text] and testing

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
usage: train.py [-h] [--raw_data_dir RAW_DATA_DIR]
                [--annotation_info_dir ANNOTATION_INFO_DIR]
                [--model_dir MODEL_DIR] [--label_f_name LABEL_F_NAME]
                [--file_name_doc FILE_NAME_DOC]
                [--file_name_snt FILE_NAME_SNT]
                [--file_name_ann FILE_NAME_ANN]
                [--word_index_fn WORD_INDEX_FN] [--gda_fn_d GDA_FN_D]
                [--pretrained_model_p PRETRAINED_MODEL_P]
                [--have_SiDa HAVE_SIDA] [--rst_file_prefix RST_FILE_PREFIX]
                [--use_cuda] [--seed S] [--fix_snt_n N] [--fix_token_n N]
                [--max_doc_num N] [--no_cache_file] [--add_cache_suf]
                [--overwrite_cache] [--batch_size N] [--epochs N] [--lr LR]
                [--is_read_doc] [--read_abs] [--models_number N]
                [--read_ori_token] [--not_x_feature] [--read_old_file]
                [--using_new_tokenizer] [--is_filter_sub]

RENET2 training models [assemble, full-text] and testing

optional arguments:
  -h, --help            show this help message and exit
  --raw_data_dir RAW_DATA_DIR
                        input data folder
  --annotation_info_dir ANNOTATION_INFO_DIR
                        annotation data folder
  --model_dir MODEL_DIR
                        modle data dir
  --label_f_name LABEL_F_NAME
                        modle label name
  --file_name_doc FILE_NAME_DOC
                        document name
  --file_name_snt FILE_NAME_SNT
                        sentences file name
  --file_name_ann FILE_NAME_ANN
                        anns file name
  --word_index_fn WORD_INDEX_FN
                        word index data dir
  --gda_fn_d GDA_FN_D   found gda file folder
  --pretrained_model_p PRETRAINED_MODEL_P
                        pretrained based models
  --have_SiDa HAVE_SIDA
                        SiDa file
  --rst_file_prefix RST_FILE_PREFIX
                        predicted GDP file
  --use_cuda            enables CUDA training default: False
  --seed S              random seed default: 0
  --fix_snt_n N         number of sentence in input, recommend [for abs 32,
                        for ft 400] default: 400
  --fix_token_n N       number of tokens default: 54
  --max_doc_num N       number of document, 0 for read all doc default: 0
  --no_cache_file       disables using cache file for data input default:
                        False
  --add_cache_suf       cache file suffix default: False
  --overwrite_cache     overwrite_cache default: False
  --batch_size N        input batch size for training default: 60
  --epochs N            number of epochs to train default: 10
  --lr LR               learning rate default: 0.0008
  --is_read_doc         reading doc file, not renet2's abstracts file default:
                        True
  --read_abs            reading_abs_only default: False
  --models_number N     number of models to train default: 10
  --read_ori_token      get raw text
  --not_x_feature       do not use x_feature
  --read_old_file       reading dga files
  --using_new_tokenizer
                        using new tokenizer
  --is_filter_sub       filter pmid in abs data
```


## renet2_evaluate_renet2_ft_cv

### Tool Description
RENET2 training models [assemble, full-text] and testing

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
usage: evaluate_renet2_ft_cv.py [-h] [--raw_data_dir RAW_DATA_DIR]
                                [--annotation_info_dir ANNOTATION_INFO_DIR]
                                [--modle_dir MODLE_DIR]
                                [--label_f_name LABEL_F_NAME]
                                [--file_name_doc FILE_NAME_DOC]
                                [--file_name_snt FILE_NAME_SNT]
                                [--file_name_ann FILE_NAME_ANN]
                                [--word_index_fn WORD_INDEX_FN]
                                [--pretrained_model_p PRETRAINED_MODEL_P]
                                [--have_SiDa HAVE_SIDA]
                                [--rst_file_prefix RST_FILE_PREFIX]
                                [--use_cuda] [--seed S] [--fix_snt_n N]
                                [--fix_token_n N] [--max_doc_num N]
                                [--no_cache_file] [--add_cache_suf]
                                [--overwrite_cache] [--batch_size N]
                                [--epochs N] [--lr LR] [--is_read_doc]
                                [--read_abs] [--models_number N]
                                [--read_ori_token] [--not_x_feature]
                                [--read_old_file] [--using_new_tokenizer]
                                [--is_filter_sub]

RENET2 training models [assemble, full-text] and testing

optional arguments:
  -h, --help            show this help message and exit
  --raw_data_dir RAW_DATA_DIR
                        input data folder
  --annotation_info_dir ANNOTATION_INFO_DIR
                        annotation data folder
  --modle_dir MODLE_DIR
                        modle data dir
  --label_f_name LABEL_F_NAME
                        modle label name
  --file_name_doc FILE_NAME_DOC
                        document name
  --file_name_snt FILE_NAME_SNT
                        sentences file name
  --file_name_ann FILE_NAME_ANN
                        anns file name
  --word_index_fn WORD_INDEX_FN
                        word index data dir
  --pretrained_model_p PRETRAINED_MODEL_P
                        pretrained based models
  --have_SiDa HAVE_SIDA
                        SiDa file
  --rst_file_prefix RST_FILE_PREFIX
                        predicted GDP file
  --use_cuda            enables CUDA training default: False
  --seed S              random seed default: 0
  --fix_snt_n N         number of sentence in input, recommend [for abs 32,
                        for ft 400] default: 400
  --fix_token_n N       number of tokens default: 54
  --max_doc_num N       number of document, 0 for read all doc default: 0
  --no_cache_file       disables using cache file for data input default:
                        False
  --add_cache_suf       cache file suffix default: False
  --overwrite_cache     overwrite_cache default: False
  --batch_size N        input batch size for training default: 60
  --epochs N            number of epochs to train default: 10
  --lr LR               learning rate default: 0.0008
  --is_read_doc         reading doc file, not renet2's abstracts file default:
                        True
  --read_abs            reading_abs_only default: False
  --models_number N     number of models to train default: 10
  --read_ori_token      get raw text
  --not_x_feature       do not use x_feature
  --read_old_file       reading dga files
  --using_new_tokenizer
                        using new tokenizer
  --is_filter_sub       filter pmid in abs data
```


## renet2_download_data

### Tool Description
download abstrcts/full-text pubtator/json file from Pubtator

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
usage: download_data.py [-h] [--id_f ID_F] [--type TYPE] [--dir DIR]
                        [--tmp_hit_f TMP_HIT_F] [--process_n PROCESS_N]

download abstrcts/full-text pubtator/json file from Pubtator

optional arguments:
  -h, --help            show this help message and exit
  --id_f ID_F           PMID/PMCID list file input, default:
                        ../data/test_download_pmid_list.csv
  --type TYPE           [abs, ft] download text type: abstrcts or full-text
                        default: abs
  --dir DIR             output dir default: ../data/raw_data/abs/
  --tmp_hit_f TMP_HIT_F
                        output hit id list f default: ../data/hit_id_l.csv
  --process_n PROCESS_N
                        cores number of multoprocessing
```


## renet2_parse_data

### Tool Description
parse abstracts/full-text pubtator/json file to RENET2 input format

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
***
please make sure to use 'renet2 install_geniass' to install the sentence splliter, before running the parse_data
***

usage: parse_data.py [-h] [--id_f ID_F] [--type TYPE]
                     [--in_abs_dir IN_ABS_DIR] [--in_ft_dir IN_FT_DIR]
                     [--out_dir OUT_DIR] [--no_s_f]

parse abstrcts/full-text pubtator/json file to RENET2 input format

optional arguments:
  -h, --help            show this help message and exit
  --id_f ID_F           PMID/PMCID list file input, default:
                        ../test/test_download_pmid_list.csv
  --type TYPE           [abs, ft] download text type: abstrcts or full-text
                        default: abs
  --in_abs_dir IN_ABS_DIR
                        input abstracts raw file dir default: None
  --in_ft_dir IN_FT_DIR
                        input full-text raw file dir default: None
  --out_dir OUT_DIR     output file dir default: ../data/test_input/
  --no_s_f              disables generate the source session info file
```


## renet2_normalize_ann

### Tool Description
normalize annotation ID

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: PASS

### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
usage: normalize_ann.py [-h] [--in_f IN_F] [--out_f OUT_F]

normalize annotation ID

optional arguments:
  -h, --help     show this help message and exit
  --in_f IN_F    input annotation None
  --out_f OUT_F  output file default: None
```


## renet2_install_geniass

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/renet2:1.2--py_0
- **Homepage**: https://github.com/sujunhao/RENET2
- **Package**: https://anaconda.org/channels/bioconda/packages/renet2/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
____  _____ _   _ _____ _____ ____  
 |  _ \| ____| \ | | ____|_   _|___ \ 
 | |_) |  _| |  \| |  _|   | |   __) |
 |  _ <| |___| |\  | |___  | |  / __/ 
 |_| \_\_____|_| \_|_____| |_| |_____|

           
install geniass (cd /usr/local/lib/python3.7/site-packages/renet2/tools; tar -xf geniass-1.00.tar.gz; cd geniass; make)
```

