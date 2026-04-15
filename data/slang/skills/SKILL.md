---
name: slang
description: Slang is a modular shading language and compiler that extends HLSL to support modern programming constructs and multi-platform shader deployment. Use when user asks to compile shaders to SPIR-V, DXIL, MSL, or CUDA, manage large-scale shader codebases using generics and modules, or implement automatic differentiation for graphics tasks.
homepage: https://github.com/shader-slang/slang
metadata:
  docker_image: "quay.io/biocontainers/slang:2.3.0--hd3527cb_3"
---

# slang

## Overview
Slang is a modular shading language designed to simplify the management of large-scale, high-performance shader codebases. It extends the familiar HLSL syntax with modern programming constructs such as generics, interfaces, and a robust module system. By using the Slang compiler (`slangc`), developers can author shaders once and target multiple backends—including SPIR-V, DXIL, MSL, and CUDA—while maintaining the ability to leverage platform-specific hardware features.

## Command Line Usage (slangc)

The primary tool for interacting with Slang is the `slangc` compiler.

### Basic Compilation
To compile a Slang source file to a specific target:
```bash
slangc input.slang -target <target-format> -o output.<ext>
```
Common targets include:
- `spirv`: For Vulkan
- `dxil` or `dxbc`: For Direct3D 12 or 11
- `msl`: For Metal
- `cuda`: For NVIDIA CUDA
- `cpp`: For CPU execution

### Specifying Entry Points
If your file contains multiple entry points or does not use the `[shader("...")]` attribute, specify them via CLI:
```bash
slangc shader.slang -entry main -stage vertex -target spirv
```

### Module and Search Paths
Slang supports modular code. Use `-I` to add include paths and `-p` to add module search paths:
```bash
slangc main.slang -p ./modules -I ./include -target spirv
```

### Diagnostic Control
Control how the compiler reports errors and warnings:
- `-diagnostic-color [auto|never|always]`: Toggle colored output.
- `-warnings-as-errors`: Treat all warnings as compilation failures.

## Language Best Practices

### Use Generics over Preprocessor Macros
Instead of using `#ifdef` or string-pasting for shader permutations, use Slang's generics and interfaces. This allows for pre-checked code and better error messages.
```slang
interface IColorMapper {
    float3 map(float3 color);
}

struct LinearMapper : IColorMapper {
    float3 map(float3 color) { return color; }
}

void process<T : IColorMapper>(float3 c, T mapper) {
    float3 result = mapper.map(c);
}
```

### Leveraging HLSL Compatibility
Slang is highly compatible with HLSL. You can often rename `.hlsl` files to `.slang` and compile them directly. Use the Slang module system to wrap existing HLSL code into reusable components.

### Automatic Differentiation
For neural graphics or optimization tasks, use the `diff` keyword to enable automatic differentiation:
- Use `[derivative(funcName)]` to specify custom derivatives.
- Use `bwd_diff` and `fwd_diff` for backward and forward propagation.

### Resource Binding
Slang provides flexible binding syntax. While it supports HLSL-style `register` and `packoffset`, it is recommended to use Slang's parameter blocks for better organization in modern APIs like Vulkan and D3D12.

## Expert Tips
- **Reflection**: Use the Slang Reflection API to programmatically query shader parameters, structures, and entry points at runtime.
- **Capability System**: Use Slang's capability system to ensure your code only uses features available on your target platform (e.g., checking for ray tracing support during type-checking).
- **Debugging**: When targeting textual formats like MSL or CUDA, Slang produces readable code that preserves identifier names, making it significantly easier to debug generated kernels.
- **Downstream Compilers**: Slang often acts as a front-end. Ensure your environment has the necessary downstream compilers (like `dxc` for DXIL or `glslangValidator` for SPIR-V) if you are performing full end-to-end compilation.

## Reference documentation
- [Slang Main Repository](./references/github_com_shader-slang_slang.md)
- [Slang Wiki and Documentation](./references/github_com_shader-slang_slang_wiki.md)