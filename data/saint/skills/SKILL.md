---
name: saint
description: sAINT is a Java-based spyware generator designed to create payloads for Windows systems.
homepage: https://github.com/tiagorlampert/sAINT
---

# saint

## Overview
sAINT is a Java-based spyware generator designed to create payloads for Windows systems. It enables the creation of custom monitoring tools that can capture keystrokes, take screenshots, access webcams, and maintain persistence on a target machine. The tool is typically operated from a Linux environment (like Kali Linux) to generate either .JAR or .EXE files that are then deployed to Windows targets.

## Environment Setup
The generator requires Java Development Kit (JDK) 8 and Maven to function correctly.

### Linux (Kali) Dependencies
Install the core requirements:
```bash
apt install maven default-jdk default-jre openjdk-8-jdk openjdk-8-jre -y
```

To enable .EXE generation via launch4j, install these additional libraries:
```bash
apt install zlib1g-dev libncurses5-dev lib32z1 lib32ncurses6 -y
```

### Windows Requirements
The target machine must have the latest Java JRE 8 from Oracle installed to execute the generated payloads.

## Usage Workflow

### 1. Initialization
After cloning the repository, you must configure the Maven libraries:
```bash
chmod +x configure.sh
./configure.sh
```

### 2. Launching the Generator
Run the generator interface:
```bash
java -jar sAINT.jar
```

### 3. Configuration Options
When running the generator, you will be prompted to configure the following:
- **E-mail Settings**: Payloads send data to a specified email once a character threshold is reached.
- **Features**: Toggle Keylogger, Screenshot, Webcam Capture, and Persistence.
- **Output Format**: Choose between a portable .JAR or a Windows-native .EXE.

## Best Practices and Tips
- **Persistence**: Enable the persistence option if you need the spyware to survive system reboots.
- **Character Threshold**: Set a reasonable character limit for email triggers to balance between data loss and excessive notification volume.
- **Administrative Rights**: While the payload can run with standard user permissions, the `UNINSTALL.bat` script requires administrative permissions to successfully remove the spyware and its persistence mechanisms.
- **JRE Dependency**: Always verify the target environment has JRE 8; the .EXE wrapper created by launch4j still requires the Java runtime to translate bytecode to machine language.

## Reference documentation
- [sAINT Main Repository](./references/github_com_tiagorlampert_sAINT.md)