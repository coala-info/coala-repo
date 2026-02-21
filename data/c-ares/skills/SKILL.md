---
name: c-ares
description: Project Ares is a specialized security tool designed for stealthy PE (Portable Executable) injection into remote processes.
homepage: https://github.com/Cerbersec/Ares
---

# c-ares

## Overview
Project Ares is a specialized security tool designed for stealthy PE (Portable Executable) injection into remote processes. It utilizes the Transacted Hollowing technique to minimize its forensic footprint. The toolset consists of two primary components: a Cryptor for preparing encrypted payloads and an Injector for executing the injection. This skill provides the procedural knowledge required to configure, encrypt, and deploy payloads using the Ares framework.

## Usage and Best Practices

### Payload Preparation (Cryptor)
The Cryptor tool is a console application that prepares your x64 payload for the Injector by applying AES256 CBC encryption.

1.  **Encryption Key Alignment**: Before encryption, ensure the 16-byte encryption key matches in both the Cryptor and Injector source code.
    *   **Cryptor**: Modify `Cryptor/main.cpp` at line 34.
    *   **Injector**: Modify `Injector/main.cpp` at line 329.
2.  **Initialization Vector (IV)**: Optionally modify the 16-byte IV in the source code to ensure unique ciphertexts.
3.  **Execution**: Run the Cryptor via the command line:
    ```bash
    Cryptor.exe <path_to_your_x64_payload>
    ```
    This generates a file named `payload.bin` in the current directory.

### Injector Configuration
The Injector requires manual configuration within the source code before compilation to ensure successful execution and evasion.

*   **Resource Integration**: Add the generated `payload.bin` as a PE resource to the Injector project.
    *   Default resource name: `payload_bin`.
    *   If using a different name, update `Injector/main.cpp` at line 324: `MAKEINTRESOURCE(IDR_PAYLOAD_BIN1), L"YOUR_RESOURCE_NAME"`.
*   **Process Defaults**:
    *   **Target Process**: The loader defaults to spawning `svchost.exe`.
    *   **Parent Process Spoofing**: The loader defaults to spoofing `explorer.exe` as the parent process.
*   **Architecture**: Project Ares is strictly 64-bit. Both the loader and the payload must be x64.

### Evasion Features
Project Ares includes several built-in evasion mechanisms that function automatically but should be understood for troubleshooting:
*   **NTDLL Unhooking**: Refreshes the `.text` section of `ntdll.dll` from the disk version to bypass EDR hooks.
*   **Dynamic Resolution**: Resolves functions dynamically without using standard `LoadLibrary` or `GetProcAddress` calls.
*   **CIG (Code Integrity Guard)**: Blocks non-Microsoft-signed binaries from being loaded into the process.
*   **Sandbox Detection**: Performs basic environment checks to identify if it is running in a virtualized or analysis environment.

## Reference documentation
- [Project Ares Main Repository](./references/github_com_Cerbersec_Ares.md)
- [Ares Source Tree Details](./references/github_com_Cerbersec_Ares_tree_main_Ares.md)