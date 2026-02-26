---
name: stanfordcorenlp
description: Stanford CoreNLP provides a comprehensive suite of linguistic analysis tools for processing English and Chinese text. Use when user asks to perform tokenization, part-of-speech tagging, syntactic parsing, named entity recognition, or coreference resolution.
homepage: https://github.com/elisa-aleman/StanfordCoreNLP_Chinese
---


# stanfordcorenlp

## Overview
Stanford CoreNLP is a comprehensive suite of linguistic analysis tools. This skill facilitates the processing of Chinese and English text by bridging the Java-based CoreNLP server with Python workflows. It is particularly useful for tasks requiring high-accuracy segmentation, syntactic parsing, and coreference resolution where standard library-based NLP might be insufficient.

## Server Configuration and Execution
The CoreNLP server must be running to handle requests from the Python client.

### Environment Setup
Ensure `CORENLP_HOME` is set to your installation directory and all `.jar` files are in your `CLASSPATH`.

**Linux/macOS:**
```bash
export CORENLP_HOME="/path/to/stanford-corenlp-4.1.0"
for file in `find $CORENLP_HOME -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done
```

### Starting the Server
Run the server from the root directory. For Chinese processing, specify the Chinese properties file.

**Chinese Server Command:**
```bash
java -Xmx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -serverProperties StanfordCoreNLP-chinese.properties -port 9000 -timeout 15000
```

**English Server Command:**
```bash
java -Xmx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9000 -timeout 15000
```

## Python Integration via Stanza
Use the `CoreNLPClient` to interact with the running server.

### Basic Usage (English)
```python
from stanza.server import CoreNLPClient

text = "Stanford CoreNLP provides a set of natural language analysis tools."
with CoreNLPClient(
    annotators=['tokenize','ssplit','pos','lemma','ner','parse','depparse','coref'],
    timeout=30000,
    memory='16G') as client:
    ann = client.annotate(text)
```

### Chinese Processing Properties
Chinese requires a specific properties dictionary to handle segmentation and language-specific models.

```python
chinese_properties = {
    'annotators': ('tokenize', 'ssplit', 'pos', 'lemma', 'ner', 'parse', 'coref'),
    'tokenize.language': 'zh',
    'segment.model': 'edu/stanford/nlp/models/segmenter/chinese/ctb.gz',
    'segment.sighanCorporaDict': 'edu/stanford/nlp/models/segmenter/chinese',
    'segment.serDictionary': 'edu/stanford/nlp/models/segmenter/chinese/dict-chris6.ser.gz',
    'segment.sighanPostProcessing': True,
    'ssplit.boundaryTokenRegex': '[.。]|[!?！？]+',
    'pos.model': 'edu/stanford/nlp/models/pos-tagger/chinese-distsim/chinese-distsim.tagger'
}

with CoreNLPClient(properties=chinese_properties, timeout=30000, memory='16G') as client:
    ann = client.annotate(chinese_text)
```

## Expert Tips and Best Practices
- **Memory Allocation**: Always provide at least 4GB (`-Xmx4g`) to the Java process. For complex parsing or large documents, increase this to 8GB or 16GB.
- **Timeout Management**: Increase the `timeout` parameter (in milliseconds) when processing very long sentences or using the `coref` (coreference) annotator, as these are computationally expensive.
- **Sentence Splitting**: For Chinese, ensure `ssplit.boundaryTokenRegex` includes both Western and Chinese punctuation (e.g., `。` and `！`) to prevent the parser from treating the entire document as a single sentence.
- **Pre-tokenized Text**: If your text is already segmented, use the `tokenize.whitespace` property set to `True` to skip the internal segmenter.

## Reference documentation
- [StanfordCoreNLP Chinese and English](./references/github_com_elisa-aleman_StanfordCoreNLP_Chinese.md)