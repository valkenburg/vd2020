# VoidDistances2020

You should be able to build with something like this:

```
cd LLTBBackground/src
make lltbpackage

cd ../../wLLTBBackground/source
make all

cd ../../src
make

```

then run with
```
../bin/vd2020 g 69 0 0.7 -1 -0.4 0.2
```

That's all there is for now, sorry. You will have to dig throught the code, just starting at `driver.f90`, and following the code down the rabbit hole until the find what you need.

Good luck!
