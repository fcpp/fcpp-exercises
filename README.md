# FCPP Starting Exercises

Quick-start aggregate computing exercises. The exercises themselves are described in the [run/exercises.cpp](https://github.com/fcpp/fcpp-exercises/blob/master/run/exercises.cpp) file. All commands below are assumed to be issued from the cloned git repository folder. For any issues, please contact [Giorgio Audrito](mailto:giorgio.audrito@unito.it).


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
In Fedora, the `xorg-dev` package is not available. Instead, install the packages:
```
libX11-devel libXinerama-devel.x86_6 libXcursor-devel.x86_64 libXi-devel.x86_64 libXrandr-devel.x86_64 mesa-libGL-devel.x86_64
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

### Virtual Machines

If you use a VM with a graphical interface, refer to the section for the operating system installed on it.

**Warning:** the graphical simulations are based on OpenGL, and common Virtual Machine software (e.g., VirtualBox) has faulty support for OpenGL. If you rely on a virtual machine for graphical simulations, it might work provided that you select hardware virtualization (as opposed to software virtualization). However, it is recommended to use the native OS whenever possible.


## Execution

In order to execute the exercises file, type the following command in a terminal:
```
> ./make.sh gui run -O exercises
```
Running the above command, you should see output about building the executables then the graphical simulation should pop up while the console will show the most recent `stdout` and `stderr` outputs of the application, together with resource usage statistics (both on RAM and CPU).  During the execution, log files will be generated in the `output/` repository sub-folder. If a batch of multiple simulations is launched (which is not the case for the `exercises` target), individual simulation results will be logged in the `output/raw/` subdirectory, with the overall resume in the `output/` directory).

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

- [run/exercises.cpp](https://github.com/fcpp/fcpp-exercises/blob/master/run/exercises.cpp). This contains the actual C++ code (using the FCPP library) that will be run. In-line documentation is provided to show the purpose of its various parts. This file consists of three sections with different purposes:
    - First, the **introduction** section imports the FCPP library and declares a series of _tags_ (empty types) and _constexpr_ constants to be later used both in the _aggregate program_ and _system setup_.
    - Then, the **aggregate program** section specifies the behaviour to be executed on the distributed system, through a _field calculus_-like dialect of C++.
    - Finally, the **system setup** section specifies the execution settings under which the program is to be run, encoding them into empty types that are passed as options to the main FCPP classes.

  More details on these sections are given below.
- [CMakeLists.txt](https://github.com/fcpp/fcpp-exercises/blob/master/CMakeLists.txt). This contains the CMake configuration for the project. The first four commands (line 1-8) ensure that the FCPP library is properly loaded. After defining the project, the execution targets can be declared through:
  ```
  fcpp_target(executable_path has_gui)
  ```
  where `has_gui` can be either `ON` or `OFF`. The file name (without directory and extensions) of every declared target needs to be unique. If needed, automated tests can similarly be defined through:
  ```
  fcpp_test(executable_path)
  ```
- [make.sh](https://github.com/fcpp/fcpp-exercises/blob/master/make.sh). This script provides a friendly interface to the build and execution tools. Launching `./make.sh` without arguments shows the relevant help. The most common usages are:
    - `./make.sh doc`: build the doxygen documentation (needs a `Doxyfile` such as the one available in [fcpp/src/Doxyfile](https://github.com/fcpp/fcpp/blob/master/src/Doxyfile) to be present in the main repository folder)
    - `./make.sh gui run -O all`: perform an optimised build and run of every target (with GUI enabled)
    - `./make.sh test all`: perform all automated tests
- [README.md](https://github.com/fcpp/fcpp-exercises/blob/master/README.md), which is this file.


## Aggregate Program

Work in progress.

### Aggregate function definition and exports

Main function, auxiliary functions, generic functions, exports.

### Function call patterns

Pure calls, aggregate calls, built-in calls, common built-ins.

### Basic types

Numeric aliases; colors, shapes and vecs; tuples and operators; fields and operators ([API reference](http://fcpp-doc.surge.sh/dir_a649fd95b532dff35a9ca005b15ee438.html)). This includes `to_field` and `to_local` and the concepts of default/exceptions of a field (and how they can be applied to locals as well).

### Coordination operators

FCPP contains three operations peculiar to the *Aggregate Programming* model, allowing to:

- share information with neighbours (`nbr`)
- recall values computed in the previous round (`old`)
- do both things simultanously (`oldnbr`)

See also the [FCPP presentation paper](http://giorgio.audrito.info/static/fcpp.pdf) and the [API reference](http://fcpp-doc.surge.sh/calculus_8hpp.html) for detailed information. 

The `nbr` operator comes in four flavors, with increasing level of expressiveness, differing from their argument number and type:

- `to_field<A> nbr(ARGS, A const& f)`
    - `f`: a value of type `A` to be sent to neighbours.
    - *returns:* a neighbouring field, where the default value coincides with the default of `f`, and exceptions are the most recent values for the current device sent by neighbours through the `f` they passed on their round (including the previous round of the current devices, if there was one).
    - *equivalent to:* `nbr(CALL, f, f)`
- `to_field<A> nbr(ARGS, A const& f0, A const& f)`
    - `f0`: a value of type `A` to be used as default for the returned value.
    - `f`: a value of type `A` to be sent to neighbours.
    - *returns:* a neighbouring field, where the default value coincides with the default of `f0`, and exceptions are the most recent values for the current device sent by neighbours through the `f` they passed on their round (including the previous round of the current devices, if there was one).
    - *equivalent to:* 
      ```
      nbr(CALL, f0, [](to_field<A> fn){
        return make_tuple(fn, f);
      })
      ```
- `A nbr(ARGS, A const& f0, G&& op)`
    - `f0`: a value of type `A` used as a default value for any device in the field of `A` that is produced
    - `op`: a lambda function of type `to_field<A>` → `A`; a neighbouring field of `A` is populated as in the previous form of `nbr`, then a value of type `A` is obtained by applying `op` to such field
    - *returns:* TODO
    - *equivalent to:*
      ```
      nbr(CALL, f0, [](to_field<A> fn){
        A fx = op(fn);
        return make_tuple(fx, fx);
      })
      ```
- `B nbr(ARGS, A const& f0, G&& op)`
    - `f0`: a value of type `A` used as a default value for any device in the field of `A` that is produced
    - `op`: a lambda function of type `to_field<A>` → `tuple<B,A>`; a neighbouring field of `A` is populated as in the previous form of `nbr`, then a tuple with a `B` value and an an `A` value is obtained by applying `op` to such field
    - *returns:* TODO

Note that the first two forms return a `to_field<A>` value, as explained in *Basic types* above, while the 3rd and 4th forms, instead, return a plain `A` (resp. `B`) value. All the returned values can then be used in further computations during the current round. At the end of the round, all forms cause the FCPP library to send to the neighbouring devices the computed `A` value associated with the current device, that for the 1st and 2nd forms is the last argument itself, while for the 3rd and 4th forms is obtained from the result of `op`.

### Coordination library

Presentation of the various coordination headers to ease function lookup.


## System Setup

Work in progress.

### Components and compositions

Component-based architecture; components' list; pre-defined compositions' list.

### Declaration options and initialisation values

The option macro; tagged tuples and the init_v argument.

### Single runs and batch executions

Single run execution pattern; batch::run and batch::make_tagged_tuple_sequence.

### Distributions and sequences

Usage for schedules and spawn inits; general interface and assumptions; generator versions: generic composition, numeric `_n`, input `_i`; summary of available classes.

### Aggregators and logging

Usage of aggregators for logging; general interface; aggregator composition; summary of available classes.

### Connection predicates and metrics

Usage of connection predicates and metrics for simulation; general interface; summary of available classes.

### Plot generation library

Plotter type and usage; basic plots; split and join; custom plots.
