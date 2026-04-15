---
name: edena
description: Edena provides a standardized interface to interact with multiple AI-as-a-Service engines through a consistent syntax and response format. Use when user asks to translate text, extract keywords, perform object detection, process OCR, or execute asynchronous speech-to-text and video analysis across different AI providers.
homepage: https://github.com/edenai/edenai-apis
metadata:
  docker_image: "quay.io/biocontainers/edena:3.131028--h9948957_8"
---

# edena

## Overview
The `edena` skill provides a standardized interface for interacting with various AI-as-a-Service engines. Instead of managing multiple proprietary SDKs, it allows you to call different AI features (like translation, keyword extraction, or object detection) using a consistent syntax. The tool's primary value lies in its ability to provide a `standardized_response` across all supported providers, making it easy to build provider-agnostic AI workflows.

## Implementation Patterns

### Installation and Setup
Install the package directly from the source:
`pip install git+https://github.com/edenai/edenai-apis`

To configure API credentials:
1. Locate the settings templates in `edenai_apis/api_keys/<provider_name>_settings_templates.json`.
2. Populate the template with your API keys/secrets.
3. Rename the file to `<provider_name>_settings.json`.

### Synchronous Feature Usage
For features that return immediate results (e.g., Text, OCR, Image processing), use the following pattern:

```python
from edenai_apis import Text

# Initialize the specific feature for a provider
keyword_extractor = Text.keyword_extraction("microsoft")

# Execute the call with standardized inputs
response = keyword_extractor(language="en", text="The quick brown fox jumps over the lazy dog")

# Access the standardized output
for item in response.standardized_response.items:
    print(f"Keyword: {item.keyword}, Importance: {item.importance}")

# Access the raw provider response if needed
print(response.original_response)
```

### Asynchronous Feature Usage
For long-running tasks like Speech-to-Text or Video analysis, use the async launch and polling pattern:

```python
from edenai_apis import Audio

provider = "google"

# 1. Launch the job
stt_launch = Audio.speech_to_text_async__launch_job(provider)
launch_res = stt_launch(file=your_file_handle, language="en", speakers=2)
job_id = stt_launch.provider_job_id

# 2. Retrieve the result
stt_get_result = Audio.speech_to_text_async__get_job_result(provider)
result = stt_get_result(provider_job_id=job_id)

print(f"Status: {result.status}") # "pending" | "succeeded" | "failed"
```

## Expert Tips
- **Provider Agnosticism**: To switch providers, you only need to change the string passed to the feature method (e.g., from `"microsoft"` to `"ibm"`). The `standardized_response` schema remains the same.
- **Response Handling**: Always check `standardized_response` first for cross-provider compatibility. Only fall back to `original_response` for provider-specific features not yet mapped by Eden AI.
- **File Handling**: When using audio or image features, ensure the file object or path is valid for the specific provider's constraints (e.g., file size or format).
- **Async Polling**: For async jobs, implement a retry/polling logic with backoff, as job completion times vary significantly between providers.

## Reference documentation
- [Eden AI APIs Main Repository](./references/github_com_edenai_edenai-apis.md)