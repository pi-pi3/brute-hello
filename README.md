# brute-hello

Finally!  An O(n) algorithm for printing any strings in a VT100-compatible
console.  An example is the infamous `"Hello, world!"`-problem, previously
unsolved.

## Building

The building process is simplified to three steps.

### 1. Building musl

Musl is the default libc used by `brute-hello`. To build, follow these steps:

```
cd lib/musl
./configure
make
```

That's it!

### 2. Configuration (optional)

You can choose your configuration with these env args:

`DELAY_SEC` The delay that is needed in each iteration of the algorithm, in
order to prevent the cpu from melting.  Default: `0` (seconds).

`DELAY_NSEC` See above. Default: `5000000` (nanoseconds).

`RANDOM_IGNORE` Improve accuracy by randomly ignoring N + 1 out of every 256
positive results.  We don't want unlucky results, they're definitely false
positives.  Default: `127` (128 out of 256).

Simply type these options after the `make` command in the next step, as
described there.

### 3. Building!

You can choose to build in release mode or debug mode.

To build in debug mode, type:

```
make
```

It's that simple!  Optionally append your custom configuration to the command,
like shown in this example:

```
make RANDOM_IGNORE=200
```

To build in release mode, type:

```
make RELEASE=1
```

Like previously, you can append your custom configuration to the tail of this
command.

## Usage

To use this program, simply type `./hello`, followed by any number of strings
that you would like printed.  For example, if you'd like to see the solution to
the infamous `"Hello, world!"`-problem, type this:

```
./hello 'Hello, world!'
```

## License

Copyright © 2018, Szymon Walter

This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from
the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not
   be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
