---
name: lamarc
description: Lamarc automates the creation of transcripts and metadata from media files using the Deepgram API. Use when user asks to generate SRT subtitles, transcribe audio or video files, or create markdown documents with specific timestamps.
homepage: https://github.com/ChristopherBiscardi/lamarck
metadata:
  docker_image: "biocontainers/lamarc:v2.1.10.1dfsg-3-deb_cv1"
---

# lamarc

---

## Overview

The `lamarc` skill (utilizing the `lamarck` CLI tool) is a specialized audio/visual toolkit designed to automate the creation of metadata from media files. Its primary function is to interface with the Deepgram API to perform high-accuracy transcription. You should use this skill to quickly generate `.srt` files for video accessibility, plain text transcripts for documentation, or markdown files that link directly to specific video timestamps.

## CLI Usage and Best Practices

The core command for this tool is `lamarck caption`. It requires a valid Deepgram API key and an input source (either a local file path or a remote URL).

### Basic Command Structure
```bash
lamarck caption --deepgram-api-key <YOUR_KEY> --input <PATH_OR_URL> [OUTPUT_FLAGS]
```

### Output Formats
You can request multiple output types in a single execution by combining flags:
- **SRT Subtitles**: Use `-s` or `--srt` to generate a standard subtitle file.
- **Plain Transcript**: Use `-t` or `--transcript` for a raw text dump of the audio.
- **Markdown with Timestamps**: Use `-m` or `--markdown` to create a file with links to specific video timestamps, useful for "marking" clips in a live stream or long-form video.
- **JSON Output**: Use the `--json` flag (supported in newer versions) to get the raw structured data from the transcription engine.

### Expert Tips and Patterns

1. **Environment Variables**: To avoid exposing your API key in shell history, export it as an environment variable or use a secret manager:
   ```bash
   lamarck caption --deepgram-api-key $DEEPGRAM_API_KEY --input ./interview.mp3 -s -t
   ```

2. **Processing Remote Media**: The tool natively supports URLs. You can point it directly to a hosted audio file without downloading it first:
   ```bash
   lamarck caption -i https://example.com/podcast.mp3 --deepgram-api-key $KEY -m
   ```

3. **Diarization**: When generating subtitles for multi-speaker audio, ensure you use the diarization option (if supported by your version) to distinguish between different voices in the SRT output.

4. **Custom Output Paths**: Use the `-o` or `--output-path` flag to define a specific directory or filename for the results, preventing the tool from defaulting to the input file's directory.

5. **JSON Input**: For advanced workflows, `lamarck` supports passing a JSON file as an input for direct processing if you have pre-existing Deepgram response data.

## Reference documentation
- [Lamarck Main Repository](./references/github_com_ChristopherBiscardi_lamarck.md)
- [Lamarck Commit History (Feature Updates)](./references/github_com_ChristopherBiscardi_lamarck_commits_main.md)