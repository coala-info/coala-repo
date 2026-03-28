---
name: montreal-forced-aligner
description: The Montreal Forced Aligner synchronizes audio files with text transcripts to produce precise word-level and phone-level timestamps. Use when user asks to align speech corpora, validate dataset consistency, manage acoustic models, or generate pronunciation dictionaries using grapheme-to-phoneme conversion.
homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner
---


# montreal-forced-aligner

## Overview

The Montreal Forced Aligner (MFA) is a high-performance command-line utility used to synchronize audio files with their corresponding text transcripts. Built on the Kaldi ASR toolkit, it produces precise word-level and phone-level boundaries in TextGrid format. Use this skill to automate the alignment of large speech corpora, validate dataset consistency, and manage pretrained acoustic models and pronunciation dictionaries.

## Common CLI Patterns

### Model Management
Before aligning, you must obtain the necessary language resources.
- **List available models**: `mfa model list acoustic`
- **Download a pretrained model**: `mfa model download acoustic english_mfa`
- **Download a dictionary**: `mfa model download dictionary english_mfa`

### Validation
Always validate your corpus before starting a long alignment process to identify missing files, OOV (Out-Of-Vocabulary) words, or audio-transcript mismatches.
- **Basic validation**: `mfa validate /path/to/corpus /path/to/dictionary.dict english_mfa`
- **Validation with OOV output**: `mfa validate /path/to/corpus /path/to/dictionary.dict english_mfa --output_oovs /path/to/oovs.txt`

### Alignment
The core command for generating TextGrids.
- **Standard alignment**: `mfa align /path/to/corpus /path/to/dictionary.dict english_mfa /path/to/output_directory`
- **Alignment with specific number of jobs**: `mfa align /path/to/corpus /path/to/dictionary.dict english_mfa /path/to/output_directory -j 8`
- **Resume a failed alignment**: `mfa align /path/to/corpus /path/to/dictionary.dict english_mfa /path/to/output_directory --clean false`

### G2P (Grapheme-to-Phoneme)
Generate pronunciation dictionaries for words not found in your existing dictionary.
- **Generate dictionary**: `mfa g2p /path/to/oov_list.txt english_mfa_g2p /path/to/output_dictionary.dict`

## Expert Tips and Best Practices

- **Transcripts**: Ensure transcripts are plain text. Remove punctuation and normalize numbers (e.g., "10" to "ten") unless the dictionary specifically supports them.
- **Audio Format**: Use 16kHz or 44.1kHz mono WAV files for best results. MFA can handle other formats but converts them internally, which increases processing time.
- **The `--clean` Flag**: If you encounter database errors or unexpected behavior, use the `--clean` flag to wipe the temporary directory and start fresh.
- **Speaker Adaptation**: For better precision on long recordings of a single speaker, MFA automatically performs speaker adaptation (SAT). Ensure your corpus directory is structured by speaker (e.g., `corpus/speaker_id/file.wav`) to leverage this.
- **Handling OOV Words**: If validation shows many OOV words, use the `g2p` command to generate pronunciations rather than manually guessing, as this maintains consistency with the acoustic model's phone set.
- **Database Management**: MFA uses a backend database (PostgreSQL). If running in a restricted environment like Docker, ensure the server is initialized using `mfa server init` before attempting alignment.



## Subcommands

| Command | Description |
|---------|-------------|
| mfa | Download an acoustic model for Montreal Forced Aligner. |
| montreal-forced-aligner_mfa | Validate the alignment files for a corpus. |
| train_acoustic | Train an acoustic model. |

## Reference documentation
- [Montreal Forced Aligner README](./references/github_com_MontrealCorpusTools_Montreal-Forced-Aligner_blob_main_README.md)
- [MFA Documentation Home](./references/montrealcorpustools_github_io_Montreal-Forced-Aligner.md)
- [MFA Docker Configuration](./references/github_com_MontrealCorpusTools_Montreal-Forced-Aligner_blob_main_Dockerfile.md)