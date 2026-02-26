---
name: python
description: This skill provides guidance and best practices for using the Python programming language and its ecosystem. Use when user asks to write, debug, or execute Python code, understand Python syntax, libraries, or frameworks, interact with Python packages and environments, leverage Python for scripting, data analysis, web development, or other programming tasks, or find relevant Python libraries for specific functionalities.
homepage: https://github.com/vinta/awesome-python
---


# python

This skill provides guidance and best practices for using the Python programming language and its ecosystem.
  Use this skill when Claude needs to:
  - Write, debug, or execute Python code.
  - Understand Python syntax, libraries, or frameworks.
  - Interact with Python packages and environments.
  - Leverage Python for scripting, data analysis, web development, or other programming tasks.
  - Find relevant Python libraries for specific functionalities.
body: |
  ## Overview
  This skill is designed to assist with all aspects of Python programming. It covers fundamental concepts, common usage patterns, and expert tips for leveraging Python's extensive libraries and tools. Whether you're writing a simple script, developing a complex application, or analyzing data, this skill can provide the necessary guidance.

  ## Core Python Usage and Best Practices

  Python is a versatile, high-level, interpreted programming language known for its readability and extensive standard library.

  ### Basic Syntax and Concepts

  *   **Variables and Data Types**: Python is dynamically typed. Common types include integers (`int`), floating-point numbers (`float`), strings (`str`), lists (`list`), tuples (`tuple`), dictionaries (`dict`), and booleans (`bool`).
  *   **Control Flow**: Use `if`, `elif`, `else` for conditional execution, and `for`, `while` loops for iteration.
  *   **Functions**: Define functions using `def`. They can accept arguments and return values.
  *   **Modules and Packages**: Organize code into modules (`.py` files) and packages (directories with `__init__.py`). Import them using `import` or `from ... import ...`.
  *   **Object-Oriented Programming**: Python supports classes and objects. Define classes using `class`.

  ### Common CLI Patterns

  When interacting with Python from the command line, consider these patterns:

  *   **Running a Python script**:
      ```bash
      python your_script.py
      ```
      or
      ```bash
      python3 your_script.py
      ```
      (depending on your system's configuration)

  *   **Interactive Python interpreter**:
      ```bash
      python
      ```
      or
      ```bash
      python3
      ```
      This opens a REPL (Read-Eval-Print Loop) where you can execute Python code interactively.

  *   **Executing a single Python command**:
      ```bash
      python -c "print('Hello, world!')"
      ```

  *   **Executing a Python file directly (if it has a shebang line)**:
      Make the script executable:
      ```bash
      chmod +x your_script.py
      ```
      Then run it:
      ```bash
      ./your_script.py
      ```
      (Ensure the shebang line, e.g., `#!/usr/bin/env python3`, is at the top of `your_script.py`)

  ### Package Management with pip

  `pip` is the standard package installer for Python.

  *   **Install a package**:
      ```bash
      pip install package_name
      ```
      For specific versions:
      ```bash
      pip install package_name==1.2.3
      ```
      Or a version range:
      ```bash
      pip install "package_name>=1.0,<2.0"
      ```

  *   **Uninstall a package**:
      ```bash
      pip uninstall package_name
      ```

  *   **List installed packages**:
      ```bash
      pip list
      ```

  *   **Freeze installed packages (to a requirements file)**:
      ```bash
      pip freeze > requirements.txt
      ```

  *   **Install packages from a requirements file**:
      ```bash
      pip install -r requirements.txt
      ```

  ### Virtual Environments

  Virtual environments are crucial for managing project dependencies and avoiding conflicts.

  *   **Creating a virtual environment (using `venv`)**:
      ```bash
      python -m venv myenv
      ```
      (Replace `myenv` with your desired environment name)

  *   **Activating a virtual environment**:
      *   On Windows:
          ```bash
          myenv\Scripts\activate
          ```
      *   On macOS/Linux:
          ```bash
          source myenv/bin/activate
          ```

  *   **Deactivating a virtual environment**:
      ```bash
      deactivate
      ```

  ### Expert Tips and Libraries

  *   **Readability**: Python emphasizes readable code. Use meaningful variable names, consistent indentation, and comments where necessary.
  *   **Standard Library**: Leverage Python's rich standard library for common tasks (e.g., `os`, `sys`, `datetime`, `json`, `re`).
  *   **Awesome Python**: For a curated list of Python frameworks, libraries, software, and resources, refer to the `awesome-python` repository. This is an excellent resource for discovering tools for various domains like web development, data science, machine learning, and more.
      *   **Web Frameworks**: Django, Flask, FastAPI.
      *   **Data Science**: NumPy, Pandas, SciPy, Matplotlib, Scikit-learn.
      *   **Machine Learning**: TensorFlow, PyTorch, Keras.
      *   **Natural Language Processing**: NLTK, spaCy, Hugging Face Transformers.
      *   **Web Scraping**: Beautiful Soup, Scrapy, Selenium.
  *   **Error Handling**: Use `try`, `except`, `finally` blocks for robust error management.
  *   **List Comprehensions and Generator Expressions**: These provide concise ways to create lists and iterators, often improving performance and readability.
      ```python
      # List comprehension
      squares = [x**2 for x in range(10)]

      # Generator expression
      squares_gen = (x**2 for x in range(10))
      ```
  *   **Decorators**: Use decorators (`@decorator_name`) to modify or enhance functions or methods.

  ## Reference documentation
  - [Awesome Python](./references/github_com_vinta_awesome-python.md)
  - [Python Overview](./references/anaconda_org_channels_main_packages_python_overview.md)