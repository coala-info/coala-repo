---
name: stacks_summary
description: This tool extracts technology stacks, summaries, and implementation challenges from research papers using a RAG-based architecture. Use when user asks to decompose research papers into technical data, extract technology stacks from PDFs, or summarize implementation challenges in academic documents.
homepage: https://github.com/Jayrajsinh-Gohil/ResearchGPT
---


# stacks_summary

## Overview
The `stacks_summary` skill (utilizing the ResearchGPT framework) provides a specialized workflow for decomposing research papers into actionable technical data. It automates the extraction of five key dimensions from any PDF: abstracts, simplified summaries, technology stacks, implementation challenges, and metadata. By leveraging a RAG (Retrieval-Augmented Generation) architecture with Llama3 and ChromaDB, it ensures that the identified technologies and frameworks are grounded in the document's actual text rather than general model knowledge.

## Environment Setup and Initialization
Before running the analysis, ensure the local inference environment is prepared.

*   **Model Preparation**: The tool requires the Llama3 model to be available locally via Ollama.
    ```bash
    ollama pull llama3
    ```
*   **Service Verification**: Confirm the Ollama API is responsive before starting the application.
    ```bash
    curl http://localhost:11434/api/version
    ```
*   **Application Launch**: Start the Flask-based analysis engine.
    ```bash
    python app.py
    ```

## Tool-Specific Best Practices
*   **Hardware Optimization**: Ensure at least 8GB of RAM is available for Llama3 inference. If processing large PDFs (>30 pages), 16GB is recommended to prevent swap-related slowdowns.
*   **Model Customization**: For specialized domains (e.g., deep learning or hardware engineering), you can modify the embedding model in `app.py` to a more domain-specific HuggingFace transformer like `sentence-transformers/all-MiniLM-L6-v2` for faster processing.
*   **Retrieval Tuning**: If the "Tech Stack" extraction is missing niche tools, increase the `k` value (number of chunks retrieved) in the retrieval settings within `app.py`. The default is `k=100`.
*   **Chunk Management**: For papers with dense tables or code snippets, reduce the `chunk_size` to `500` and increase `chunk_overlap` to `100` in the configuration section of `app.py` to ensure context is not lost at boundaries.

## Common CLI Patterns and Troubleshooting
*   **Starting the Backend**: Always run the Ollama service in a separate terminal instance from the Flask app.
    ```bash
    # Terminal 1
    ollama serve

    # Terminal 2
    python app.py
    ```
*   **Port Conflicts**: If port `5000` is occupied, modify the `app.run()` call at the bottom of `app.py` to specify a different port: `app.run(host='0.0.0.0', port=5001)`.
*   **Dependency Management**: If using Conda, ensure the environment is activated to provide the correct Python 3.13.3 runtime.
    ```bash
    conda activate ResearchGPT
    ```

## Expert Tips
*   **Semantic Search Accuracy**: The tool uses ChromaDB for vector storage. If results feel disconnected, clearing the `uploads/` directory and restarting the script will force a fresh re-indexing of the document.
*   **Performance Monitoring**: Pay attention to the "Processing Time" metrics provided in the output. If "Technology extraction" takes significantly longer than "Abstract extraction," it usually indicates the LLM is struggling with a high `k` value or fragmented text chunks.
*   **Network Access**: To allow other devices on a local network to view the extracted stacks, ensure the host firewall allows traffic on port `5000` and access via `http://<your-ip>:5000`.

## Reference documentation
- [ResearchGPT README](./references/github_com_Jayrajsinh-Gohil_ResearchGPT_blob_main_README.md)