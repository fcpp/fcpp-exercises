# FCPP Starting Exercises

Quick-start aggregate computing exercises. The exercises themselves are described in the [run/exercises.cpp](https://github.com/fcpp/fcpp-exercises/blob/master/run/exercises.cpp) file. All commands below are assumed to be issued from the cloned git repository folder. For any issues, please contact [Giorgio Audrito](mailto:giorgio.audrito@unito.it).


## References

- FCPP main website: [https://fcpp.github.io](https://fcpp.github.io).
- FCPP documentation: [http://fcpp-doc.surge.sh](http://fcpp-doc.surge.sh).
- FCPP presentation paper: [http://giorgio.audrito.info/static/fcpp.pdf](http://giorgio.audrito.info/static/fcpp.pdf).
- FCPP sources: [https://github.com/fcpp/fcpp](https://github.com/fcpp/fcpp).


## Setup

The next sections contain the setup instructions for the various supported OSs. Jump to the section dedicated to your system of choice and ignore the others.

### Windows

Pre-requisites:
- [MSYS2](https://www.msys2.org)
- [Asymptote](http://asymptote.sourceforge.io) (for building the plots)

At this point, run "MSYS2 MinGW x64" from the start menu; a terminal will appear. Run the following commands:
```
pacman -Syu
```
After updating packages, the terminal will close. Open it again, and then type:
```
pacman -Sy --noconfirm --needed base-devel mingw-w64-x86_64-toolchain mingw-w64-x86_64-cmake mingw-w64-x86_64-make git
```
The build system should now be available from the "MSYS2 MinGW x64" terminal.

### Linux

Pre-requisites:
- Xorg-dev package (X11)
- G++ 9 (or higher)
- CMake 3.18 (or higher)
- Asymptote (for building the plots)

To install these packages in Ubuntu, type the following command:
```
sudo apt-get install xorg-dev g++ cmake asymptote
```
In Fedora, the `xorg-dev` package is not available. Instead, install the packages:
```
libX11-devel libXinerama-devel.x86_6 libXcursor-devel.x86_64 libXi-devel.x86_64 libXrandr-devel.x86_64 mesa-libGL-devel.x86_64
```
In Arch Linux, you can instead install the packages as follows:
```
sudo pacman -S xorg-server-devel gcc cmake
yay -S asymptote
```

### MacOS

Pre-requisites:
- Xcode Command Line Tools
- CMake 3.18 (or higher)
- Asymptote (for building the plots)

To install them, assuming you have the [brew](https://brew.sh) package manager, type the following commands:
```
xcode-select --install
brew install cmake asymptote
```

### Virtual Machines

If you use a VM with a graphical interface, refer to the section for the operating system installed on it.

**Warning:** the graphical simulations are based on OpenGL, and common Virtual Machine software (e.g., VirtualBox) has faulty support for OpenGL. If you rely on a virtual machine for graphical simulations, it might work provided that you select hardware virtualization (as opposed to software virtualization). However, it is recommended to use the native OS whenever possible.


## Execution

In order to execute the exercises file, type the following command in a terminal:
```
./make.sh gui run -O exercises
```
On newer Mac M1 computers, the `-O` argument may induce compilation errors: in that case, use the `-O3` argument instead.
Running the above command, you should see output about building the executables then the graphical simulation should pop up while the console will show the most recent `stdout` and `stderr` outputs of the application, together with resource usage statistics (both on RAM and CPU).  During the execution, log files will be generated in the `output/` repository sub-folder. If a batch of multiple simulations is launched (which is not the case for the `exercises` target), individual simulation results will be logged in the `output/raw/` subdirectory, with the overall resume in the `output/` directory.

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

  More details on these last two sections are given below.
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

The _Aggregate Program_ section consists of a sequence of definitions: pure C++ functions, auxiliary aggregate functions and a main aggregate function, together with the definition of their _exports_.

### The main aggregate function

Every aggregate program should have a single main aggregate function, which is the starting point of the aggregate program executed in every round by every node in the network. Its body can then issue calls to other aggregate functions, as well as pure C++ functions (see _Function call patterns_ below). The main aggregate function (not to be confused with the *main* function of the C++ application built on top of FCPP) is defined as follows:
```
MAIN() {
   ...
}
```
where `MAIN` is a [macro](http://fcpp-doc.surge.sh/beautify_8hpp.html) defining a callable class `main` with the given body. Besides its special role as program entry point, this function works as any other aggregate function, including the need to define an _export list_ (see _Aggregate function definition and exports_ below). 

### Aggregate function definition and exports

An *aggregate function* (i.e., a function that contains calls to *aggregate operators* or other aggregate functions) must be defined in a special way, compared to a pure C++ function. For non-templated functions, the definition schema is the following:
```
FUN return_type name(ARGS, arguments) { CODE
   ...
}
FUN_EXPORT name_t = export_list<...>;
```
where:
- `return_type` is the return type of the function;
- `name` is the name of the function;
- `arguments` is the list of arguments accepted by the function;
- `FUN`,  `ARGS`, and `CODE` are C++ macros that *instrument* the function to support coordination operators (injecting a reference to the `node` object, and keeping track of the stack frame of function calls to allow automatic alignment of messages);
- conventionally, the function name with an `_t` suffix (using `main_t` for the `MAIN` function) is used to declare the _export list_.

The export list is the sequence of types that are used in the coordination operators appearing in the body of the function. This information is crucial, in order to properly set up the data structures collecting the messages that need to be exchanged. In that list, all the types of the `old`, `nbr` or `oldnbr` (see _Coordination operators_ below) appearing in the body should be included. In addition, for every function call in the body to an aggregate function `aggrfun` an item `aggrfun_t` should also be included, to recursively include the types needed within the body of that function. For instance:
```
FUN_EXPORT main_t = export_list<double, field<int>, abf_hops_t>;
```
declares that the `MAIN` function is directly using coordination operators exchanging information of type either `double` or `field<int>`, in addition to performing a call to the aggregate function `abf_hops`.

Aggregate functions, like pure C++ function, can also be templated to accept different types for their arguments. These are called _generic aggregate functions_, and have the following definition schema:
```
GEN(...) return_type name(ARGS, arguments) { CODE
...
}
GEN_EXPORT name_t = export_list<...>;
```
As you can see, the scheme is almost identical, except that:
- `GEN(...)` is used instead of `FUN`, to declare the parameter types;
- similarly, `GEN_EXPORT` is used instead of `FUN_EXPORT` with the list of relevant parameter types.

In particular, generic types are needed to reliably implement higher-order functions, accepting function arguments. Towards this aim, a further `BOUND( F, R(T...) )` clause can be included to bound the generic type `F` to be callable as a function with given signature `R(T...)`. For instance:
```
GEN(T, F, BOUND( F, T(T,T) )) gossip(ARGS, T value, F&& accumulate) { CODE
...
}
GEN_EXPORT(T) gossip_t = export_list<T>;
```
is the definition of the generic aggregate function [`coordination::gossip`](http://fcpp-doc.surge.sh/collection_8hpp.html). This function accepts a value of a generic type `T` and an accumulating function of a generic type `F`, which needs to be callable with two `T` arguments and return a `T` result.

### Function call patterns

In FCPP, there are different call patterns depending on what is being called. Aggregate functions `f` are called by providing an additional `CALL` argument, as `f(CALL, args...)`. This additional argument is a macro, propagating the reference to the `node` object and providing a counter needed for stack frame update, which is designed to pass the `ARGS` arguments. Aggregate functions include:
- Every user-defined aggregate function, defined through `FUN` and `GEN`;
- Every function in the [`coordination`](http://fcpp-doc.surge.sh/namespacefcpp_1_1coordination.html) namespace;
- Coordination operators `old`, `nbr` and `oldnbr` (see _Coordination operators_ below);
- Aggregate processes with `spawn` (see _Aggregate processes_ below);
- Field modifiers `align`, `align_inplace`, `self`, `mod_self`, `other`, `mod_other` (see _Basic types_ below);
- Field folding functions `fold_hood` and `count_hood` (see _Basic types_ below).

On the other hand, pure C++ functions, class methods, and function objects are generally called `f(args...)` as in basic C++. For instance, this includes:
- STL functions such as [`std::sort`](https://en.cppreference.com/w/cpp/algorithm/sort) and class methods such as [`v.front()`](https://www.cplusplus.com/reference/vector/vector/front/);
- Capturing lambda expressions, even with an aggregate body:
```
[&](field<int> x){ return min_hood(CALL, x); }
```
- Node sensors, which are indeed class methods of the `node` object, such as `node.nbr_uid()`;
- Field mapping functions: generic `map_hood` and `mod_hood`, basic operators on fields (such as `+`, `&&`, etc.), mathematical functions (`mux`, `max`, `min`, `get`, `round`, `floor`, `ceil`, `log`, `exp`, `sqrt`, `pow`, `isinf`, `isnan`, `isfinite`, `isnormal`).

The last point may be surprising, given that all other field operations are instead aggregate and need the `CALL` keyword: however, this is due to the fact that basic operators such as `+` or `*` are applied point-wise on fields by relying on functions `map_hood` and `mod_hood`, and it is impossible to provide the `CALL` keyword to them.

The set of available node sensors may vary depending on the combination of components chosen (see _Components and compositions_ below). The most common are:
- Logical connection handlers such as `node.connected` ([`graph_connector`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1graph__connector_1_1component_1_1node.html) component);
- Neighbour listing through `node.nbr_uid` ([`calculus`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1calculus_1_1component_1_1node.html) component);
- Random generation functions such as `node.next_int` ([`randomizer`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1randomizer_1_1component_1_1node.html) component);
- Storage access through `node.storage` ([`storage`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1storage_1_1component_1_1node.html) component);
- Timing functions such as `node.previous_time` ([`timer`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1timer_1_1component_1_1node.html) component);
- Physical connection handlers such as `node.nbr_dist` ([`hardware_connector`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1hardware__connector_1_1component_1_1node.html) and [`simulated_connector`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1simulated__connector_1_1component_1_1node.html) components);
- Motion handlers such as `node.velocity` ([`simulated_positioner`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1simulated__positioner_1_1component_1_1node.html) component).

In simulated systems, components also provide methods accessing network-wide knowledge through the `node.net` object, such as:
- Other node accessors such as `node.net.node_at` ([`identifier`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1identifier_1_1component_1_1net.html) component);
- Network timers such as `node.net.terminate` ([`timer`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1timer_1_1component_1_1net.html) component);
- Functions modelling obstacles such as `node.closest_space` ([`simulated_map`](http://fcpp-doc.surge.sh/classfcpp_1_1component_1_1simulated__map_1_1component_1_1net.html) component).

### Basic types

FCPP includes few numeric aliases for specific purposes:
- `hops_t` to store hop counts (integer);
- `device_t` to store device identifiers (integer);
- `times_t` to store timestamps (floating point);
- `real_t` to store real numbers (floating point).
The exact sizes of these types depends on the specific configuration under which the library is compiled (for instance, if it is compiled for simulation, or execution on embedded systems, etc.).

Other general purpose types are provided to handle graphics and physics (see the [API reference](http://fcpp-doc.surge.sh/dir_a649fd95b532dff35a9ca005b15ee438.html)):
- `color` to store and manipulate color information;
- `ordered` to add trivial ordering to any given type;
- `shape` to represent drawable shapes;
- `tuple` as a boosted version of `std::tuple`;
- `vec` to store and manipulate physical vectors.
Colors can be generated from their RGBA representation as `color(r, g, b, a)`, from an HSVA representation as `color::hsva(h, s, v, a)` and from an HTML color name as `color(HTML_COLOR_NAME)`. Currently available shapes are tetrahedron, cube, octahedron, icosahedron, sphere and star. Tuples work as `std::tuple`, except that they define point-wise lifting of any operator available on their basic types (for instance, `make_tuple(1,2) + make_tuple(3,4) == make_tuple(4,6)`) and are designed to cohoperate with fields (see below). Operations on vectors include vectorial sum, scalar multiplication, norm and norm-based comparisons (cross product is not defined).   

Finally, the generic `field<T>` type is provided to implement the concept of _neighboring values_: views of values to exchange with neighbours (either from them or for them), implemented as defaulted maps from neighbor UIDs (of type `device_t`) to values (of type `T`). The main operators to access and modify fields are:
- Every operator supported for the base type `T` is lifted to `field<T>` by pointwise application;
- Other field mapping functions, including generic `map_hood` and `mod_hood`, and mathematical functions (`mux`, `max`, `min`, `get`, `round`, `floor`, `ceil`, `log`, `exp`, `sqrt`, `pow`, `isinf`, `isnan`, `isfinite`, `isnormal`);
- Field modifiers: `align`, `align_inplace` (discarding elements from the map), `self`, `mod_self` (accessing the value of the map for the current device), `other`, `mod_other` (accessing the default value of the map);
- Field folding functions: generic `fold_hood` (reducing values of neighbours with a given function) and its specialisations `*_hood` (see [utils.hpp](http://fcpp-doc.surge.sh/utils_8hpp.html) in the API reference).

Every field operator is designed to be applicable to values of basic type `T` as well, and behaves by interpreting them as defaulted empty maps (of type `field<T>` with only the default).

The field class is also designed to interplay with `tuple`, so that a tuple of field can be treated as a field of tuples. For instance, a `fold_hood` can be used to select the lexicographic minimum on an object `make_tuple(node.nbr_dist(), node.nbr_uid(), node.uid)` which is a tuple of two fields and a number. Towards this aim, a template `to_local<T>` is provided which strips fields (which may be nested within tuples) from `T`, so that for instance:
```
to_local<tuple<field<real_t>, field<device_t>, device_t> == tuple<real_t, device_t, device_t>
```
A similar `to_field<T>` is also provided as a shorthand to `field<to_local<T>>`.

FCPP also provides a few more sophisticated types: `bloom` implementing a [bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) and `hyperloglog` implementing an [HyperLogLog counter](https://en.wikipedia.org/wiki/HyperLogLog).

### Coordination operators

FCPP supports the operations peculiar to the *Aggregate Programming* model, allowing to:

- recall values computed in the previous round (`old`)
- share information with neighbours (`nbr`)
- do both things simultanously (`oldnbr`)
- split computation into independent sub-networks (`split`)
- start and manage aggregate processes (`spawn`)

See also the [FCPP presentation paper](http://giorgio.audrito.info/static/fcpp.pdf) and the [API reference](http://fcpp-doc.surge.sh/calculus_8hpp.html) for detailed information. We omit the `oldnbr` and `spawn` construct from this tutorial presentation, the others are detailed as follows.

#### Local history management

The `old` operator comes in four flavors, with increasing level of expressiveness, differing from their argument number and type:

- `A old(ARGS, A const& x)`
    - `x`: a value of type `A` to be stored for the following round.
    - *returns:* the value passed as `x` in the previous round (or the value passed as `x` in the current round, if no value was stored in the previous round).
    - *equivalent to:* `old(CALL, x, x)`
- `A old(ARGS, A const& x0, A const& x)`
    - `x0`: a value of type `A` to be used as default when no stored value is available.
    - `x`: a value of type `A` to be stored for the following round.
    - *returns:* the value passed as `x` in the previous round (or the value passed as `x0` in the current round, if no value was stored in the previous round).
    - *equivalent to:*
      ```
      old(CALL, x0, [](A xo){
        return make_tuple(xo, x);
      })
      ```
- `A old(ARGS, A const& x0, G&& op)`
    - `x0`: a value of type `A` to be used as default when no stored value is available.
    - `op`: a lambda function of type `A` → `A`.
    - *returns:* the value of type `A` returned by the application of `op` to the value returned by `op` in the previous round (or to the value passed as `x0` in the current round, if no value was stored in the previous round).
    - *equivalent to:*
      ```
      old(CALL, x0, [](A xo){
        A y = op(xo);
        return make_tuple(y, y);
      })
      ```
- `B old(ARGS, A const& x0, G&& op)`
    - `x0`: a value of type `A` to be used as default when no stored value is available.
    - `op`: a lambda function of type `A` → `tuple<B,A>`.
    - *returns:* the value of type `B` in the first element of the tuple returned by the application of `op` to the second element of the tuple returned by `op` in the previous round (or to the value passed as `x0` in the current round, if no value was stored in the previous round).

At the end of the round, all forms cause the FCPP library to store the computed `A` value, that for the 1st and 2nd forms is the last argument itself, while for the 3rd and 4th forms is obtained from the result of `op`. When using any of these forms, the corresponding type `A` should be included in the `export_list`.

#### Neighbourhood interaction

Similarly, the `nbr` operator comes in four flavors, with increasing level of expressiveness, differing from their argument number and type:

- `to_field<A> nbr(ARGS, A const& x)`
    - `x`: a value of type `A` to be sent to neighbours.
    - *returns:* a neighbouring field, where the default value coincides with the default of `x`, and custom values are the most recent values for the current device sent by neighbours through the `x` they passed on their round (including the previous round of the current device, if there was one).
    - *equivalent to:* `nbr(CALL, x, x)`
- `to_field<A> nbr(ARGS, A const& x0, A const& x)`
    - `x0`: a value of type `A` to be used as default for the returned value.
    - `x`: a value of type `A` to be sent to neighbours.
    - *returns:* a neighbouring field, where the default value coincides with the default of `x0`, and custom values are the most recent values for the current device sent by neighbours through the `x` they passed on their round (including the previous round of the current device, if there was one).
    - *equivalent to:* 
      ```
      nbr(CALL, x0, [](to_field<A> xn){
        return make_tuple(xn, x);
      })
      ```
- `A nbr(ARGS, A const& x0, G&& op)`
    - `x0`: a value of type `A` to be used as default for the returned value.
    - `op`: a lambda function of type `to_field<A>` → `A`.
    - *returns:* a the value of type `A` returned by the application of `op` to the neighbouring field with a default value coinciding with the default of `x0`, and custom values that are the most recent values for the current device sent by neighbours through the value returned by `op` on their round (including the previous round of the current device, if there was one).
    - *equivalent to:*
      ```
      nbr(CALL, x0, [](to_field<A> xn){
        A y = op(xn);
        return make_tuple(y, y);
      })
      ```
- `B nbr(ARGS, A const& x0, G&& op)`
    - `x0`: a value of type `A` to be used as default for the returned value.
    - `op`: a lambda function of type `to_field<A>` → `tuple<B,A>`.
    - *returns:* a the value of type `B` in the first element of the tuple returned by the application of `op` to the neighbouring field with a default value coinciding with the default of `x0`, and custom values that are the most recent values for the current device sent by neighbours through the second element of the tuple returned by `op` on their round (including the previous round of the current device, if there was one).

Note that the first two forms return a `to_field<A>` value, as explained in *Basic types* above, while the 3rd and 4th forms, instead, return a plain `A` (resp. `B`) value. All the returned values can then be used in further computations during the current round. At the end of the round, all forms cause the FCPP library to send to the neighbouring devices the computed `A` value associated with the current device, that for the 1st and 2nd forms is the last argument itself, while for the 3rd and 4th forms is obtained from the result of `op`. When using any of these forms, the corresponding type `A` should be included in the `export_list`.

#### Network partitioning

It is possible to split the computation into independent sub-networks through the following construct.
```
A split(ARGS, T&& key, G&& op)
```
- `key`: a value of any type identifying the sub-networks.
- `op`: a lambda function of type `()` → `A`.
- *returns:* the value returned by the application of `op`.

In this construct, the application of `op` is performed in isolation on every sub-network depending on the value of `key`. Thus, every communication (with e.g. `nbr`) occurring inside `op` will only consider neighbours sharing the same `key` value, and not those with a different `key` value. Notice that `split` does not require to add any export to the `export_list`.

#### Aggregate processes

FCPP also supports the concept of [_aggregate process_](https://link.springer.com/chapter/10.1007/978-3-031-35361-1_4). An aggregate process is an aggregate function that can be instantiated zero or more times by each device. Each process instance corresponds to a different _process key_, and runs that correspond to different keys do not interact with each other, while evolving in space in time jumping between devices until the _termination_ of the process instance. FCPP features three variations of aggregate processes, all conforming to the following signature:
```
std::unordered_map<K, R, common::hash<K>> spawn(ARGS, G&& process, S&& key_set, Ts const&... xs)
```
- `process`: an aggregate function of type `(K, Ts...)` → `tuple<R,B>`, where `K` is the process key type, `Ts` are the types of extra arguments to be passed to each process instance, `R` is the type of the value returned by the instance, and `B` is the status returned by the instance.
- `key_set`: an interable collection of process keys that the device should run.
- `xs`: extra arguments passed to each process instance.
- *returns:* a map from process keys to the returned values by the instances.

The variations of spawn differ by the status type `B`, which can be:
- `bool`: in which case, `true` means that the process should expand while `false` means that the process should not expand further;
- `field<bool>`: in which case, the neighbouring field dictates to exactly which neighbours the process should expand;
- `status`: in which case, a status of `terminated` can propagate causing the process to terminate, `border` stops the propagation (as `false`), `internal` allows propagation, and variants ending with `_output` cause the value produced to be inserted in the resulting unordered map.

### Coordination library

Several aggregate function of general utility are available in the FCPP standard coordination library, which is grouped in headers with different scope:

- [basics.hpp](http://fcpp-doc.surge.sh/basics_8hpp.html): contains `old`, `nbr`, `spawn`, and other basic aggregate functions that are not defined from other aggregate functions.
- [collection.hpp](http://fcpp-doc.surge.sh/collection_8hpp.html): contains routines to collect information from the network into a single sink point.
- [election.hpp](http://fcpp-doc.surge.sh/election_8hpp.html): contains algorithms for breaking symmetry and electing one or more leaders in a network. 
- [geometry.hpp](http://fcpp-doc.surge.sh/geometry_8hpp.html): contains functions pertaining to movement and physical displacement of devices.
- [spreading.hpp](http://fcpp-doc.surge.sh/spreading_8hpp.html): contains algorithms based on information spreading, such as distance estimation, gossip and broadcast.
- [time.hpp](http://fcpp-doc.surge.sh/time_8hpp.html): contains routines handling the variation of data in time on each device.
- [utils.hpp](http://fcpp-doc.surge.sh/utils_8hpp.html): contains useful aggregate functions of general purpose.


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
