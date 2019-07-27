# Test examples

Installing latest version of a package from Chocolatey.org

```ruby
choco.exe install -fdvy nodejs.install
```

Retesting failing package from Chocolatey.org

```ruby
choco.exe install -fdvy github --version 3.0.11.0
```

After dropping badpackage.1.0.0.nupkg into the packages directory:

```ruby
choco.exe install -fdvy badpackage --source "'c:\\Users\\WDAGUtilityAccount\\Desktop\\chocolatey-test-sandbox\\packages;http://chocolatey.org/api/v2/'"
```
