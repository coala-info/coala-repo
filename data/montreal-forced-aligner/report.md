# montreal-forced-aligner CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| montreal-forced-aligner_mfa_adapt | PASS |  |
| montreal-forced-aligner_mfa_adapt_hf | PASS |  |
| montreal-forced-aligner_mfa_align | PASS |  |
| montreal-forced-aligner_mfa_align_hf | PASS |  |
| montreal-forced-aligner_mfa_align_one | PASS |  |
| montreal-forced-aligner_mfa_align_one_hf | PASS |  |
| montreal-forced-aligner_mfa_compare_alignments | Failed | tool bug: mfa compare_alignments crashes on MFA's own TextGrids (KeyError for words/phones tiers, then sqlite NOT NULL error on phone_interval.begin). |
| montreal-forced-aligner_mfa_configure | PASS |  |
| montreal-forced-aligner_mfa_diarize | Not completed | needs a PostgreSQL server (mfa says diarization requires --use_postgres true); no server in the one-container run. |
| montreal-forced-aligner_mfa_find_oovs | PASS |  |
| montreal-forced-aligner_mfa_g2p | PASS |  |
| montreal-forced-aligner_mfa_history | Failed | tool bug: mfa history prints nothing even with a valid command history file (history_cli writes through a logger that is never set up). |
| montreal-forced-aligner_mfa_model_add_words | PASS |  |
| montreal-forced-aligner_mfa_model_create_hf_model | PASS |  |
| montreal-forced-aligner_mfa_model_download | PASS |  |
| montreal-forced-aligner_mfa_model_download_acoustic | PASS |  |
| montreal-forced-aligner_mfa_model_inspect | PASS |  |
| montreal-forced-aligner_mfa_model_list | PASS |  |
| montreal-forced-aligner_mfa_model_save | PASS |  |
| montreal-forced-aligner_mfa_remap_alignments | PASS |  |
| montreal-forced-aligner_mfa_remap_dictionary | PASS |  |
| montreal-forced-aligner_mfa_segment | Failed | image problem: speechbrain VAD fails in the image (hf_hub_download() got an unexpected keyword argument use_auth_token). |
| montreal-forced-aligner_mfa_segment_vad | PASS |  |
| montreal-forced-aligner_mfa_tokenize | Failed | tool bug: corpus loader finds no files for any input (file or directory), so the tokenizer never runs. |
| montreal-forced-aligner_mfa_train_acoustic | PASS |  |
| montreal-forced-aligner_mfa_train_dictionary | PASS |  |
| montreal-forced-aligner_mfa_train_g2p | PASS |  |
| montreal-forced-aligner_mfa_train_ivector | Not completed | tiny corpus cannot train an ivector extractor (Kaldi error: NaN in HouseBackward / PLDA needs ivectors). |
| montreal-forced-aligner_mfa_train_lm | PASS |  |
| montreal-forced-aligner_mfa_train_tokenizer | PASS |  |
| montreal-forced-aligner_mfa_transcribe | PASS |  |
| montreal-forced-aligner_mfa_transcribe_speechbrain | Not completed | mfa says SpeechBrain transcription requires CUDA (GPU); none available. |
| montreal-forced-aligner_mfa_transcribe_whisper | Failed | image problem: whisperx is not installed in the image (mfa asks for pip install whisperx). |
| montreal-forced-aligner_mfa_validate | PASS |  |
| montreal-forced-aligner_mfa_validate_dictionary | PASS |  |

## montreal-forced-aligner_mfa_adapt

