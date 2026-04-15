---
name: xsd
description: The `xsdata` tool generates Python dataclasses from XML schemas (XSD, WSDL) and facilitates binding XML and JSON data to these objects. Use when user asks to generate Python models from XSD or WSDL, parse XML into Python objects, or serialize Python objects to XML.
homepage: https://github.com/tefra/xsdata
metadata:
  docker_image: "quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4"
---

# xsd

## Overview
The `xsdata` tool is a high-performance data binding library for Python. It allows you to treat XML and JSON documents as simple Python objects (dataclasses) rather than navigating complex tree structures. By providing a robust code generator and an optimized parser/serializer, it simplifies the integration of XML-based protocols and schemas into modern Python workflows.

## Installation
To use the full suite of features, including the command-line interface and optimized handlers:
```bash
pip install xsdata[cli,lxml,soap]
```

## Command Line Interface (CLI)
The `generate` command is the core of the tool, used to convert schemas into Python source code.

### Basic Code Generation
Generate Python dataclasses from a local XSD file:
```bash
xsdata generate path/to/schema.xsd --package my_models
```

### Generating from Multiple Sources
You can pass multiple files or use wildcards to generate a unified model:
```bash
xsdata generate schemas/*.xsd --package my_models
```

### Generating from Remote URLs
The tool can fetch and process schemas directly from the web:
```bash
xsdata generate https://example.com/services.wsdl --package my_models
```

## Data Binding in Python
Once models are generated, use the `XmlParser` and `XmlSerializer` to handle data.

### Parsing XML to Objects
```python
from my_models import MyRootElement
from xsdata.formats.dataclass.parsers import XmlParser

parser = XmlParser()
obj = parser.parse("data.xml", MyRootElement)
```

### Serializing Objects to XML
```python
from xsdata.formats.dataclass.serializers import XmlSerializer
from xsdata.formats.dataclass.serializers.config import SerializerConfig

config = SerializerConfig(pretty_print=True)
serializer = XmlSerializer(config=config)
xml_output = serializer.render(obj)
```

## Expert Tips and Best Practices
- **Use lxml for Performance**: When installing, include the `lxml` extra. `xsdata` will automatically use the faster `lxml` handlers if available.
- **Namespace Handling**: If your XML uses prefixes, `xsdata` handles them via metadata in the generated dataclasses. You can customize prefix mapping during serialization using the `SerializerConfig`.
- **WSDL and SOAP**: Use the tool to generate client-side models for SOAP services by pointing the generator at a WSDL definition.
- **Validation**: While `xsdata` is "naive" (focusing on data binding), it is tested against the W3C XML Schema 1.1 test suite, ensuring high compatibility with complex schema features like unions, substitutions, and choice blocks.

## Reference documentation
- [xsdata README](./references/github_com_tefra_xsdata.md)