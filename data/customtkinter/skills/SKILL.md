---
name: customtkinter
description: CustomTkinter is a Python library that provides modern, themed widgets for building high-DPI-aware desktop applications on top of Tkinter. Use when user asks to create modern desktop interfaces, implement dark and light mode support, build scalable UI components using an object-oriented approach, or manage high-resolution display scaling.
homepage: https://customtkinter.tomschimansky.com
metadata:
  docker_image: "quay.io/biocontainers/customtkinter:5.2.2--pyh7cba7a3_0"
---

# customtkinter

## Overview

CustomTkinter is a powerful Python UI library built on top of Tkinter that enables the creation of modern, high-DPI-aware desktop applications. It provides a consistent, contemporary aesthetic across Windows, macOS, and Linux by wrapping standard Tkinter components with customizable, themed widgets. Use this skill to implement dark/light mode support, manage complex layouts using the grid system, and build scalable desktop tools using an object-oriented approach.

## Core Implementation Patterns

### Basic Application Structure
Always prefer the Object-Oriented (OO) approach for any application beyond a simple script. This ensures better state management and widget organization.

```python
import customtkinter

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        self.title("My App")
        self.geometry("400x240")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(0, weight=1)

        self.button = customtkinter.CTkButton(self, text="Click Me", command=self.button_callback)
        self.button.grid(row=0, column=0, padx=20, pady=20)

    def button_callback(self):
        print("Button clicked")

if __name__ == "__main__":
    app = App()
    app.mainloop()
```

### Global Configuration
Set the visual environment before initializing the main window.

*   **Appearance Mode**: `customtkinter.set_appearance_mode("System")` (Options: "System", "Dark", "Light")
*   **Color Theme**: `customtkinter.set_default_color_theme("blue")` (Options: "blue", "green", "dark-blue" or a path to a JSON theme file)

### Layout Management
CustomTkinter works best with the `grid` geometry manager.
*   Use `grid_columnconfigure` and `grid_rowconfigure` on the parent container to ensure widgets resize correctly.
*   Use `sticky="nsew"` to make widgets expand to fill their grid cells.

### High-DPI Scaling
CustomTkinter handles scaling automatically, but you can manually adjust it if needed:
*   `customtkinter.set_widget_scaling(float)` (e.g., 1.2 for 120%)
*   `customtkinter.set_window_scaling(float)`

## Tool-Specific Best Practices

1.  **Widget Reusability**: Create custom components by inheriting from `customtkinter.CTkFrame`. This allows you to bundle labels, entries, and buttons into a single logical unit.
2.  **Image Handling**: Use `customtkinter.CTkImage` for icons and images. It supports separate light and dark versions of the same image to ensure visibility across themes.
3.  **Main Loop**: Never use `time.sleep()` in a CustomTkinter app as it freezes the UI. Use `self.after(milliseconds, function)` for delayed or repeated tasks.
4.  **Thread Safety**: If performing heavy background tasks, use the `threading` module and update UI elements only via `self.after()` to avoid crashes.

## Common CLI Operations

### Installation and Maintenance
Install or update the library using standard package managers.

*   **Pip**:
    *   Install: `pip install customtkinter`
    *   Upgrade: `pip install customtkinter --upgrade`
*   **Conda**:
    *   Install: `conda install bioconda::customtkinter`

## Reference documentation
- [Official Documentation Introduction](./references/customtkinter_tomschimansky_com_documentation.md)
- [Main Page and Code Examples](./references/customtkinter_tomschimansky_com_index.md)
- [Tutorial Overview](./references/customtkinter_tomschimansky_com_tutorial.md)
- [Anaconda/Conda Package Info](./references/anaconda_org_channels_bioconda_packages_customtkinter_overview.md)