### Tool Description
Adapt an acoustic model to a new corpus.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa adapt [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH ACOUSTIC_MODEL_PATH OUTPUT_MODEL_PATH 

Adapt an acoustic model to a new corpus. 

Options 
--output_directory DIRECTORY Path to save alignments. 
--config_path -c FILE Path to config file to use for training. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--include_original_text Flag to include original utterance text in the output. 
--no_tokenization Flag to disable any pretrained tokenization. 
--reference_directory DIRECTORY Directory containing gold standard alignments to use in training 
--custom_mapping_path FILE YAML file for mapping phones from acoustic model phone set to phone set in golden alignments. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_adapt_hf

### Tool Description
Adapt an acoustic model hosted on Hugging Face to a new corpus.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa adapt_hf [OPTIONS] CORPUS_DIRECTORY MODEL_ID OUTPUT_MODEL_PATH 

Adapt an acoustic model to a new corpus. 

Options 
--output_directory DIRECTORY Path to save alignments. 
--config_path -c FILE Path to config file to use for training. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--include_original_text Flag to include original utterance text in the output. 
--no_tokenization Flag to disable any pretrained tokenization. 
--reference_directory DIRECTORY Directory containing gold standard alignments to use in training 
--custom_mapping_path FILE YAML file for mapping phones from acoustic model phone set to phone set in golden alignments. 
--dialect TEXT Dialect specifier for to use for pronunciations. 
--use_g2p Flag for using G2P model for OOV items. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_align

### Tool Description
Align a corpus with a pronunciation dictionary and a pretrained acoustic model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa align [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH ACOUSTIC_MODEL_PATH OUTPUT_DIRECTORY 

Align a corpus with a pronunciation dictionary and a pretrained acoustic model. 

Options 
--config_path -c FILE Path to config file to use for aligning. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--reference_directory DIRECTORY Directory containing gold standard alignments to evaluate 
--custom_mapping_path FILE YAML file for mapping phones from acoustic model phone set to phone set in golden alignments. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--include_original_text Flag to include original utterance text in the output. 
--no_tokenization Flag to disable any pretrained tokenization. 
--fine_tune Flag for running extra fine tuning stage. 
--fine_tune_boundary_tolerance FLOAT Flag for running extra fine tuning stage. 
--g2p_model_path TEXT Path to G2P model to use for OOV items. 
--ignore_oovs Ignore any file that contains OOV tokens by marking its utterances as ignored. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_align_hf

### Tool Description
Align a corpus with an MFA model hosted on Hugging Face.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa align_hf [OPTIONS] CORPUS_DIRECTORY MODEL_ID OUTPUT_DIRECTORY 

Align a corpus with an MFA model hosted on Hugging Face. 

Options 
--config_path -c FILE Path to config file to use for aligning. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--reference_directory DIRECTORY Directory containing gold standard alignments to evaluate 
--custom_mapping_path FILE YAML file for mapping phones from acoustic model phone set to phone set in golden alignments. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--include_original_text Flag to include original utterance text in the output. 
--no_tokenization Flag to disable any pretrained tokenization. 
--fine_tune Flag for running extra fine tuning stage. 
--fine_tune_boundary_tolerance FLOAT Flag for running extra fine tuning stage. 
--dialect TEXT Dialect specifier for to use for pronunciations. 
--use_g2p Flag for using G2P model for OOV items. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_align_one

### Tool Description
Align a single file with a pronunciation dictionary and a pretrained acoustic model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa align_one [OPTIONS] SOUND_FILE_PATH TEXT_FILE_PATH DICTIONARY_PATH ACOUSTIC_MODEL_PATH OUTPUT_PATH 

Align a single file with a pronunciation dictionary and a pretrained acoustic model. 

Options 
--config_path -c FILE Path to config file to use for aligning. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--no_tokenization Flag to disable any pretrained tokenization. 
--g2p_model_path TEXT Path to G2P model to use for OOV items. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_align_one_hf

### Tool Description
Align a single file with an MFA model hosted on Hugging Face.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa align_one_hf [OPTIONS] SOUND_FILE_PATH TEXT_FILE_PATH MODEL_ID OUTPUT_PATH 

Align a single file with an MFA model hosted on Hugging Face. 

Options 
--config_path -c FILE Path to config file to use for aligning. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--no_tokenization Flag to disable any pretrained tokenization. 
--dialect TEXT Dialect specifier for to use for pronunciations. 
--use_g2p Flag for using G2P model for OOV items. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_compare_alignments

### Tool Description
Compare two sets of alignments.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa compare_alignments [OPTIONS] REFERENCE_DIRECTORY TEST_DIRECTORY OUTPUT_DIRECTORY 

Align a corpus with a pronunciation dictionary and a pretrained acoustic model. 

Options 
--custom_mapping_path FILE YAML file for mapping phones from acoustic model phone set to phone set in golden alignments. 
--config_path -c FILE Path to config file to use for aligning. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--strict_mapping Flag for ensuring all phones are in the given mapping file. 
--naive Flag for skipping interval alignment and using closest boundary for error calculation. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_diarize

### Tool Description
Use an ivector extractor to cluster utterances into speakers.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa diarize [OPTIONS] CORPUS_DIRECTORY IVECTOR_EXTRACTOR_PATH OUTPUT_DIRECTORY 

Use an ivector extractor to cluster utterances into speakers 
If you would like to use SpeechBrain's speaker recognition model, specify ``speechbrain`` as the ``ivector_extractor_path``. When using SpeechBrain's speaker recognition model, the ``--cuda`` flag is available to perform computations on GPU, and the ``--num_jobs`` parameter will be used as a the batch size for any parallel computation. 

Options 
--config_path -c FILE Path to config file to use for training. 
--expected_num_speakers -s INTEGER Number of speakers if known. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--classify/--cluster Specify whether to classify speakers into pretrained IDs or cluster speakers without a classification model, default is cluster 
--cluster_type [mfa|affinity|agglomerative|spectral|dbscan|hdbscan|optics|kmeans|meanshift] Type of clustering algorithm to use 
--cuda/--no_cuda Flag for using CUDA for SpeechBrain's model 
--use_pca/--no_use_pca Flag for using PCA representations of ivectors 
--evaluate,--validate Flag for whether to evaluate clustering/classification against existing speakers. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_find_oovs

### Tool Description
Find all out-of-vocabulary words (OOVs) in a corpus.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa find_oovs [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH OUTPUT_DIRECTORY 

Check for OOVs in a corpus 

Options 
--config_path -c FILE Path to config file to use for training. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_g2p

### Tool Description
Generate a pronunciation dictionary using a G2P model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa g2p [OPTIONS] INPUT_PATH G2P_MODEL_PATH OUTPUT_PATH 

Generate a pronunciation dictionary using a G2P model. 

Options 
--config_path -c FILE Path to config file to use for G2P. 
--num_pronunciations -n INTEGER Number of pronunciations to generate. 
--dictionary_path TEXT Path to existing pronunciation dictionary to use to find OOVs. 
--include_bracketed Included words enclosed by brackets, job_name.e. [...], (...), <...>. 
--strict_graphemes Skip words containing graphemes not in the G2P model 
--export_scores Add a column to export for the score of the generated pronunciation. 
--sorted Ensure output file is sorted alphabetically (slower). 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_model_add_words

### Tool Description
Add words from one pronunciation dictionary to another pronunciation dictionary, so long as the new pronunciations do not contain any new phones.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model add_words [OPTIONS] DICTIONARY_PATH NEW_PRONUNCIATIONS_PATH 

Add words from one pronunciation dictionary to another pronunciation dictionary, so long as the new pronunciations do not contain any new phones 

Options 
--help -h Show this message and exit. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics.
```

## montreal-forced-aligner_mfa_model_create_hf_model

### Tool Description
Create a Hugging Face-compatible model from legacy models.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model create_hf_model [OPTIONS] ACOUSTIC_MODEL_PATH DICTIONARY_PATH OUTPUT_MODEL_PATH 

Create a Hugging Face-compatible model from legacy models 

Options 
--g2p_model_path TEXT Path to G2P model to include. 
--metadata_path FILE Path to additional metadata json file to use for creating the model card. 
--config_path -c FILE Path to config file to use for training. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic for examples. 
--help -h Show this message and exit. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics.
```

## montreal-forced-aligner_mfa_model_download

### Tool Description
Download pretrained models from the MFA repository. If no model names are specified, the list of all downloadable models of the given model type is printed.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model download [OPTIONS] {acoustic|dictionary|g2p|ivector|language_model|tokenizer} [MODEL_NAME]... 

Download pretrained models from the MFA repository. If no model names are specified, the list of all downloadable models of the given model type will be printed. 

Options 
--github_token TEXT Personal access token to use for requests to GitHub to increase rate limit. 
--version TEXT Specific version of model to download rather than the latest. 
--force,--ignore_cache -f Flag to ignore existing downloaded models and force a re-download. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_model_download_acoustic

### Tool Description
Download pretrained acoustic models from the MFA repository. If no model names are specified, the list of all downloadable acoustic models is printed.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model download [OPTIONS] {acoustic|dictionary|g2p|ivector|language_model|tokenizer} [MODEL_NAME]... 

Download pretrained models from the MFA repository. If no model names are specified, the list of all downloadable models of the given model type will be printed. 

Options 
--github_token TEXT Personal access token to use for requests to GitHub to increase rate limit. 
--version TEXT Specific version of model to download rather than the latest. 
--force,--ignore_cache -f Flag to ignore existing downloaded models and force a re-download. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_model_inspect

### Tool Description
Inspect a model and print out its metadata.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model inspect [OPTIONS] {acoustic|dictionary|g2p|ivector|language_model|tokenizer} MODEL 

Inspect a model and print out its metadata. 

Options 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_model_list

### Tool Description
List the locally saved models of a given type.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model list [OPTIONS] {acoustic|dictionary|g2p|ivector|language_model|tokenizer} 

List of locally saved models. 

Options 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_model_save

### Tool Description
Save a model to the pretrained folder for later use.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa model save [OPTIONS] {acoustic|dictionary|g2p|ivector|language_model|tokenizer} PATH 

Save a model to pretrained folder for later use 
Parameters ---------- path: :class:`~pathlib.Path` 
Path to modelmodel_type: str 
Type of model 

Options 
--name TEXT Name to use as reference (defaults to the name of the zip file). 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_remap_alignments

### Tool Description
Remap alignments to a new phone set.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa remap alignments [OPTIONS] CORPUS_DIRECTORY PHONE_MAPPING_PATH OUTPUT_DIRECTORY 

Adapt an acoustic model to a new corpus. 

Options 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--dictionary_path TEXT Path to existing pronunciation dictionary to use in remapping pronunciations. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_remap_dictionary

### Tool Description
Remap a dictionary to a new phone set for use with an acoustic model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa remap dictionary [OPTIONS] DICTIONARY_PATH ACOUSTIC_MODEL_PATH PHONE_MAPPING_PATH OUTPUT_DICTIONARY_PATH 

Adapt an acoustic model to a new corpus. 

Options 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_segment

### Tool Description
Create segments based on SpeechBrain's voice activity detection (VAD) model or a basic energy-based algorithm.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa segment [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH ACOUSTIC_MODEL_PATH OUTPUT_DIRECTORY 

Create segments based on SpeechBrain's voice activity detection (VAD) model or a basic energy-based algorithm 

Options 
--config_path -c FILE Path to config file to use for training. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--cuda/--no_cuda Flag for using CUDA for SpeechBrain's model 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_segment_vad

### Tool Description
Create segments based on SpeechBrain's voice activity detection (VAD) model or a basic energy-based algorithm.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa segment_vad [OPTIONS] CORPUS_DIRECTORY OUTPUT_DIRECTORY 

Create segments based on SpeechBrain's voice activity detection (VAD) model or a basic energy-based algorithm 

Options 
--config_path -c FILE Path to config file to use for training. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--speechbrain/--no_speechbrain Flag for using SpeechBrain's pretrained VAD model 
--cuda/--no_cuda Flag for using CUDA for SpeechBrain's model 
--segment_transcripts/--no_segment_transcripts Flag for using CUDA for SpeechBrain's model 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_tokenize

### Tool Description
Tokenize utterances with a trained tokenizer model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa tokenize [OPTIONS] INPUT_PATH TOKENIZER_MODEL_PATH OUTPUT_DIRECTORY 

Tokenize utterances with a trained tokenizer model 

Options 
--config_path -c FILE Path to config file to use for training. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_acoustic

### Tool Description
Train a new acoustic model on a corpus and optionally export alignments.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH OUTPUT_MODEL_PATH 

Train a new acoustic model on a corpus and optionally export alignments 

Options 
--output_directory DIRECTORY Path to save alignments. 
--config_path -c FILE Path to config file to use for training. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic for examples. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--phone_set [UNKNOWN|AUTO|MFA|IPA|ARPA|PINYIN] DEPRECATED, please use --phone_groups_path to specify phone groups instead. 
--phone_groups_path FILE Path to yaml file defining phone groups. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic/phone_groups for examples. 
--rules_path FILE Path to yaml file defining phonological rules. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic/rules for examples. 
--topology_path FILE Path to yaml file defining topologies. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic/topologies for examples. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--include_original_text Flag to include original utterance text in the output. 
--language [unknown|afrikaans|amharic|arabic|assamese|azerbaijani|bashkir|belarusian|bulgarian|bengali|tibetan|breton|bosnian|catalan|czech|welsh|danish|german|greek|english|spanish|estonian|basque|farsi|finnish|faroese|french|galician|gujarati|hausa|hebrew|hin Language to use for spacy tokenizers and other preprocessing of language data. 
di|croatian|haitian|hungarian|armenian|indonesian|icelandic|italian|japanese|georgian|kazakh|central_khmer|kannada|korean|latin|luxembourgish|lingala|lao|lithuanian|latvian|malagasy|maori|macedonian|malayalam|mongolian|marathi|malay|maltese|burmese|n 
epali|dutch|norwegian_nynorsk|norwegian|occitan|punjabi|polish|pashto|portuguese|romanian|russian|sanskrit|sindhi|sinhala|slovak|slovenian|shona|somali|albanian|serbian|sundanese|swedish|swahili|tamil|telegu|tajik|thai|turkmen|tagalog|turkish|tatar|u 
krainian|urdu|uzbek|vietnamese|yiddish|yoruba|yue|chinese|kinyarwanda|mandarin] 
--g2p_model_path TEXT Path to G2P model to use for OOV items. 
--metadata_path FILE Path to additional metadata json file to use for creating the model card. 
--ignore_oovs Ignore any file that contains OOV tokens by marking its utterances as ignored. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_dictionary

### Tool Description
Calculate pronunciation probabilities for a dictionary based on alignment results in a corpus.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train_dictionary [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH ACOUSTIC_MODEL_PATH OUTPUT_DIRECTORY 

Calculate pronunciation probabilities for a dictionary based on alignment results in a corpus. 

Options 
--config_path -c FILE Path to config file to use for training. 
--silence_probabilities Flag for saving silence information for pronunciations. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_g2p

### Tool Description
Train a G2P model from a pronunciation dictionary.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train_g2p [OPTIONS] DICTIONARY_PATH OUTPUT_MODEL_PATH 

Train a G2P model from a pronunciation dictionary. 

Options 
--config_path -c FILE Path to config file to use for training. 
--phonetisaurus Flag for using Phonetisaurus-style models. 
--evaluate,--validate Perform an analysis of accuracy training on most of the data and validating on an unseen subset. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_ivector

### Tool Description
Train an ivector extractor from a corpus and pretrained acoustic model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train_ivector [OPTIONS] CORPUS_DIRECTORY OUTPUT_MODEL_PATH 

Train an ivector extractor from a corpus and pretrained acoustic model. 

Options 
--config_path -c FILE Path to config file to use for training. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_lm

### Tool Description
Train a language model from a corpus or convert an existing ARPA-format language model to an MFA language model.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train_lm [OPTIONS] SOURCE_PATH OUTPUT_MODEL_PATH 

Train a language model from a corpus or convert an existing ARPA-format language model to an MFA language model. 

Options 
--dictionary_path TEXT Full path to pronunciation dictionary, or saved dictionary name. 
--config_path -c FILE Path to config file to use for training. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_train_tokenizer

### Tool Description
Train a tokenizer model from a tokenized corpus.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa train_tokenizer [OPTIONS] CORPUS_DIRECTORY OUTPUT_MODEL_PATH 

Train a tokenizer model from a tokenized corpus. 

Options 
--config_path -c FILE Path to config file to use for training. 
--evaluate,--validate Perform an analysis of accuracy training on most of the data and validating on an unseen subset. 
--phonetisaurus Flag for using Phonetisaurus-style models. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_transcribe

### Tool Description
Transcribe utterances using an acoustic model, language model, and pronunciation dictionary.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa transcribe [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH ACOUSTIC_MODEL_PATH LANGUAGE_MODEL_PATH OUTPUT_DIRECTORY 

Transcribe utterances using an acoustic model, language model, and pronunciation dictionary. 

Options 
--config_path -c FILE Path to config file to use for transcription. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--output_type [transcription|alignment] Flag for outputting transcription text or alignments. 
--output_format [long_textgrid|short_textgrid|json|csv] Format for aligned output files (default is long_textgrid). 
--evaluate Evaluate the transcription against golden texts. 
--include_original_text Flag to include original utterance text in the output. 
--language_model_weight INTEGER Specific language model weight to use in evaluating transcriptions, defaults to 16. 
--word_insertion_penalty FLOAT Specific word insertion penalty between 0.0 and 1.0 to use in evaluating transcription, defaults to 1.0. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_transcribe_speechbrain

### Tool Description
Transcribe utterances using an ASR model trained by SpeechBrain.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa transcribe_speechbrain [OPTIONS] CORPUS_DIRECTORY {arabic|english|french|german|italian|kinyarwanda|mandarin|portuguese|spanish} OUTPUT_DIRECTORY 

Transcribe utterances using an ASR model trained by SpeechBrain. 

Options 
--architecture [whisper-medium|wav2vec2|whisper-large-v2] ASR model architecture 
--config_path -c FILE Path to config file to use for transcription. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--cuda/--no_cuda Flag for using CUDA for Whisper's model 
--evaluate Evaluate the transcription against golden texts. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_transcribe_whisper

### Tool Description
Transcribe utterances using a Whisper ASR model via faster-whisper.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa transcribe_whisper [OPTIONS] INPUT_PATH OUTPUT_PATH 

Transcribe utterances using a Whisper ASR model via faster-whisper. 

Options 
--architecture [large-v3|distil-large-v3|medium|base|tiny|small] Model size to use 
--language [unknown|afrikaans|amharic|arabic|assamese|azerbaijani|bashkir|belarusian|bulgarian|bengali|tibetan|breton|bosnian|catalan|czech|welsh|danish|german|greek|english|spanish|estonian|basque|farsi|finnish|faroese|french|galician|gujarati|hausa|hebrew|hin Language to use for transcription. 
di|croatian|haitian|hungarian|armenian|indonesian|icelandic|italian|japanese|georgian|kazakh|central_khmer|kannada|korean|latin|luxembourgish|lingala|lao|lithuanian|latvian|malagasy|maori|macedonian|malayalam|mongolian|marathi|malay|maltese|burmese|n 
epali|dutch|norwegian_nynorsk|norwegian|occitan|punjabi|polish|pashto|portuguese|romanian|russian|sanskrit|sindhi|sinhala|slovak|slovenian|shona|somali|albanian|serbian|sundanese|swedish|swahili|tamil|telegu|tajik|thai|turkmen|tagalog|turkish|tatar|u 
krainian|urdu|uzbek|vietnamese|yiddish|yoruba|yue|chinese|kinyarwanda|mandarin] 
--config_path -c FILE Path to config file to use for transcription. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--cuda/--no_cuda Flag for using CUDA for Whisper's model 
--evaluate Evaluate the transcription against golden texts. 
--vad Use VAD to split utterances. 
--incremental Save outputs immediately and use previous progress. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_validate

### Tool Description
Validate a corpus for use in MFA.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa validate [OPTIONS] CORPUS_DIRECTORY DICTIONARY_PATH 

Validate a corpus for use in MFA. 

Options 
--output_directory DIRECTORY Directory to save validation output files. 
--acoustic_model_path TEXT Acoustic model to use in testing alignments. 
--config_path -c FILE Path to config file to use for training. 
--speaker_characters -s TEXT Number of characters of file names to use for determining speaker, default is to use directory names. 
--audio_directory -a DIRECTORY Audio directory root to use for finding audio files. 
--phone_set [UNKNOWN|AUTO|MFA|IPA|ARPA|PINYIN] DEPRECATED, please use --phone_groups_path to specify phone groups instead. 
--phone_groups_path FILE Path to yaml file defining phone groups. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic/phone_groups for examples. 
--rules_path FILE Path to yaml file defining phonological rules. See https://github.com/MontrealCorpusTools/mfa-models/tree/main/config/acoustic/rules for examples. 
--ignore_acoustics,--skip_acoustics Skip acoustic feature generation and associated validation. 
--test_transcriptions Use per-speaker language models to test accuracy of transcriptions. 
--ignore_oovs Ignore any file that contains OOV tokens by marking its utterances as ignored. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## montreal-forced-aligner_mfa_validate_dictionary

### Tool Description
Validate a dictionary using a G2P model to detect unlikely pronunciations.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mfa validate_dictionary [OPTIONS] DICTIONARY_PATH 

Validate a dictionary using a G2P model to detect unlikely pronunciations. 

Options 
--output_path DIRECTORY Path to save the CSV file with the scored pronunciations. 
--g2p_model_path TEXT Pretrained G2P model path. 
--config_path -c FILE Path to config file to use for training. 
--g2p_threshold FLOAT Threshold to use when running G2P. Paths with costs less than the best path times the threshold value will be included. 
--profile -p TEXT Configuration profile to use, defaults to "global" 
--temporary_directory -t TEXT Set the default temporary directory, default is /mfa 
--num_jobs -j INTEGER Set the number of processes to use by default, defaults to 3 
--clean/--no_clean Remove files from previous runs, default is True 
--final_clean/--no_final_clean Remove temporary files at the end of run, default is False 
--verbose/--no_verbose -v/-nv Output debug messages, default is False 
--quiet/--no_quiet -q/-nq Suppress all output messages (overrides verbose), default is False 
--overwrite/--no_overwrite Overwrite output files when they exist, default is False 
--use_mp/--no_use_mp Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. 
--use_threading/--no_use_threading Use threading library rather than multiprocessing library. Multiprocessing is recommended will allow for faster executions. 
--debug/--no_debug -d/-nd Run extra steps for debugging issues, default is False 
--use_postgres/--no_use_postgres Use postgres instead of sqlite for extra functionality, default is False 
--single_speaker Single speaker mode creates multiprocessing splits based on utterances rather than speakers. This mode also disables speaker adaptation equivalent to `--uses_speaker_adaptation false`. 
--textgrid_cleanup,--cleanup_textgrids/--no_textgrid_cleanup,--no_cleanup_textgrids Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. 
--help -h Show this message and exit.
```

## Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```

## montreal-forced-aligner_mfa_validate

### Tool Description
Validate the alignment files for a corpus.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```

## montreal-forced-aligner_mfa_train_acoustic

### Tool Description
Train an acoustic model.

### Metadata
- **Docker Image**: quay.io/biocontainers/montreal-forced-aligner:3.3.8
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mfa", line 6, in <module>
    from montreal_forced_aligner.command_line.mfa import mfa_cli
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/__init__.py", line 4, in <module>
    import montreal_forced_aligner.acoustic_modeling as acoustic_modeling
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/__init__.py", line 7, in <module>
    from montreal_forced_aligner.acoustic_modeling.base import AcousticModelTrainingMixin  # noqa
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/acoustic_modeling/base.py", line 18, in <module>
    from montreal_forced_aligner import config
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 312, in <module>
    GLOBAL_CONFIG = MfaConfiguration()
  File "/usr/local/lib/python3.14/site-packages/montreal_forced_aligner/config.py", line 224, in __init__
    self.global_profile = MfaProfile()
                          ~~~~~~~~~~^^
  File "<string>", line 17, in __init__
TypeError: Path.copy() missing 1 required positional argument: 'target'
```

## montreal-forced-aligner_mfa_history

### Tool Description
Show previously run mfa commands.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                                                                                                                                        
 Usage: mfa history [OPTIONS]                                                                                                                                                                           
                                                                                                                                                                                                        
 Show previously run mfa commands                                                                                                                                                                       
                                                                                                                                                                                                        
╭─ Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --depth                         INTEGER  Number of commands to list, defaults to 10                                                                                                                  │
│ --verbose/--no_verbose  -v/-nv           Output debug messages, default is False                                                                                                                     │
│ --help                  -h               Show this message and exit.                                                                                                                                 │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## montreal-forced-aligner_mfa_configure

### Tool Description
Set global defaults for MFA so you do not have to set them every time you call an MFA command.

### Metadata
- **Docker Image**: mmcauliffe/montreal-forced-aligner:v3.4.3
- **Homepage**: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
- **Package**: https://anaconda.org/channels/bioconda/packages/montreal-forced-aligner/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                                                                                                                                        
 Usage: mfa configure [OPTIONS]                                                                                                                                                                         
                                                                                                                                                                                                        
 The configure command is used to set global defaults for MFA so you don't have to set them every time you call an MFA command.                                                                         
                                                                                                                                                                                                        
╭─ Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --profile                                             -p  TEXT     Configuration profile to use, defaults to "global"                                                                                │
│ --temporary_directory                                 -t  TEXT     Set the default temporary directory.Currently defaults to /mfa                                                                    │
│ --num_jobs                                            -j  INTEGER  Set the number of processes to use by default. Currently defaults to 3                                                            │
│ --always_clean/--never_clean                                       Turn on/off mode where MFA will clean temporary files before each run. Currently defaults to True.                                │
│ --always_final_clean/--never_final_clean                           Turn on/off mode where MFA will clean temporary files at the end of each run. Currently defaults to False.                        │
│ --always_verbose/--never_verbose                                   Turn on/off verbose mode where MFA will print more output. Currently defaults to False.                                           │
│ --always_quiet/--never_quiet                                       Turn on/off quiet mode where MFA will not print any output. Currently defaults to False.                                          │
│ --always_debug/--never_debug                                       Turn on/off extra debugging functionality. Currently defaults to False.                                                           │
│ --always_overwrite/--never_overwrite                               Turn on/off overwriting export files. Currently defaults to False.                                                                │
│ --enable_mp/--disable_mp                                           Turn on/off multiprocessing. Multiprocessing is recommended will allow for faster executions. Currently defaults to True.         │
│ --enable_textgrid_cleanup/--disable_textgrid_cleanup               Turn on/off post-processing of TextGrids that cleans up silences and recombines compound words and clitics. Currently defaults to │
│                                                                    True.                                                                                                                             │
│ --enable_auto_server/--disable_auto_server                         If auto_server is enabled, MFA will start a server at the beginning of a command and close it at the end. If turned off, use the  │
│                                                                    `mfa server` commands to initialize, start, and stop a profile's server. Currently defaults to True.                              │
│ --enable_use_postgres/--disable_use_postgres                       If use_postgres is enabled, MFA will use PostgreSQL as the database backend instead of sqlite. Currently defaults to False.       │
│ --blas_num_threads                                        INTEGER  Number of threads to use for BLAS libraries, 1 is recommended due to how much MFA relies on multiprocessing. Currently defaults   │
│                                                                    to 1.                                                                                                                             │
│ --github_token                                            TEXT     Github token to use for model downloading.                                                                                        │
│ --seed                                                    INTEGER  Random seed to set for various pseudorandom processes.                                                                            │
│ --help                                                -h           Show this message and exit.                                                                                                       │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## Metadata
- **Skill**: generated
