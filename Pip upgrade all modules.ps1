# Upgrade all Pip modules
# catches all modules including those not caught by 'pip freeze'

pip list --outdated | Select-Object -Skip 2 | ForEach-Object {$_.split(' ')[0]} | ForEach-Object {pip install --upgrade $_}
