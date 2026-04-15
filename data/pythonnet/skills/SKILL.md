---
name: pythonnet
description: Pythonnet provides a bridge for seamless integration between the Python and .NET environments. Use when user asks to call .NET classes from Python, load .NET assemblies, embed CPython into .NET applications, or manage interoperability between Python and .NET runtimes.
homepage: https://github.com/pythonnet/pythonnet
metadata:
  docker_image: "quay.io/biocontainers/pythonnet:2.3.0--py27_1"
---

# pythonnet

## Overview
Python for .NET (pythonnet) provides a bridge between the Python and .NET environments. It allows Python programmers to treat .NET namespaces as Python packages, enabling the use of .NET classes, methods, and properties as if they were native Python objects. Conversely, it provides .NET developers with a powerful scripting interface by embedding CPython into .NET applications. It supports multiple runtimes including .NET Framework, Mono, and .NET Core/5+.

## Calling .NET from Python

### Basic Integration
To interact with .NET, you must first import the `clr` module, which provides the Common Language Runtime interface.

```python
import clr
from System import String, Int32
from System.Collections import ArrayList

# Use .NET types directly
list_obj = ArrayList()
list_obj.Add("Pythonnet")
list_obj.Add(42)
```

### Loading Assemblies
Standard library namespaces like `System` are often available by default. For external or specific framework DLLs, use `AddReference`.

```python
import clr
# Load a framework assembly
clr.AddReference("System.Windows.Forms")
from System.Windows.Forms import Form

# Load a custom DLL by filename (without extension)
clr.AddReference("MyCustomLibrary")
import MyNamespace
```

### Selecting the Runtime (.NET Core/5+)
By default, pythonnet targets the .NET Framework (Windows) or Mono (Linux/macOS). To use .NET Core or modern .NET (5/6/7+), you must explicitly load the runtime before importing `clr`.

```python
from pythonnet import load
load("coreclr")
import clr
```
Alternatively, set the environment variable `PYTHONNET_RUNTIME=coreclr`.

## Embedding Python in .NET

### Initialization
Before calling Python code from .NET, you must specify the Python DLL and initialize the engine.

1. **Set the Python DLL**: Set `Runtime.PythonDLL` (e.g., `python310.dll`, `libpython3.10.so`) or the `PYTHONNET_PYDLL` environment variable.
2. **Initialize**: Call `PythonEngine.Initialize()`.
3. **Thread Management**: If using multiple threads, call `PythonEngine.BeginAllowThreads()`.

### Using Python Objects
All interactions with Python objects must occur within a Global Interpreter Lock (GIL) scope. Use the `dynamic` keyword in C# for seamless syntax.

```csharp
using Python.Runtime;

// Initialize
Runtime.PythonDLL = "python310.dll";
PythonEngine.Initialize();

using (Py.GIL()) 
{
    dynamic np = Py.Import("numpy");
    dynamic result = np.cos(np.pi * 2);
    Console.WriteLine(result);
    
    // Passing keyword arguments
    dynamic list = Py.Import("builtins").get("list");
    dynamic sortedList = np.sort(myArray, axis: 0);
}
```

## Expert Tips and Best Practices

### Mathematical Operations
When performing math between Python objects and .NET types, the Python object must come **first** in the expression.
*   **Correct**: `python_obj * 2.0`
*   **Incorrect**: `2.0 * python_obj` (This will often trigger a .NET type error)

### Type Conversion
Pythonnet handles basic marshaling (strings, ints, floats) automatically. For complex types:
*   **Lists/Arrays**: .NET `List<T>` or arrays can be passed to Python, where they behave like collections.
*   **Out/Ref Parameters**: Pythonnet maps .NET `out` and `ref` parameters to Python return values. If a method has one `out` parameter, the Python method returns a tuple: `(return_value, out_param_value)`.

### Troubleshooting DLL Loading
If you encounter `BadPythonDllException` or `MissingMethodException` during initialization:
*   Verify that the Python architecture (x64 vs x86) matches your .NET application's target architecture.
*   Ensure the `PYTHONNET_PYDLL` points to the actual library file, not just the folder.
*   On Linux, ensure `libpython` is in the `LD_LIBRARY_PATH`.

## Reference documentation
- [Python.NET README](./references/github_com_pythonnet_pythonnet.md)
- [Python.NET Wiki](./references/github_com_pythonnet_pythonnet_wiki.md)