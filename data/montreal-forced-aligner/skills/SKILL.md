---
name: montreal-forced-aligner
description: The Montreal Forced Aligner (MFA) is a command-line utility designed to automate the process of aligning speech audio with its corresponding transcript.
homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
---

# montreal-forced-aligner

## Overview

The Montreal Forced Aligner (MFA) is a command-line utility designed to automate the process of aligning speech audio with its corresponding transcript. By utilizing the Kaldi ASR toolkit, it provides highly accurate timing information for words and individual phonemes. This skill enables the user to validate datasets, download pre-trained models, identify out-of-vocabulary (OOV) words, and execute alignment tasks across various languages.

## Core CLI Workflows

### 1. Environment Setup and Verification
Before running alignment, ensure the environment is correctly configured.
- **Check version**: `mfa version`
- **List available models**: `mfa model list acoustic`
- **Download a pre-trained model**: `mfa model download acoustic english_mfa`
- **Download a dictionary**: `mfa model download dictionary english_mfa`

### 2. Validating a Corpus
Always validate your dataset before attempting alignment to catch formatting errors or missing pronunciations.
- **Basic validation**: `mfa validate <corpus_directory> <dictionary_path> <acoustic_model_path>`
- **Identify missing words**: Use `mfa find_oovs <corpus_directory> <dictionary_path> <output_path>` to generate a list of words not present in the dictionary.

### 3. Performing Forced Alignment
The primary command for generating TextGrids from audio and transcripts.
- **Standard alignment**:
  `mfa align <corpus_directory> <dictionary_path> <acoustic_model_path> <output_directory>`
- **Resume/Clean start**: Use the `--clean` flag to reset the temporary directory and metadata if you have modified the corpus or dictionary since the last run.
- **Parallelization**: Use `--num_jobs <number>` to specify the number of CPU cores to use (default is usually all available).

### 4. Advanced Features
- **Grapheme-to-Phoneme (G2P)**: Generate pronunciations for OOV words using a G2P model.
  `mfa g2p <g2p_model_path> <input_path> <output_path>`
- **Transcription**: If you have audio but no transcripts, use a pre-trained model to generate them.
  `mfa transcribe <corpus_directory> <dictionary_path> <acoustic_model_path> <output_directory>`
- **Whisper Integration**: For newer versions, MFA supports Whisper-based transcription.
  `mfa transcribe_whisper <corpus_directory> <output_directory>`

## Expert Tips and Best Practices

- **Audio Format**: Ensure audio is mono and sampled at 16kHz for best results with most pre-trained models. MFA can downsample on the fly, but pre-processing saves time.
- **Dictionary Management**: If `mfa validate` reports many OOV words, use the `mfa g2p` command to predict pronunciations and append them to your dictionary file.
- **Handling OOV Tokens**: Use the `--ignore_oovs` flag during alignment or transcription if you want the process to skip tokens that are not in the dictionary rather than failing or using a generic `<unk>` tag.
- **Fine-tuning**: If alignment quality is low, consider using the `mfa train_acoustic` command to adapt a model specifically to your speakers or recording conditions.
- **Temporary Files**: MFA creates large temporary files in `~/Documents/MFA`. If you run out of disk space, use `mfa configure --temp_directory <path>` to move the cache to a larger drive.

## Reference documentation
- [Montreal Forced Aligner README](./references/github_com_MontrealCorpusTools_Montreal-Forced-Aligner.md)
- [MFA Commit History (Functional Updates)](./references/github_com_MontrealCorpusTools_Montreal-Forced-Aligner_commits_main.md)
- [MFA Issues (Troubleshooting)](./references/github_com_MontrealCorpusTools_Montreal-Forced-Aligner_issues.md)