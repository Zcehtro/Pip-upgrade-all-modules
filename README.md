# Pip-upgrade-all-modules

Simple one-line powershell command that upgrades all pip modules.

- [Pip-upgrade-all-modules](#pip-upgrade-all-modules)
  - [Why?](#why)
  - [Simple solution](#simple-solution)
  - [Worflow explained](#worflow-explained)

## Why?

Most websites online use `pip freeze` and pipe it to upgrade all modules, but freeze doesn't include these modules (output of `pip list --outdated`):

```cmd
Package    Version Latest Type
---------- ------- ------ -----
pip        21.3.1  22.0.4 wheel
setuptools 58.1.0  62.0.0 wheel
wheel      0.37.0  0.37.1 wheel
```

And possibly others.

## Simple solution

Pipe the result of each line in `pip list --outdated`.

````powershell
pip list --outdated | Select-Object -Skip 2 | ForEach-Object {$_.split(' ')[0]} | ForEach-Object {pip install --upgrade $_}
````

Same result with short-hand version:

````powershell
pip list --outdated | select -Skip 2 | % {pip install --upgrade $_.split(' ')[0]}
````

## Worflow explained

1. Get the list of outdated pip modules. (Same list produced)

    ````powershell
    pip list --outdated
    ````

2. List produces a header and line separator. We want to skip those 2 lines. So:

    ````powershell
    Select-Object -Skip 2
    ````

3. Parse the text in each line so that we extract only the names. Using space as a delimiter, we will get the first word in the first element of each array.

    ````powershell
    ForEach-Object {$_.split(' ')[0]}
    ````

4. Pipe the output of the previous step to the command to upgrade said module.

    ````powershell
    ForEach-Object {pip install --upgrade $_}
    ````
