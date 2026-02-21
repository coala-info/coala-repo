---
name: bmtool
description: BMTools is a framework designed to bridge Large Language Models with external functional tools.
homepage: https://github.com/OpenBMB/BMTools
---

# bmtool

## Overview
BMTools is a framework designed to bridge Large Language Models with external functional tools. It allows for the execution of complex tasks by delegating specific sub-tasks to specialized APIs or local Python scripts. It is particularly useful for workflows requiring real-time data (like Google Scholar), specialized computation (WolframAlpha), or custom local code execution.

## Setup and Environment
To initialize the environment for tool usage:

1. Clone the repository and install dependencies:
   ```bash
   git clone git@github.com:OpenBMB/BMTools.git
   cd BMTools
   pip install -r requirements.txt
   python setup.py develop
   ```
2. Configure API keys by editing `secret_keys.sh`.
3. Load keys into the environment: `source secret_keys.sh`.

## Hosting and Using Tools

### Local Tool Hosting
To serve tools locally for the agent to access:
1. Start the local tool server: `python host_local_tools.py`.
2. Access tools via the local URL pattern: `http://127.0.0.1:8079/tools/{tool_name}/`.

### Single Tool Execution
Use the `STQuestionAnswerer` for tasks requiring a specific plugin:
```python
from bmtools.agent.singletool import load_single_tools, STQuestionAnswerer

tool_name, tool_url = 'klarna', 'https://www.klarna.com/'
tool_name, tool_config = load_single_tools(tool_name, tool_url)
stqa = STQuestionAnswerer()
agent = stqa.load_tools(tool_name, tool_config)
agent("Your question here")
```

### Multi-Tool Orchestration
Use `MTQuestionAnswerer` to allow the model to recursively call multiple tools to solve complex queries:
```python
from bmtools.agent.tools_controller import load_valid_tools, MTQuestionAnswerer

tools_mappings = {
    "klarna": "https://www.klarna.com/",
    "wolframalpha": "http://127.0.0.1:8079/tools/wolframalpha/",
}
tools = load_valid_tools(tools_mappings)
qa = MTQuestionAnswerer(openai_api_key='YOUR_KEY', all_tools=tools)
agent = qa.build_runner()
agent("Your complex multi-part question")
```

## Developing Custom Tools
To create a new tool, define the logic in Python and register it with the BMTools registry.

1. Define the tool and its endpoints using Pydantic models for input/output:
   ```python
   from bmtools.tools import Tool
   from pydantic import BaseModel

   class Query(BaseModel):
       input_text: str

   def build_custom_tool(config) -> Tool:
       tool = Tool("CustomTool", "Description for model", name_for_model="custom", description_for_model="Detailed usage instructions")
       
       @tool.get("/action")
       def my_action(query: Query):
           return {"result": "processed " + query.input_text}
       return tool
   ```
2. Register the tool:
   ```python
   from bmtools.tools import register
   @register("custom")
   def register_custom_tool():
       return build_custom_tool()
   ```

## Optimization Best Practices
* **Model Descriptions**: Ensure `description_for_model` is explicit about when and how the model should trigger the tool.
* **Naming**: Match the function name with the `@tool.get/post` path name to improve model selection accuracy.
* **Docstrings**: Use detailed docstrings for each API function to guide the model's decision-making process.
* **Error Handling**: Return informative error messages from tool functions so the model can attempt retries or alternative paths.

## Reference documentation
- [BMTools Main Documentation](./references/github_com_OpenBMB_BMTools.md)