---
name: praat
description: Praat is a specialized tool for doing phonetics by computer, capable of analyzing, synthesizing, and manipulating speech.
homepage: https://github.com/praat/praat.github.io
---

# praat

## Overview
Praat is a specialized tool for doing phonetics by computer, capable of analyzing, synthesizing, and manipulating speech. This skill enables the use of Praat in non-GUI environments, focusing on script execution and console-based workflows. It is particularly useful for high-throughput acoustic analysis, automated speech labeling (IPA), and generating speech from muscle activity or pitch curves.

## Command Line Usage
Praat provides specific binaries for command-line and console interaction:
- **praatcon**: The dedicated console executable for Windows.
- **praat --run**: The standard way to execute a script from the command line on macOS and Linux.
- **Barren/Nogui binaries**: Use these specific Linux builds (e.g., `praat_linux_intel64_barren`) for server environments lacking GUI libraries, graphics, or sound drivers.

### Common CLI Patterns
- **Execute a script with arguments**:
  `praat --run your_script.praat "input.wav" "output.txt" 75`
- **Batch processing**:
  Use a master script (e.g., `runAllTests_batch.praat`) to iterate through directories and process multiple files sequentially.

## Scripting Best Practices
- **File I/O**: Use `Read from file...` to bring objects into the Object window (memory) and `Save as...` to export results.
- **Directory Management**: Use `setWorkingDirectory()` to manage relative paths within scripts.
- **Object Selection**: Always explicitly `selectObject: "Sound name"` before performing actions to avoid errors in complex scripts.
- **Clean Up**: Use `Remove` on objects no longer needed to prevent memory bloat during batch processing.
- **Termination**: Use `exitScript()` to stop execution, especially when encountering errors or finishing a headless task.

## Advanced Features
- **Speech Recognition**: Recent versions include `SpeechRecognizer` for word and sentence segmentation.
- **Whisper Integration**: Supports multi-segment Whisper processing for audio files longer than 30 seconds.
- **Manipulation**: Use `To Manipulation...` to modify pitch, duration, or intensity while preserving other acoustic qualities.
- **Labeling**: Automate TextGrid creation for phonetic alignment and IPA labeling.

## Reference documentation
- [Praat README](./references/github_com_praat_praat.github.io.md)
- [Praat Development Commits](./references/github_com_praat_praat.github.io_commits_master.md)