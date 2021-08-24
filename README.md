# FCPP Starting Exercises

Quick-start aggregate computing exercises. The exercises are described in the `run/exercises.cpp` file. All commands below are assumed to be issued from the cloned git repository folder. For any issues, please contact [Giorgio Audrito](mailto:giorgio.audrito@unito.it).


## References

- FCPP main website: [https://fcpp.github.io](https://fcpp.github.io).
- FCPP documentation: [http://fcpp-doc.surge.sh](http://fcpp-doc.surge.sh).
- FCPP sources: [https://github.com/fcpp/fcpp](https://github.com/fcpp/fcpp).


## Setup

The next sections contain the FCPP setup instructions for the various supported OSs. Jump to the section dedicated to your system of choice and ignore the others.

### Windows

Pre-requisites:
- [Git Bash](https://gitforwindows.org) (for issuing unix-style commands)
- [MinGW-w64](http://mingw-w64.org) ([builds 8.1.0](http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/mingw-w64-install.exe/download))
- [CMake 3.9](https://cmake.org) (or higher)

During CMake installation, make sure you select to add `cmake` to the `PATH` (at least for the current user).
During MinGW installation, make sure you select "posix" threads (should be the default) and not "win32" threads. After installing MinGW, you need to add its path to the environment variable `PATH`. The default path should be:
```
C:\Program Files (x86)\mingw-w64\i686-8.1.0-posix-dwarf-rt_v6-rev0\mingw32\bin
```
but the actual path may vary depending on your installation.

### Linux

Pre-requisites:
- Xorg-dev package (X11)
- G++ 9 (or higher)
- CMake 3.9 (or higher)

To install these packages in Ubuntu, type the following command:
```
sudo apt-get install xorg-dev g++ cmake
```

### MacOS

Pre-requisites:
- Xcode Command Line Tools
- CMake 3.9 (or higher)

To install them, assuming you have the [brew](https://brew.sh) package manager, type the following commands:
```
xcode-select --install
brew install cmake
```


## Execution

In order to execute the exercises file, type the following command in a terminal:
```
> ./make.sh gui run -O exercises
```
Running the above command, you should see output about building the executables then the graphical simulation should pop up.

### Graphical User Interface

Executing a graphical simulation will open a window displaying the simulation scenario, initially still: you can start running the simulation by pressing `P` (current simulated time is displayed in the bottom-left corner). While the simulation is running, network statistics will be periodically printed in the console. You can interact with the simulation through the following keys:
- `Esc` to end the simulation
- `P` to stop/resume
- `O`/`I` to speed-up/slow-down simulated time
- `L` to show/hide connection links between nodes
- `G` to show/hide the grid on the reference plane and node pins
- `M` enables/disables the marker for selecting nodes
- `left-click` on a selected node to open a window with node details
- `C` resets the camera to the starting position
- `Q`,`W`,`E`,`A`,`S`,`D` to move the simulation area along orthogonal axes
- `right-click`+`mouse drag` to rotate the camera
- `mouse scroll` for zooming in and out
- `left-shift` added to the camera commands above for precision control
- any other key will show/hide a legenda displaying this list
Hovering on a node will also display its UID in the top-left corner.


## Project Inspection

This project consists of four files (besides git configuration files):
- `run/exercises.cpp`. This contains the actual C++ code (using the FCPP library) that will be run. In-line documentation is provided to show the purpose of its various parts.
- `CMakeLists.txt`. This contains the CMake configuration for the project. The first four lines ensure that the FCPP library is properly loaded. After defining the project, the execution target can be declared through:
  ```
  fcpp_target(executable_name source_path has_gui)
  ```
  where `has_gui` can be either `ON` or `OFF`.
- `make.sh`. This script provides a friendly interface to the build and execution tools. Launching `./make.sh` without arguments shows the relevant help.
- `README.md`, which is this file.
